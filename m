Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20E0221F2F
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788484835; cv=none; b=flO+j+zlV5vY3soQ/TzxKrHrHYScJP9l4mCXJDy/P5kVlLpq75byIC3HbDcXc/1nVeJTyOD1dE3XV7p4UBCkgQcPTzuCF7x0nEC4TSSdJ8kMmtECSjkb5FB7nRpTDDH06BLOtmYQNFEmZwrHK6D4CkyFqhtkRHfMtprq0D0CaRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788484835; c=relaxed/simple;
	bh=1QelEwIJoyX4RIohNHqaWm/A7yAkYc8mb1sw7dBCzus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axzLJaltp7clGQsLyUJ83FzzLxSAaZ2URSSlJ8dEoBfoC2b4iUvmpR+P1nPMkfILTqkU8RCxHRQ42PT7IvkR8/5uSDpwuMvKPSCHZV61BxgxoZ7LQCcSOpJ0WfyacKGT2ZwERDmTOT/uJAr/tsRzsMZJYXm7evLPtlDeUcerUKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z83pcL4e; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z83pcL4e"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so546292a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 18:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788484832; x=1789089632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b14eGL8N5nmOiZXVHg8S+JBuSRaDNLLRVrrk6X0ilfE=;
        b=Z83pcL4elr3Bnd45zSiUpRw5Ki25m1jrJ3uZBxl+6RcE6x8BugCnm3thwP+znTmHaW
         Js7O0zDSdf5HL25AOT9PzeNHiIr6BlyewIBKDvtcqAub7roc3ZsahFFrOkoXP91BcAR1
         fMQkKsEh+NZH/3ipzGB938AOfGejZeDHbdLEOux8FBqJIZbw/dSzF2mVh0rxgZLnqzCs
         cBqJgZwzp4BE+idq3egFcb8sBW48zQaQlEHK4O+IbTTZhTw1alZjbFEKCcj2eTq5TG/F
         L7vv9Ppd9tvfqj7U4MJjj1vBWXCektB11QDQoYtTEcVSZ8OcJjv1SqbF1jMAR/E6cfx/
         tqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788484832; x=1789089632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b14eGL8N5nmOiZXVHg8S+JBuSRaDNLLRVrrk6X0ilfE=;
        b=H0oxUrtX0n6yj5jqbaYfEi2SWqs/VfuUgAuOdAaaZ34kAPUpHb6NLbas9c+4A9rxGT
         LF2aX1lx8T2IxJYauVPX627kQzh8jCJR64inzxxmj3jhJflb1YUpY1kVJrvFkE3ZepLc
         bf5t23AbU1e6AQ7lCrObrI2RqpFHXuGdppOMoAfgISoj/M8ZY8LK4KxrAu6WYWeqaXuG
         PhJROyfjtS0i4o9gJMyjX7Pd9HQZDkVpxvMbg0Ky2x9e9ms/1WdLpMa4qL32XVfaOwOB
         QKI4guWM4G9DrbjzbhRV90ubi71xHXbed+gwRQJpvUDzXcl63Z/P+I7wc1lvZycL1oQN
         MhMw==
X-Forwarded-Encrypted: i=1; AKwUvBzVjMeyidK2ReErvqW2WW1oWWZJymFb6Ae9Y1tzrbEf0yV1JYfdXF7a82DrEYZjWOnj3i6VrNTCI/L7UoTA9AI=@vger.kernel.org
X-Gm-Message-State: AFuF++kUfvjY28cg+F727eWzyKlOGCBdelI8HLdLkuUK9YVUBWqGABY9
	g90os5P+byomuBDsq8pqGn7OjahbAnbehxwWIGYGiKZBFg9ctxVT3uHu
X-Gm-Gg: AYBFou27FbvCDmyWj+Xt1ggQMHk8NyYK3F57SyRLKnbOjSmfqH5VzCtNo2pWw2VuTtJ
	IPY39nj0OB919EXEDWdsWjPujfeRzYrdiaruxFXkSJgNFTWEtCjujkz+Q3NgN2rXYloLjvepNnN
	x5IvXN7hEFC98bmYVY+Zj+Yvn6K1nUyN1IhqKwf40nbvgVjQNfPpzfFor44vFccBGzLwRj+RD/a
	sMeTxnqPphLLvdHq+7EiiMdIFncgXtVOGXK4GdfCdMTqeKtlkg29+2wqcfQ2WcUlcb9q8I6ST2P
	m0MQVvs5GHukzDkkyx6eG+JUC6+bsWpmbdJ0oyy8T5jJ91ANegOdFKdGehajaB4X+gvTF2RfJvs
	7wmPjGg/OJzjUpiKCdkaewKDL46O4wm+v+B8n43vGXbNONIjXcbVqdngl6DXasrDj2m2Md9I2jt
	F118Kaub3VRwAjD09kAujzpfccqcuWIBW3JpbWLT3DN7k+MT+qReyJI36wuD9miaIfZdF6g4wVt
	1XFdvB+gMSyBeYdzP92pkhuN+uI+I17VzboKTzTgUL7wXyKM5iZ0kOP7qF4
X-Received: by 2002:a05:6402:380a:b0:6a6:32fa:1e9d with SMTP id 4fb4d7f45d1cf-6a7e90d5896mr1059464a12.21.1788484831992;
        Thu, 03 Sep 2026 18:20:31 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6bf3370sm465774a12.27.2026.09.03.18.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 18:20:30 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: nicoyip.dev@gmail.com,
	pav@iki.fi,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
Subject: [PATCH v2] Bluetooth: RFCOMM: defer security confirmation to krfcommd
Date: Fri,  4 Sep 2026 06:20:28 +0500
Message-ID: <20260904012028.77590-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902235132.453044-1-mikhail.v.gavrilov@gmail.com>
References: <20260902235132.453044-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An RFCOMM connect() issued while a BR/EDR link is being authenticated
makes lockdep report a circular dependency, and the reported cycle is a
real AB/BA between rfcomm_mutex and hdev->lock.

rfcomm_security_cfm() is called from the HCI event path, which already
holds hdev->lock:

  hci_rx_work()
    hci_event_packet()
      hci_cc_read_enc_key_size()   [hdev->lock]
        hci_encrypt_cfm()          [hci_cb_list_lock]
          rfcomm_security_cfm()    [rfcomm_mutex]

while an RFCOMM connect() from userspace takes the same two locks the
other way round:

  rfcomm_sock_connect()
    rfcomm_dlc_open()              [rfcomm_mutex]
      __rfcomm_dlc_open()
        rfcomm_session_create()
          kernel_connect()
            l2cap_sock_connect()
              l2cap_chan_connect() [hdev->lock]

  WARNING: possible circular locking dependency detected
  kworker/u131:1/1128 is trying to acquire lock:
  rfcomm_mutex, at: rfcomm_security_cfm+0x31/0x3e0 [rfcomm]
  but task is already holding lock:
  hci_cb_list_lock, at: hci_cc_read_enc_key_size+0x1d2/0xcc0
  Chain exists of:
    rfcomm_mutex --> &hdev->lock --> hci_cb_list_lock

hci_auth_complete_evt() and hci_encrypt_change_evt() reach the callback
the same way.

Both orders have to be seen in the same boot, which is why a BR/EDR
connection alone is not enough to show it: a session set up by the
remote side is created by rfcomm_accept_connection() in krfcommd, which
calls kernel_accept() and never takes hdev->lock under rfcomm_mutex.
Connecting a device that authenticates and encrypts the link and then
calling connect() on an RFCOMM socket towards any address - the connect
does not have to succeed, the order is recorded before the page timeout
- reports it every time.

The callback does not have to run in the HCI event context at all: it
only updates DLC flags and timers that krfcommd consumes in
rfcomm_process_dlcs(), and it already ends with rfcomm_schedule().  So
queue the confirmation instead of taking rfcomm_mutex from the HCI
event path, and let krfcommd apply it under rfcomm_mutex on its next
pass, ahead of session processing.

The queued entry pins both the connection and the controller, and
krfcommd takes hdev->lock while applying it, so the lookup and
hci_conn_check_secure() run in the same context as before.  A session
that was torn down and set up again while the confirmation was queued
runs over a different hci_conn and is skipped.  A confirmation that
cannot be allocated is dropped and the DLC closes on its auth timeout.

Fixes: 759c185d0bbd ("Bluetooth: RFCOMM: serialize security confirmation handling")
Reported-by: Pauli Virtanen <pav@iki.fi>
Closes: https://lore.kernel.org/linux-bluetooth/5e76a95e934e451e7006db28827c2d64af5a88be.camel@iki.fi/
Reported-by: syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-bluetooth/6a92fadc.08e933ee.dbf97.008f.GAE@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

The commit this fixes is in v7.3-rc1 and is marked for stable, so this
probably wants the bluetooth fixes tree rather than -next.

v1: https://lore.kernel.org/linux-bluetooth/20260902235132.453044-1-mikhail.v.gavrilov@gmail.com/

v2:
 - free queued confirmations from rfcomm_init() and rfcomm_exit() after
   hci_unregister_cb(), instead of at the end of rfcomm_run(); the init
   error path stops the thread before unregistering the callback, so
   the old placement leaked there
 - pin the controller too and take hdev->lock while the confirmation is
   applied, so conn->sec_level is read in the same context as before
 - skip a session that runs over a different hci_conn than the one the
   confirmation was reported for
 - context-analysis annotations for security_cfm_list and
   __rfcomm_security_cfm(); not verified with clang, done by inspection
 - the reproducer below now uses spaces, gitlint tripped over the tabs

Tested on 7.3.0-rc1 with an MT7922 controller (btusb).  Without the
patch the steps above report the inversion on every run.  With v2
applied the reproducer leaves the validator armed and silent
(debug_locks: 1), and a 2.5 hour session with three BR/EDR headsets
(soundcore Liberty 5, FIIO UTWS17, JBL Tour Pro 3), HFP/SCO audio and
AVRCP produced no lockdep report.

The connect() side used for testing, so that it does not depend on which
end sets up the HFP session:

  #include <stdint.h>
  #include <string.h>
  #include <unistd.h>
  #include <sys/socket.h>

  #define BTPROTO_RFCOMM 3

  struct sockaddr_rc {
      unsigned short  rc_family;
      uint8_t         rc_bdaddr[6];   /* little endian */
      uint8_t         rc_channel;
  };

  int main(void)
  {
      struct sockaddr_rc addr = { .rc_family = AF_BLUETOOTH,
                                  .rc_channel = 1 };
      int fd = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

      memcpy(addr.rc_bdaddr, "\x55\x44\x33\x22\x11\x00", 6);
      connect(fd, (struct sockaddr *)&addr, sizeof(addr));
      close(fd);
      return 0;
  }

 net/bluetooth/rfcomm/core.c | 178 ++++++++++++++++++++++++++++--------
 1 file changed, 140 insertions(+), 38 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index f7463f092283..246c811dfca1 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -49,6 +49,18 @@ static DEFINE_MUTEX(rfcomm_mutex);
 
 static LIST_HEAD(session_list);
 
+/* Security confirmations handed over from the HCI event handler to krfcommd */
+struct rfcomm_sec_cfm {
+	struct list_head	list;
+	struct hci_dev		*hdev;
+	struct hci_conn		*conn;
+	u8			status;
+	u8			encrypt;
+};
+
+static DEFINE_SPINLOCK(security_cfm_lock);
+static __guarded_by(&security_cfm_lock) LIST_HEAD(security_cfm_list);
+
 static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len);
 static int rfcomm_send_sabm(struct rfcomm_session *s, u8 dlci);
 static int rfcomm_send_disc(struct rfcomm_session *s, u8 dlci);
@@ -2122,6 +2134,117 @@ static void rfcomm_process_sessions(void)
 	rfcomm_unlock();
 }
 
+static void rfcomm_sec_cfm_free(struct rfcomm_sec_cfm *cfm)
+{
+	hci_conn_put(cfm->conn);
+	hci_dev_put(cfm->hdev);
+	kfree(cfm);
+}
+
+static struct hci_conn *rfcomm_session_hcon(struct rfcomm_session *s)
+{
+	struct l2cap_conn *conn = l2cap_pi(s->sock->sk)->chan->conn;
+
+	return conn ? conn->hcon : NULL;
+}
+
+static void __rfcomm_security_cfm(struct rfcomm_sec_cfm *cfm)
+	__must_hold(&rfcomm_mutex)
+{
+	struct rfcomm_session *s;
+	struct rfcomm_dlc *d, *n;
+
+	s = rfcomm_session_get(&cfm->hdev->bdaddr, &cfm->conn->dst);
+	if (!s)
+		return;
+
+	/* The confirmation belongs to the link it was reported for.  A
+	 * session that was torn down and set up again in the meantime runs
+	 * over a different connection and must not be judged by it.
+	 */
+	if (rfcomm_session_hcon(s) != cfm->conn)
+		return;
+
+	list_for_each_entry_safe(d, n, &s->dlcs, list) {
+		if (test_and_clear_bit(RFCOMM_SEC_PENDING, &d->flags)) {
+			rfcomm_dlc_clear_timer(d);
+			if (cfm->status || cfm->encrypt == 0x00) {
+				set_bit(RFCOMM_ENC_DROP, &d->flags);
+				continue;
+			}
+		}
+
+		if (d->state == BT_CONNECTED && !cfm->status &&
+		    cfm->encrypt == 0x00) {
+			if (d->sec_level == BT_SECURITY_MEDIUM) {
+				set_bit(RFCOMM_SEC_PENDING, &d->flags);
+				rfcomm_dlc_set_timer(d, RFCOMM_AUTH_TIMEOUT);
+				continue;
+			} else if (d->sec_level == BT_SECURITY_HIGH ||
+				   d->sec_level == BT_SECURITY_FIPS) {
+				set_bit(RFCOMM_ENC_DROP, &d->flags);
+				continue;
+			}
+		}
+
+		if (!test_and_clear_bit(RFCOMM_AUTH_PENDING, &d->flags))
+			continue;
+
+		if (!cfm->status && hci_conn_check_secure(cfm->conn,
+							  d->sec_level))
+			set_bit(RFCOMM_AUTH_ACCEPT, &d->flags);
+		else
+			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
+	}
+}
+
+static void rfcomm_process_security_cfm(void)
+{
+	struct rfcomm_sec_cfm *cfm, *n;
+	LIST_HEAD(cfm_list);
+
+	spin_lock(&security_cfm_lock);
+	list_splice_init(&security_cfm_list, &cfm_list);
+	spin_unlock(&security_cfm_lock);
+
+	if (list_empty(&cfm_list))
+		return;
+
+	rfcomm_lock();
+
+	list_for_each_entry_safe(cfm, n, &cfm_list, list) {
+		/* Restores the context the callback used to run in, so that
+		 * hci_conn_check_secure() sees a stable sec_level.
+		 */
+		hci_dev_lock(cfm->hdev);
+		__rfcomm_security_cfm(cfm);
+		hci_dev_unlock(cfm->hdev);
+
+		list_del(&cfm->list);
+		rfcomm_sec_cfm_free(cfm);
+	}
+
+	rfcomm_unlock();
+}
+
+/* Drops confirmations that krfcommd will not get to any more.  Called once
+ * the HCI callback is unregistered and the thread is gone.
+ */
+static void rfcomm_flush_security_cfm(void)
+{
+	struct rfcomm_sec_cfm *cfm, *n;
+	LIST_HEAD(cfm_list);
+
+	spin_lock(&security_cfm_lock);
+	list_splice_init(&security_cfm_list, &cfm_list);
+	spin_unlock(&security_cfm_lock);
+
+	list_for_each_entry_safe(cfm, n, &cfm_list, list) {
+		list_del(&cfm->list);
+		rfcomm_sec_cfm_free(cfm);
+	}
+}
+
 static int rfcomm_add_listener(bdaddr_t *ba)
 {
 	struct sockaddr_l2 addr;
@@ -2201,6 +2324,7 @@ static int rfcomm_run(void *unused)
 	while (!kthread_should_stop()) {
 
 		/* Process stuff */
+		rfcomm_process_security_cfm();
 		rfcomm_process_sessions();
 
 		wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
@@ -2214,50 +2338,25 @@ static int rfcomm_run(void *unused)
 
 static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 {
-	struct rfcomm_session *s;
-	struct rfcomm_dlc *d, *n;
+	struct rfcomm_sec_cfm *cfm;
 
 	BT_DBG("conn %p status 0x%02x encrypt 0x%02x", conn, status, encrypt);
 
-	rfcomm_lock();
-
-	s = rfcomm_session_get(&conn->hdev->bdaddr, &conn->dst);
-	if (!s) {
-		rfcomm_unlock();
+	cfm = kmalloc_obj(*cfm);
+	if (!cfm)
 		return;
-	}
-
-	list_for_each_entry_safe(d, n, &s->dlcs, list) {
-		if (test_and_clear_bit(RFCOMM_SEC_PENDING, &d->flags)) {
-			rfcomm_dlc_clear_timer(d);
-			if (status || encrypt == 0x00) {
-				set_bit(RFCOMM_ENC_DROP, &d->flags);
-				continue;
-			}
-		}
-
-		if (d->state == BT_CONNECTED && !status && encrypt == 0x00) {
-			if (d->sec_level == BT_SECURITY_MEDIUM) {
-				set_bit(RFCOMM_SEC_PENDING, &d->flags);
-				rfcomm_dlc_set_timer(d, RFCOMM_AUTH_TIMEOUT);
-				continue;
-			} else if (d->sec_level == BT_SECURITY_HIGH ||
-				   d->sec_level == BT_SECURITY_FIPS) {
-				set_bit(RFCOMM_ENC_DROP, &d->flags);
-				continue;
-			}
-		}
 
-		if (!test_and_clear_bit(RFCOMM_AUTH_PENDING, &d->flags))
-			continue;
-
-		if (!status && hci_conn_check_secure(conn, d->sec_level))
-			set_bit(RFCOMM_AUTH_ACCEPT, &d->flags);
-		else
-			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
-	}
+	/* hci_conn drops its own reference on hdev once it is deleted, so
+	 * both objects are pinned until krfcommd is done with them.
+	 */
+	cfm->hdev = hci_dev_hold(conn->hdev);
+	cfm->conn = hci_conn_get(conn);
+	cfm->status = status;
+	cfm->encrypt = encrypt;
 
-	rfcomm_unlock();
+	spin_lock(&security_cfm_lock);
+	list_add_tail(&cfm->list, &security_cfm_list);
+	spin_unlock(&security_cfm_lock);
 
 	rfcomm_schedule();
 }
@@ -2333,6 +2432,7 @@ static int __init rfcomm_init(void)
 
 unregister:
 	hci_unregister_cb(&rfcomm_cb);
+	rfcomm_flush_security_cfm();
 
 	return err;
 }
@@ -2345,6 +2445,8 @@ static void __exit rfcomm_exit(void)
 
 	kthread_stop(rfcomm_thread);
 
+	rfcomm_flush_security_cfm();
+
 	rfcomm_cleanup_ttys();
 
 	rfcomm_cleanup_sockets();
-- 
2.55.0

