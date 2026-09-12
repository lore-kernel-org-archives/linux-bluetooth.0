Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E138B7D2
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789207403; cv=none; b=Ighl6JzK5n1l9YjAgN/gx4Dby1yU90446d7w2XSWOt5NMX9YavZjelZU+BrXORXEjP5X5k463X2edOshZNZKOZ8Tap4A7eff2LntSFdzHvAsifeRSf8Au7B7mX3WBQNbCLsa8y3eKehYHUcbD1nJU7X9JevYhLzAl0LZ/6NkbuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789207403; c=relaxed/simple;
	bh=WN5YeKgolI1gaNca7m3o51m/BxZJrR9aLcGuRlXGtj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQ6aJxfyV2Wo1AmO8qug5qHeYxm1Lkkhfm3mnl5lGsj7F1OdOnqRrQFDMj3kPb+aYOkH3kCjSXduWdmpL/dJl20vIpa2DNFa9YoNtvs7mPeBFJUmqC1JYWEVN02BQUae9JsiSD/Hrnf11VSbPqfglfezqVfQpxwtAEJDUTcU1EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EN+yRECQ; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EN+yRECQ"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16f16so823088e87.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 03:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789207399; x=1789812199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jxKIx3r/q2G7x6KZBvEKOw3luI2MoVxuwqdcXemjjfM=;
        b=EN+yRECQ+V+xn4UHeG9IXu2qqRERbDtS2i0rYA5U5rJseE/cY8yBWggNtxpg9z5V48
         KOLKwYu5sQk151VpIPsm9rmjsx+eh6nBfHWkBIKAUpizDbjIVMXrG7yOCl0IqIDHuy7h
         annCSoCh+w+DRezGjTECynP3lDeMjtZjwDUuvf9izdN1S74dzjhEijOgLNkIWDPSfQg+
         laBlUybaLkb/B7o05bZc8Qc/zUwh1l+swXz8JJi2IFkBmMl2z1lxxs6OGNC0amqvDzST
         CaHaXUhncNWI/UWEZla4DqjicwRJO2E7o/qXJAlEnu/N/81ivxTUa+hdB7jO+UKxyBTR
         bBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789207399; x=1789812199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jxKIx3r/q2G7x6KZBvEKOw3luI2MoVxuwqdcXemjjfM=;
        b=UYcK6tBhKSSyiTGIowVkg1UzeeRBEk7HHysOyNc+/sjBb3m5Qd07W84CQJXNfKP4Nl
         iR8Yx03tzr4kNbWjRoVG8dRltvwMBa7K+/cq5QnKY9U5msOOWttGnAV3q3nu1P5vrRMn
         o69ONQatay3WwgQcfjvXCu8NHkMpnm3g5sGoLfNznG8ViB+gyEVGNkxXK9s+4LKc7D90
         /4Sv01fAn0sCNf1/Vv+xkW8lhKR5dzfYUzmBFm/5UUDwzZfaova9N2UQDH5wpNTLdTBF
         IE9PxqoJ3JWMfjuhKPqursS6Mp+qboV/uDhw3hEdTL59prz46Z/eORqYneAqWdmHlSoo
         FpuA==
X-Forwarded-Encrypted: i=1; AKwUvBzQtUROPgPlaCvneHIwga5mMYE1TQx/K/ksJ22CTvDQn4YMB/dcayXrNVoLJjQ7CZVgn26sSq7k3gKyUBwam9k=@vger.kernel.org
X-Gm-Message-State: AFuF++nZ8mptyv2pkhpPhtr7c9D9otBRsTjdOl6jTiuwjmm1NslOpkcf
	EZOn0eD53dhuS+Qc0COBTbDUhqHxSBAq8a96LtAs5eTex1qnYCKaapMIsbab1QzcA3oNSW6l
X-Gm-Gg: AYBFou3i9K7g2nHIogTDSSEYLwdmfrIxD0JUF2reS7zWO2uSlK28YAb2pqTu5tWmoIr
	q+mIpJCYnsFUTz2/r4xvKubti55lssaZnqFRqjaLbHrLLgt5Abv/sV1dxhZ3uFlpR9xckJ7AabB
	vZuxrxCg9sjnfquaol+YUjhlxVHexNdn/571Poe2Bt05dUJpMm+VkgooA0tvoCWgNwCPjL/zGka
	3qy2v0ivsR0tCO7Um4p0NlZ1g78PTb1BEkMzFZTAwMkf0rriB9UknkdX7UlkZThNOu2+aiIEP24
	H2fZGEZuI7Fb/Cb9U4FSSAk5qL9YZchFgDkEtUTVhKYxDVhIqMk9yej+GUd0EKhWyXa2OZStVX6
	LfiyJcOV9CPDKXLGL9fjMBKiNnaoPc4GUO3JTTndp0Dhre3J6MhvlSh5kX7VCD2ma4JxHhb03vM
	uWOJ6OUCJJmzG0pY07wN9WurhvMXjG7khsXDk4Alvs3+V98rukrUkhLzMoytccndWrwiatv25Qm
	Qcok3RUNUmgP+VL6UYBynK7MuTPWekXESO+YX/W0nQZx1hgXqJFIAqbJkUUxxtIYwFJmh4=
X-Received: by 2002:a05:6512:3e0c:b0:5b1:537b:de9b with SMTP id 2adb3069b0e04-5b8a0325aecmr3236783e87.19.1789207398830;
        Sat, 12 Sep 2026 03:03:18 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a045dd51sm1153427e87.30.2026.09.12.03.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 03:03:17 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: nicoyip.dev@gmail.com,
	pav@iki.fi,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
Subject: [PATCH v3] Bluetooth: RFCOMM: connect the session socket without rfcomm_mutex
Date: Sat, 12 Sep 2026 15:03:15 +0500
Message-ID: <20260912100315.151674-1-mikhail.v.gavrilov@gmail.com>
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

Only the session socket has to be connected with the lock held, and it
does not: nothing else can see the socket before it is put on the
session list.  So connect it first and take rfcomm_mutex afterwards,
which removes the rfcomm_mutex -> hdev->lock order for good, rather
than keeping the HCI event path out of rfcomm_mutex.

rfcomm_session_create() becomes rfcomm_session_connect(), which returns
the connected socket without touching the session list, and
rfcomm_dlc_open() adds the session once it holds the lock again.  If
another opener added a session for the same pair while this socket was
connecting, that session is used and this socket is dropped.
__rfcomm_dlc_open() now takes the session it should use, and its state
check runs after the lock is re-acquired, so a DLC that was opened or
closed in the meantime is still handled.

Over an existing ACL link the connection can complete before the
session reaches the list, and the wakeup from the socket callback is
then lost, so krfcommd is woken once the session is visible.

Fixes: 759c185d0bbd ("Bluetooth: RFCOMM: serialize security confirmation handling")
Suggested-by: Pauli Virtanen <pav@iki.fi>
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
v2: https://lore.kernel.org/linux-bluetooth/20260904012028.77590-1-mikhail.v.gavrilov@gmail.com/

v3:
 - fix the lock order on the connect side instead of deferring the
   security confirmation, as asked for on v2; rfcomm_security_cfm()
   and krfcommd are left alone, so none of the questions about delayed
   confirmations apply any more
 - the queue, its annotations and the flush from v2 are gone

Tested on 7.3.0-rc2 with an MT7922 controller (btusb).  Without the
patch the reproducer below reports the inversion on every run; with it
applied it stays quiet and the validator is still armed afterwards
(debug_locks: 1).  A 10 hour session with BR/EDR headset connects,
AVRCP and SCO traffic produced no lockdep report either.

An outgoing connect towards a connected headset is answered in 29 ms
with ECONNREFUSED - the session is established over the existing ACL
link and the peer rejects the channel - which is the case where the
L2CAP connect can complete before the session reaches the list.
Towards an idle device the same connect fails with EHOSTDOWN after the
page timeout.

The connect() side used for the reproducer, so that it does not depend
on which end sets up the HFP session:

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

 net/bluetooth/rfcomm/core.c | 114 ++++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 38 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index f7463f092283..227ccc7da848 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -62,10 +62,9 @@ static void rfcomm_make_uih(struct sk_buff *skb, u8 addr);
 
 static void rfcomm_process_connect(struct rfcomm_session *s);
 
-static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
-							bdaddr_t *dst,
-							u8 sec_level,
-							int *err);
+static struct socket *rfcomm_session_connect(bdaddr_t *src, bdaddr_t *dst,
+					     u8 sec_level, int *err);
+static struct rfcomm_session *rfcomm_session_add(struct socket *sock, int state);
 static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst);
 static struct rfcomm_session *rfcomm_session_del(struct rfcomm_session *s);
 
@@ -365,28 +364,17 @@ static int rfcomm_check_channel(u8 channel)
 	return channel < 1 || channel > 30;
 }
 
-static int __rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst, u8 channel)
+static int __rfcomm_dlc_open(struct rfcomm_dlc *d, struct rfcomm_session *s,
+			     u8 channel)
 {
-	struct rfcomm_session *s;
-	int err = 0;
 	u8 dlci;
 
-	BT_DBG("dlc %p state %ld %pMR -> %pMR channel %d",
-	       d, d->state, src, dst, channel);
-
-	if (rfcomm_check_channel(channel))
-		return -EINVAL;
+	BT_DBG("dlc %p state %ld session %p channel %d",
+	       d, d->state, s, channel);
 
 	if (d->state != BT_OPEN && d->state != BT_CLOSED)
 		return 0;
 
-	s = rfcomm_session_get(src, dst);
-	if (!s) {
-		s = rfcomm_session_create(src, dst, d->sec_level, &err);
-		if (!s)
-			return err;
-	}
-
 	dlci = __dlci(__session_dir(s), channel);
 
 	/* Check if DLCI already exists */
@@ -421,14 +409,72 @@ static int __rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst,
 
 int rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst, u8 channel)
 {
-	int r;
+	struct rfcomm_session *s;
+	struct socket *sock;
+	int err;
+
+	BT_DBG("dlc %p state %ld %pMR -> %pMR channel %d",
+	       d, d->state, src, dst, channel);
+
+	if (rfcomm_check_channel(channel))
+		return -EINVAL;
 
 	rfcomm_lock();
 
-	r = __rfcomm_dlc_open(d, src, dst, channel);
+	/* Do not page the remote device for a DLC that cannot be opened
+	 * anyway.  __rfcomm_dlc_open() looks at the state again once the
+	 * lock has been re-acquired below.
+	 */
+	if (d->state != BT_OPEN && d->state != BT_CLOSED) {
+		rfcomm_unlock();
+		return 0;
+	}
 
+	s = rfcomm_session_get(src, dst);
+	if (s) {
+		err = __rfcomm_dlc_open(d, s, channel);
+		rfcomm_unlock();
+		return err;
+	}
 	rfcomm_unlock();
-	return r;
+
+	/* There is no session for this pair yet.  kernel_connect() ends up in
+	 * l2cap_chan_connect(), which takes hdev->lock, and the HCI event
+	 * path takes rfcomm_mutex while holding hdev->lock, so the socket has
+	 * to be connected with rfcomm_mutex released.
+	 */
+	sock = rfcomm_session_connect(src, dst, d->sec_level, &err);
+	if (!sock)
+		return err;
+
+	rfcomm_lock();
+
+	/* Another opener may have added a session for the same pair in the
+	 * meantime; that one is used and this socket is dropped.
+	 */
+	s = rfcomm_session_get(src, dst);
+	if (!s) {
+		s = rfcomm_session_add(sock, BT_BOUND);
+		if (s) {
+			s->initiator = 1;
+			sock = NULL;
+		}
+	}
+
+	err = s ? __rfcomm_dlc_open(d, s, channel) : -ENOMEM;
+
+	rfcomm_unlock();
+
+	if (sock)
+		sock_release(sock);
+
+	/* Over an existing ACL link the connection can complete before the
+	 * session reaches the list, and that wakeup is then lost, so let
+	 * krfcommd look at the socket state now.
+	 */
+	rfcomm_schedule();
+
+	return err;
 }
 
 static void __rfcomm_dlc_disconn(struct rfcomm_dlc *d)
@@ -757,12 +803,12 @@ static struct rfcomm_session *rfcomm_session_close(struct rfcomm_session *s,
 	return rfcomm_session_del(s);
 }
 
-static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
-							bdaddr_t *dst,
-							u8 sec_level,
-							int *err)
+/* Creates the L2CAP socket a new session will run on and starts connecting
+ * it.  Must be called with rfcomm_mutex released.
+ */
+static struct socket *rfcomm_session_connect(bdaddr_t *src, bdaddr_t *dst,
+					     u8 sec_level, int *err)
 {
-	struct rfcomm_session *s = NULL;
 	struct sockaddr_l2 addr;
 	struct socket *sock;
 	struct sock *sk;
@@ -792,24 +838,16 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 		l2cap_pi(sk)->chan->mode = L2CAP_MODE_ERTM;
 	release_sock(sk);
 
-	s = rfcomm_session_add(sock, BT_BOUND);
-	if (!s) {
-		*err = -ENOMEM;
-		goto failed;
-	}
-
-	s->initiator = 1;
-
 	bacpy(&addr.l2_bdaddr, dst);
 	addr.l2_family = AF_BLUETOOTH;
 	addr.l2_psm    = cpu_to_le16(L2CAP_PSM_RFCOMM);
 	addr.l2_cid    = 0;
 	addr.l2_bdaddr_type = BDADDR_BREDR;
 	*err = kernel_connect(sock, (struct sockaddr_unsized *)&addr, sizeof(addr), O_NONBLOCK);
-	if (*err == 0 || *err == -EINPROGRESS)
-		return s;
+	if (*err && *err != -EINPROGRESS)
+		goto failed;
 
-	return rfcomm_session_del(s);
+	return sock;
 
 failed:
 	sock_release(sock);
-- 
2.55.0

