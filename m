Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Mark Haun <haunma@keteu.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	David Herrmann <dh.herrmann@gmail.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] Bluetooth: hidp: fix device disconnect on idle timeout
Date: Mon,  7 Sep 2015 12:05:41 +0200
Message-Id: <1441620341-553-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The HIDP specs define an idle-timeout which automatically disconnects a
device. This has always been implemented in the HIDP layer and forced a
synchronous shutdown of the hidp-scheduler. This works just fine, but
lacks a forced disconnect on the underlying l2cap channels. This has been
broken since:

    commit 5205185d461d5902325e457ca80bd421127b7308
    Author: David Herrmann <dh.herrmann@gmail.com>
    Date:   Sat Apr 6 20:28:47 2013 +0200

        Bluetooth: hidp: remove old session-management

The old session-management always forced an l2cap error on the ctrl/intr
channels when shutting down. The new session-management skips this, as we
don't want to enforce channel policy on the caller. In other words, if
user-space removes an HIDP device, the underlying channels (which are
*owned* and *referenced* by user-space) are still left active. User-space
needs to call shutdown(2) or close(2) to release them.

Unfortunately, this does not work with idle-timeouts. There is no way to
signal user-space that the HIDP layer has been stopped. The API simply
does not support any event-passing except for poll(2). Hence, we restore
old behavior and force EUNATCH on the sockets if the HIDP layer is
disconnected due to idle-timeouts (behavior of explicit disconnects
remains unmodified). User-space can still call

    getsockopt(..., SO_ERROR, ...)

..to retrieve the EUNATCH error and clear sk_err. Hence, the channels can
still be re-used (which nobody does so far, though). Therefore, the API
still supports the new behavior, but with this patch it's also compatible
to the old implicit channel shutdown.

Cc: <stable@vger.kernel.org> # 3.10+
Reported-by: Mark Haun <haunma@keteu.org>
Reported-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
Hi Mark & Luiz

Can you give this a spin? This should fix the reported issues! I like the
implementation much more than calling shutdown(2) implicitly in the kernel.
With sk_err we avoid enforcing a behavior and let user-space deal with it.

Btw., this needs back-porting to >=3.10 (which introduced the new session
management).

Thanks for the report!
David

 net/bluetooth/hidp/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index f1a117f..4f1db96 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -401,6 +401,21 @@ static void hidp_idle_timeout(unsigned long arg)
 {
 	struct hidp_session *session = (struct hidp_session *) arg;
 
+	/*
+	 * The HIDP user-space API only contains calls to add and remove
+	 * devices. There is no way to forward events of any kind. Therefore,
+	 * we have to forcefully disconnect a device on idle-timeouts. This is
+	 * unfortunate and weird API design, but it is spec-compliant and
+	 * required for backwards-compatibility. Hence, on idle-timeout, we
+	 * signal driver-detach events, so poll() will be woken up with an
+	 * error-condition on both sockets.
+	 */
+
+	session->intr_sock->sk->sk_err = EUNATCH;
+	session->ctrl_sock->sk->sk_err = EUNATCH;
+	wake_up_interruptible(sk_sleep(session->intr_sock->sk));
+	wake_up_interruptible(sk_sleep(session->ctrl_sock->sk));
+
 	hidp_session_terminate(session);
 }
 
-- 
2.5.1
