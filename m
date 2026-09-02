Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0989543CE65
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 23:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788393100; cv=none; b=i9GemoL38jqItX1wKPcKyoCAwQWfPUyJ62VdvQNEacl001AMon3WCGIt71UHocLbyRdcFpYXN2T4iuaZY/Qyuee0Zo+mVYVlWa09VJX0l0Qiidf+CXYFJ0ei0oHBbLEfwAZv6LlR/YzQec5b1yJErRoI2n71yoeHIhum3sup8Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788393100; c=relaxed/simple;
	bh=eU/uuLi+YQs2Rn97dRNDHCdEe+FCw/ffG1yyOjwjsOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nNxOeGQMx3evzJry7Y1r+ODoONQiLd0HX2OXYuCP29szh8doezVLjBnbaNORcs9Zbe1Wx56UNkBKrp3RGpfUzB7YgNV7yEwQdI7oNKHO8Wx2uqt+Ollvzhj2MaGoPgZe+10AlVOQ4pEQcknfsw6IzLhggw4hX5YAjJiucsd6Wb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqGvWXt6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqGvWXt6"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c20e70a0962so216290166b.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 16:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788393097; x=1788997897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jYXtLBALPx9e/T0GAHUCf/DAFQqv12WcNJ3RrRvs8YQ=;
        b=mqGvWXt6nZX+7GObf4XVaBBoad9n8onbUMqfqVlq1S+pIjm+7qLTCMbvp+DAjKxOZx
         DciB/0LiKdHVfPwm8+v5/8b2Tsjb03nHTDDlthabQbgtr8xiOZpVvW8NqMX3wNyBCD8o
         DFWCDhg8zaPUhZ7h1dKK0HhgbUVeqVuxGHVMAxH0lMn94VT5QQ55JGemCk9Mlx52KFBA
         WdGGKwKgCxLtpzIPLdDtGRrN1sQ0FCMVfUrZHwoYJVQBbEFoR2NL7daSoxxHLDzmCgOn
         YYZGBqIBlM4HdLvDdvXV6n97Un4DXe+x19TvwHpXBxaN5GqL9vCajfhb3V+bdWoYjcNa
         akQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788393097; x=1788997897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jYXtLBALPx9e/T0GAHUCf/DAFQqv12WcNJ3RrRvs8YQ=;
        b=QQzd8MD6fQh3v/HNwsMAnmrQmyeIJwKSu8JGQntvCmhrq9BTTe2gx9clYqL0YYbcmg
         FgtVA47rGTKX7PMVBCM7hS8kXo3YNLKrBt3Sx4+/a94EGWmwVlhy1KSrqnntx3g/z/IW
         eGgcl3/r2ipM6/hRrnI3W+X1inHJyma5gs6Z2Ol1dNkQZlX+gUQxAYv/ucyWTVz4Vqma
         wKyJMPTSZ9rIuc1XI5NhHZL8J0R4JQY9UjAuPVzs4FyMOBPPsdNdfFeDVfyVi+vepBZM
         DVmvx9ysj7Rzu+5/+ZkiB4888nbw3GI2Moqn3iKp+9XCrvC7XxHGuvYQvXPfb/xEA4KD
         o65A==
X-Forwarded-Encrypted: i=1; AKwUvBx8o0Ob6ladBRNbe5znQo8OU+EgfYyTW4GZ0HqvOoz6tAhtsKel3emtTfPSl/GqYKTiBhio2RqtuVrEwt9svuI=@vger.kernel.org
X-Gm-Message-State: AFuF++kWthi+/2iuuRvSXFqS1iBzpO9g1Tvw/kpaG2KBzKEUUoL7dFlH
	LKhHQc1diavWbftRPpe5yu+gaujKYiKh7Y4PFxeFhc059sRz7+f8FtFo
X-Gm-Gg: AYBFou2qFCrNKvqmplwzm3oWbPpXnu5uGQlC+8+YZSrzRV5140LuzofPG9TY9U2xKx9
	dLsKfPlKeMZV3jVMM5QZAEW/CmxLxD5aa3SX/AheTbM0+vVP8ebfbm3BYyjKFDcY2B3aJop2V82
	QKf5C8vRegjJDZxgYdEvdYNQm/tCPmNYwimytJ5M31Nprtb1f1fA0EY0NoL6mCs29U0M4+E1qyL
	iMBil6IX7NuNb/GJECopi7kZVUBO6FRTLhTRaRuW/7YsxaoEGAKiuotUfclTwV4e88hKfPX+vJ5
	+zFi0Lh+fmgFaWIfQnkZGHGMjxXCS2DKmdg7Ja1erDopx/cmHKkE83YnVi3qM30Ryvmf96zYGvn
	zxppj2lEMNaelwNseuuMK9vS7ThMFArUCXTIHskWnoQGX8qXJBgzAOm4dbmEb6Y+P0iKboYb8yD
	fi/3/hV1LzQrNgSmGHNQsUDKE7qpQWqgT+VMlshcSz3nbWDfF95kV7Tky2BfBvF9iXSAldRIvHm
	eaFWP/HMfLyH4oFa1YkQICv0+nUiD83vgXHfaef8CDRm121NZDWTb6y52jb
X-Received: by 2002:a17:907:944c:b0:c20:1bc5:7002 with SMTP id a640c23a62f3a-c25d53bd46amr521088466b.3.1788393097047;
        Wed, 02 Sep 2026 16:51:37 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f4230f80sm22077666b.51.2026.09.02.16.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:51:35 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: nicoyip.dev@gmail.com,
	pav@iki.fi,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: RFCOMM: defer security confirmation to krfcommd
Date: Thu,  3 Sep 2026 04:51:32 +0500
Message-ID: <20260902235132.453044-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
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
pass, ahead of session processing.  The queued entry carries the local
address and a reference on the connection, so the session lookup and
hci_conn_check_secure() stay valid without hdev->lock.  A confirmation
that cannot be allocated is dropped and the DLC closes on its auth
timeout.

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

Tested on 7.3.0-rc1 with an MTK MT7921 controller (btusb) and a JBL
Tour Pro 3 headset.  Without this patch the steps above report the
inversion on every run.  With it applied the reproducer leaves the
validator armed and silent (debug_locks: 1), and a 5.5 hour session
with four headset connects, HFP/SCO audio and AVRCP produced no
lockdep report either.

The connect() side used for testing, so that it does not depend on which
end sets up the HFP session:

  #include <stdint.h>
  #include <string.h>
  #include <unistd.h>
  #include <sys/socket.h>

  #define BTPROTO_RFCOMM 3

  struct sockaddr_rc {
	unsigned short	rc_family;
	uint8_t		rc_bdaddr[6];	/* little endian */
	uint8_t		rc_channel;
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

 net/bluetooth/rfcomm/core.c | 139 ++++++++++++++++++++++++++----------
 1 file changed, 100 insertions(+), 39 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index f7463f092283..728a6bd2986b 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -49,6 +49,18 @@ static DEFINE_MUTEX(rfcomm_mutex);
 
 static LIST_HEAD(session_list);
 
+/* Security confirmations handed over from the HCI event handler to krfcommd */
+struct rfcomm_sec_cfm {
+	struct list_head	list;
+	struct hci_conn		*conn;
+	bdaddr_t		src;
+	u8			status;
+	u8			encrypt;
+};
+
+static LIST_HEAD(security_cfm_list);
+static DEFINE_SPINLOCK(security_cfm_lock);
+
 static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len);
 static int rfcomm_send_sabm(struct rfcomm_session *s, u8 dlci);
 static int rfcomm_send_disc(struct rfcomm_session *s, u8 dlci);
@@ -2122,6 +2134,73 @@ static void rfcomm_process_sessions(void)
 	rfcomm_unlock();
 }
 
+/* Must be called with rfcomm_mutex held */
+static void __rfcomm_security_cfm(struct rfcomm_sec_cfm *cfm)
+{
+	struct rfcomm_session *s;
+	struct rfcomm_dlc *d, *n;
+
+	s = rfcomm_session_get(&cfm->src, &cfm->conn->dst);
+	if (!s)
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
+		__rfcomm_security_cfm(cfm);
+		list_del(&cfm->list);
+		hci_conn_put(cfm->conn);
+		kfree(cfm);
+	}
+
+	rfcomm_unlock();
+}
+
 static int rfcomm_add_listener(bdaddr_t *ba)
 {
 	struct sockaddr_l2 addr;
@@ -2201,12 +2280,18 @@ static int rfcomm_run(void *unused)
 	while (!kthread_should_stop()) {
 
 		/* Process stuff */
+		rfcomm_process_security_cfm();
 		rfcomm_process_sessions();
 
 		wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
 	}
 	remove_wait_queue(&rfcomm_wq, &wait);
 
+	/* rfcomm_exit() unregisters the HCI callback before stopping this
+	 * thread, so no further confirmation can be queued here.
+	 */
+	rfcomm_process_security_cfm();
+
 	rfcomm_kill_listener();
 
 	return 0;
@@ -2214,50 +2299,26 @@ static int rfcomm_run(void *unused)
 
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
-
-		if (!test_and_clear_bit(RFCOMM_AUTH_PENDING, &d->flags))
-			continue;
-
-		if (!status && hci_conn_check_secure(conn, d->sec_level))
-			set_bit(RFCOMM_AUTH_ACCEPT, &d->flags);
-		else
-			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
-	}
-
-	rfcomm_unlock();
+	/* The connection is pinned for hci_conn_check_secure(), but it drops
+	 * its reference on hdev once it is deleted, so take a copy of the
+	 * local address needed for the session lookup.
+	 */
+	cfm->conn = hci_conn_get(conn);
+	bacpy(&cfm->src, &conn->hdev->bdaddr);
+	cfm->status = status;
+	cfm->encrypt = encrypt;
+
+	spin_lock(&security_cfm_lock);
+	list_add_tail(&cfm->list, &security_cfm_list);
+	spin_unlock(&security_cfm_lock);
 
 	rfcomm_schedule();
 }
-- 
2.55.0

