Return-Path: <robherring2@gmail.com>
From: Rob Herring <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Jiri Slaby <jslaby@suse.com>,
	Sebastian Reichel <sre@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Dr . H . Nikolaus Schaller" <hns@goldelico.com>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Peter Hurley <peter@hurleysoftware.com>,
	NeilBrown <neil@brown.name>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/6] serio: serport: add support for buffered write and receive
Date: Wed, 24 Aug 2016 18:24:35 -0500
Message-Id: <20160824232437.9446-6-robh@kernel.org>
In-Reply-To: <20160824232437.9446-1-robh@kernel.org>
References: <20160824232437.9446-1-robh@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

A tty ldisc naturally supports writing a buffer at a time, so convert the
serport driver to use the serio write_buf() function. For clients using
the existing interfaces, there is no change in functionality.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/input/serio/serport.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index a938c2b..5572c28 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -45,10 +45,10 @@ struct serport {
  * Callback functions from the serio code.
  */
 
-static int serport_serio_write(struct serio *serio, unsigned char data)
+static int serport_serio_write_buf(struct serio *serio, const unsigned char *data, size_t len)
 {
 	struct serport *serport = serio->port_data;
-	return -(serport->tty->ops->write(serport->tty, &data, 1) != 1);
+	return serport->tty->ops->write(serport->tty, data, len);
 }
 
 static int serport_serio_open(struct serio *serio)
@@ -133,26 +133,29 @@ static void serport_ldisc_receive(struct tty_struct *tty, const unsigned char *c
 	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
 		goto out;
 
-	for (i = 0; i < count; i++) {
-		if (fp) {
-			switch (fp[i]) {
-			case TTY_FRAME:
-				ch_flags = SERIO_FRAME;
-				break;
-
-			case TTY_PARITY:
-				ch_flags = SERIO_PARITY;
-				break;
-
-			default:
-				ch_flags = 0;
-				break;
+	if (serio_buffered_mode_enabled(serport->serio)) {
+		serio_receive_buf(serport->serio, cp, count);
+	} else {
+		for (i = 0; i < count; i++) {
+			if (fp) {
+				switch (fp[i]) {
+				case TTY_FRAME:
+					ch_flags = SERIO_FRAME;
+					break;
+
+				case TTY_PARITY:
+					ch_flags = SERIO_PARITY;
+					break;
+
+				default:
+					ch_flags = 0;
+					break;
+				}
 			}
-		}
 
-		serio_interrupt(serport->serio, cp[i], ch_flags);
+			serio_interrupt(serport->serio, cp[i], ch_flags);
+		}
 	}
-
 out:
 	spin_unlock_irqrestore(&serport->lock, flags);
 }
@@ -179,7 +182,7 @@ static ssize_t serport_ldisc_read(struct tty_struct * tty, struct file * file, u
 	snprintf(serio->phys, sizeof(serio->phys), "%s/serio0", tty_name(tty));
 	serio->id = serport->id;
 	serio->id.type = SERIO_RS232;
-	serio->write = serport_serio_write;
+	serio->write_buf = serport_serio_write_buf;
 	serio->open = serport_serio_open;
 	serio->close = serport_serio_close;
 	serio->port_data = serport;
-- 
2.9.3
