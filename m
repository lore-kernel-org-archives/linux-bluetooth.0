Return-Path: <cyrus@holtmann.org>
Message-ID: <550052CA.20407@ubnt.com>
Date: Wed, 11 Mar 2015 16:35:54 +0200
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] core/gatt-database: Fix memory corruption
References: <550043CD.7080202@ubnt.com> <CABBYNZLW19LcNQerGUa+U0DTn26HR9LpMqi2=RcPHwiFCHbC9g@mail.gmail.com>
In-Reply-To: <CABBYNZLW19LcNQerGUa+U0DTn26HR9LpMqi2=RcPHwiFCHbC9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pointer to on-stack variable was returned from pending_write_new.

#0  0x00007ffff72047b0 in __memmove_ssse3 () from /usr/lib/libc.so.6
#1  0x00007ffff78ae440 in ?? () from /usr/lib/libdbus-1.so.3
#2  0x00007ffff78ad7cc in ?? () from /usr/lib/libdbus-1.so.3
#3  0x00007ffff789ac46 in ?? () from /usr/lib/libdbus-1.so.3
#4  0x00000000004720e8 in write_setup_cb (iter=0x7fffffffe710,
user_data=0x76c2a0) at src/gatt-database.c:1516
#5  0x00000000004b7b4c in g_dbus_proxy_method_call (proxy=0x75ade0,
method=0x4e1747 "WriteValue", setup=0x472088 <write_setup_cb>,
    function=0x4720fd <write_reply_cb>, user_data=0x76c2a0,
destroy=0x471f28 <pending_op_free>) at gdbus/client.c:875
#6  0x000000000047235f in send_write (attrib=0x764e00, proxy=0x75ade0,
owner_queue=0x764250, id=1, value=0x767ff3 "\001\377\177", len=1)
    at src/gatt-database.c:1597
#7  0x0000000000472bdf in chrc_write_cb (attrib=0x764e00, id=1,
offset=0, value=0x767ff3 "\001\377\177", len=1, opcode=82 'R',
att=0x7606d0,
    user_data=0x7641d0) at src/gatt-database.c:1865
#8  0x00000000004c96f2 in gatt_db_attribute_write (attrib=0x764e00,
offset=0, value=0x767ff3 "\001\377\177", len=1, opcode=82 'R',
att=0x7606d0,
    func=0x4c53c8 <write_complete_cb>, user_data=0x772320) at
src/shared/gatt-db.c:1570
#9  0x00000000004c5609 in write_cb (opcode=82 'R', pdu=0x767ff1,
length=3, user_data=0x7630e0) at src/shared/gatt-server.c:796
#10 0x00000000004bdb35 in handle_notify (att=0x7606d0, opcode=82 'R',
pdu=0x767ff1 "\f", pdu_len=3) at src/shared/att.c:768
#11 0x00000000004bddc9 in can_read_data (io=0x7607a0,
user_data=0x7606d0) at src/shared/att.c:849
#12 0x00000000004c9c44 in watch_callback (channel=0x7607d0,
cond=G_IO_IN, user_data=0x760940) at src/shared/io-glib.c:170
#13 0x00007ffff7b1662d in g_main_context_dispatch () from
/usr/lib/libglib-2.0.so.0
#14 0x00007ffff7b16a08 in ?? () from /usr/lib/libglib-2.0.so.0
#15 0x00007ffff7b16d32 in g_main_loop_run () from
/usr/lib/libglib-2.0.so.0
#16 0x0000000000466ba1 in main (argc=1, argv=0x7fffffffec38) at
src/main.c:661
---
 src/gatt-database.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 35f8471..ee24618 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -118,7 +118,7 @@ struct pending_op {
 	unsigned int id;
 	struct gatt_db_attribute *attrib;
 	struct queue *owner_queue;
-	void *setup_data;
+	struct iovec write_data;
 };
 
 struct device_state {
@@ -1509,12 +1509,11 @@ error:
 static void write_setup_cb(DBusMessageIter *iter, void *user_data)
 {
 	struct pending_op *op = user_data;
-	struct iovec *iov = op->setup_data;
 	DBusMessageIter array;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
 	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
-						&iov->iov_base, iov->iov_len);
+						&op->write_data.iov_base, op->write_data.iov_len);
 	dbus_message_iter_close_container(iter, &array);
 }
 
@@ -1561,19 +1560,17 @@ static struct pending_op *pending_write_new(struct queue *owner_queue,
 					size_t len)
 {
 	struct pending_op *op;
-	struct iovec iov;
 
 	op = new0(struct pending_op, 1);
 	if (!op)
 		return NULL;
 
-	iov.iov_base = (uint8_t *) value;
-	iov.iov_len = len;
+	op->write_data.iov_base = (uint8_t *) value;
+	op->write_data.iov_len = len;
 
 	op->owner_queue = owner_queue;
 	op->attrib = attrib;
 	op->id = id;
-	op->setup_data = &iov;
 	queue_push_tail(owner_queue, op);
 
 	return op;
-- 
1.9.1


