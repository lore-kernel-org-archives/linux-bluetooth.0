Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795490474;
	b=Fk5yA8P4J22skTQOl5kCZjxYSUQLGauD1kjYdsyPfIO1RCcxt6RQ7jXaqmT461+x/2Oc
	 vHcwVMUuJDKrH08vNDUFO7bF/hhV5+uC2YbtbkR8F2g6ajrG6hEHy+ppZL5opNBAw9rl1
	 y3psmMhlQsIyZaX/WdLj74U0H4y+wrddkIhHKZCdRMphMx7gtSxRgOUGK4IWIM6ikLylA
	 5QmSO9KbaoW/shsDfgOqP+FwKtbOvUBiDwOaq/puTgAYPVqLWQeMGabHpi6EndiptxSUK
	 eN9M1u4yL5QcIsXZJM42aZcp8yxRmP9rFKXYnLcQRDr9/g9ewFBPPE3mR1pAGF9DzbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=5K8gBQmbANshQMGjOwGW+ZIQJvSSKhEt8Jf+UhdYaoE=;
	b=z8bbtPnqLyIHOm2D1G9vVdeC7uqhF6hfQ5DfARawiM1seCNW4/JFegPkt6uinnSnPF7Q
	 eCG4pJOfmR4WiZ0nUKOau5XcOr7CsAyXpkwJh7keb4ZmH/kX/g7R3OdA/G0dkKZaSKOFG
	 6iv0kYBo7MaCQVRNp9NVkHFIYGh9g7qDVlGufEHawpDaEmInluv1gAmSJrQ9duvtVyA8V
	 dh7oaUwFEh+uE0ZqQk+F4dRVee7dBptz0ChaJsSNahcWQoHPW25pD2IwqToDR4L3CWvgh
	 u8dClSF89nKs630XgdMCqPr0skepEDJQPtgD71OaXbInjRyNO8reBwzGaTTYgNn58iQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZkuUHEVi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5EF606A322
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 03:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE5EF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZkuUHEVi
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67c6a0abc2eso4228292d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 19:21:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795490473; cv=none;
        d=google.com; s=arc-20260327;
        b=ccZvvWUxns5zfZFRbOX0abysG0HItd8sYVWOWhWF42+s76rbsROI/iTBULclzqfwga
         k1WpqDe5cd4OMYCsTdfaMbLrrYFHlwE1N1Wamb9WBXpuDYzEPDPML7Nhjqh18MMm7DpA
         XNkNDnegtDlD3VgncE0TiW3shK0KqhgIfCtlCWsItW7lib5LGJA/Dam6RfF6bDs1Z10G
         72OoeUnZzZ7k5dGQVB7KO2BPmJsgK8bSmn319L42ByLSTHdXpGk7LYwJdzx7aHLe9sjr
         ZJuRdYVPEg1xJFDAVLjelhoC95lXzzIgufBKkuElbPesB/zBn/4SV/V/52N+hwJ8HBgy
         5e6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=5K8gBQmbANshQMGjOwGW+ZIQJvSSKhEt8Jf+UhdYaoE=;
        fh=RowRCfnne+38Ef5u+0puxiBl6gtKxRauRStUxD+/MRM=;
        b=Lw/7UrducXzPplcpNcZHjNj5Wt+AfLVX1DzwNmzKZ0BfV9fbYBgpaLRgUiwnFRn3jD
         zXC48bNWdnUxY+XbzML5mB6/R2eprzYI3JpcW+8RZaghg+OQDJAcO+WVIMPG2E2F2Ohw
         TEU9eSH7leGaWzo5/td02RvofbLWGuvMGgI0qdo50dR7sPLP/d4ij3UGGGypXcP+mLxL
         J7XqMLPK8vi1+AwIbHusYA9jEcgECvDpE62+vQajsTtwRA5LTBqz/JrJUM5cvX68aI7Y
         DiXjZWBNlcpTUr5Hc/4NIToX45xB9Gium1inIeIbIiXHU+yi4MdSCt9lN/HDe7y6W2W1
         Rleg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795490473; x=1796095273; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5K8gBQmbANshQMGjOwGW+ZIQJvSSKhEt8Jf+UhdYaoE=;
        b=ZkuUHEViLF0pji5IU7BXrSvoloyyZEeETIdKNd4ZWD1ZyG7U5sbtIYi0S+wGrUfgkI
         FXgUFGzNtTIB9xDXYbSkP+UaigjJ3hFUg0aT6tLoguIlsg/u4rgypoHKnTNGPnTjzlxJ
         HH0eLCImBj6KVXfMsW06U1PtCdCo6rhlTd9aDkMIOw1CMFLrijQliDVZpHGSzCbyKEfn
         x0nxHaM1qDfC/i6KDKhMdYvffup5Gs3P+EbKKR9xcax+0pE5vCMlZVyeGxHl9uFmtc0t
         1MaHc48tWz/mw0W2LQTrky0Ue/HSCWipdor6ebDeXirXaJUjksIce4I8fucwAMu1vlab
         qtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490473; x=1796095273;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5K8gBQmbANshQMGjOwGW+ZIQJvSSKhEt8Jf+UhdYaoE=;
        b=GVqpJsT8emwvwgzesAg75sS1REBk5vrbPwueFb2hHGBouw/+GVG0zYTkz/djKGX484
         w/1OmYU9SPAp9NCOQoPUnHMj4sewam76EdaEekBptvolT7LQ+k6Ja1YGDuI0mf1ZV6v4
         BkYwudLXJobNPPu0CeU2DUL5nL7Gam1qcPrweOq5f3hBRpaJZ6A41ffZZjg5N1aJVrRb
         4q4PJ7xiw90sBgFU43zErql2ZCZD53RutSMnnhVQWE2pSJbz4bDWQ+GvAPRfyspZXsAU
         C36B0sv4jUoYEnJXvekPWIpCPqJls6h43gH5qhvez9U+Cr5OEaMF/1OnlduhMLf5layP
         N4Cw==
X-Gm-Message-State: APuU4Z8bIkyCssZn5waSmkhQ2qJ50llbkxPXPHb5TYaUDdtJNYSMous0
	M9iD05ZcuJmGSykC1WCXnKqnhX4MZP2dtty3KY5GWBw+gEvG9b9BwkIVf5LLg/dooNVvc7XZk82
	kOnOvA6B/H+QY+RBtXnEvd0GqlKzCZlo=
X-Gm-Gg: AZFdTZeEhH7rr5vCGo/GRJ7nLlWvOyebaFSoC98/IMbR7r4w88jaskwY9bEWJ/gcVwg
	5d/8TunYlcrbjLkgSQFLEYK5iceN2jcAem15wUe3EDZr6PqhfXQAQhdcaxakEvcQEDQY+ubc4Ce
	gOR1V+IJzMPIFCme4pdwuYvpq48MfeUySWIra78jIv0geeade0JDvfYtcA0vOWTtm/KdBV4b9p9
	T+vB7Bq+gzKQJuHKjdCQDVHFFmB2Ksk93KmkAvjPwNNznNB4VB9lt852UrjXWuAbXHjWDyx4sxV
	GWdo5ZdtJZcT8HY03ZuwDdt/71OQleO7y0uvKavYnc/A+3fzu0USwCIAD5YmrETklSoNGJCGmOf
	C9/AH/fC4BggG9lGnJWtuAHSM2LI02rkjz44k
X-Received: by 2002:a05:690e:1c08:b0:67e:5ce:90ce with SMTP id
 956f58d0204a3-67e05ce91cfmr3267820d50.44.1795490472582; Mon, 23 Nov 2026
 19:21:12 -0800 (PST)
Received: from 723974502065 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Nov 2026 19:21:12 -0800
From: Qican Ma <goonsomeway@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 23 Nov 2026 19:21:12 -0800
X-Gm-Features: Aa3M54pdCqnY3E60UONaT_y3uCUMeDrztdQuqt2t4mZW7K25hPa6BOLUhPo-sOk
Message-ID: <CA+OT+OO6R-qQc0L9YE1ktBtzWCpFcQ2MbSG63sH4--gk3E5LjA@mail.gmail.com>
Subject: [PATCH] Bluetooth: RFCOMM: serialize RFCOMM_CONNINFO dlc->session dereference
To: marcel@holtmann.org, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

rfcomm_sock_getsockopt_old() checks rfcomm_pi(sk)->dlc->session and then
dereferences dlc->session->sock->sk while holding only lock_sock(sk).
rfcomm_dlc_unlink() clears d->session and rfcomm_session_del() frees the
session under rfcomm_mutex without taking the socket lock, leaving a
check-then-dereference race against concurrent session teardown.

Commit 46f8ffd0a1f1 ("Bluetooth: RFCOMM: fix NULL dereference of
dlc->session in RFCOMM_CONNINFO") added the NULL check for the
post-disconnect case on deferred-setup sockets, but did not serialize
the dereference against concurrent unlink and kfree().

Add rfcomm_dlc_get_conninfo() to read the underlying L2CAP connection
fields under rfcomm_lock(). Hold a reference on the DLC and drop the
socket lock around the helper call to preserve the established
rfcomm_mutex -> lock_sock(sk) lock ordering used by krfcommd.

Found with an LLM-assisted code review tool and verified by inspection on
v7.4-rc4 (b6a9fa34ce4). Build-tested only; no runtime reproducer was
constructed for the narrow disconnect race window.

Fixes: bb23c0ab8246 ("Bluetooth: Add support for deferring RFCOMM
connection setup")
Fixes: 46f8ffd0a1f1 ("Bluetooth: RFCOMM: fix NULL dereference of
dlc->session in RFCOMM_CONNINFO")
Cc: stable@vger.kernel.org
Signed-off-by: Qican Ma <goonsomeway@gmail.com>
---
 include/net/bluetooth/rfcomm.h |  2 ++
 net/bluetooth/rfcomm/core.c    | 23 +++++++++++++++++++++++
 net/bluetooth/rfcomm/sock.c    | 24 ++++++++++++------------
 3 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 9dc5fd4cb8c..2e2cd873dd3 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -290,6 +290,8 @@ struct rfcomm_conninfo {
 	__u8  dev_class[3];
 };

+int rfcomm_dlc_get_conninfo(struct rfcomm_dlc *d, struct rfcomm_conninfo *ci);
+
 #define RFCOMM_LM	0x03
 #define RFCOMM_LM_MASTER	0x0001
 #define RFCOMM_LM_AUTH		0x0002
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 8a4205347c4..e6af6f5f591 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1427,6 +1427,29 @@ void rfcomm_dlc_accept(struct rfcomm_dlc *d)
 	rfcomm_unlock();
 }

+int rfcomm_dlc_get_conninfo(struct rfcomm_dlc *d, struct rfcomm_conninfo *ci)
+{
+	struct l2cap_conn *conn;
+	struct sock *l2cap_sk;
+	int err = 0;
+
+	rfcomm_lock();
+
+	if (!d->session) {
+		err = -ENOTCONN;
+	} else {
+		l2cap_sk = d->session->sock->sk;
+		conn = l2cap_pi(l2cap_sk)->chan->conn;
+
+		memset(ci, 0, sizeof(*ci));
+		ci->hci_handle = conn->hcon->handle;
+		memcpy(ci->dev_class, conn->hcon->dev_class, 3);
+	}
+
+	rfcomm_unlock();
+	return err;
+}
+
 static void rfcomm_check_accept(struct rfcomm_dlc *d)
 {
 	if (rfcomm_check_security(d)) {
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 3fb8b547494..e91a129a67b 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -741,9 +741,8 @@ static int rfcomm_sock_getsockopt_old(struct
socket *sock, int optname,
 				      sockopt_t *sopt)
 {
 	struct sock *sk = sock->sk;
-	struct sock *l2cap_sk;
-	struct l2cap_conn *conn;
 	struct rfcomm_conninfo cinfo;
+	struct rfcomm_dlc *d;
 	int err = 0;
 	size_t len;
 	u32 opt;
@@ -786,20 +785,21 @@ static int rfcomm_sock_getsockopt_old(struct
socket *sock, int optname,
 		break;

 	case RFCOMM_CONNINFO:
-		if ((sk->sk_state != BT_CONNECTED &&
-		     !(sk->sk_state == BT_CONNECT2 &&
-		       rfcomm_pi(sk)->dlc->defer_setup)) ||
-		    !rfcomm_pi(sk)->dlc->session) {
+		if (sk->sk_state != BT_CONNECTED &&
+		    !(sk->sk_state == BT_CONNECT2 &&
+		      rfcomm_pi(sk)->dlc->defer_setup)) {
 			err = -ENOTCONN;
 			break;
 		}

-		l2cap_sk = rfcomm_pi(sk)->dlc->session->sock->sk;
-		conn = l2cap_pi(l2cap_sk)->chan->conn;
-
-		memset(&cinfo, 0, sizeof(cinfo));
-		cinfo.hci_handle = conn->hcon->handle;
-		memcpy(cinfo.dev_class, conn->hcon->dev_class, 3);
+		d = rfcomm_pi(sk)->dlc;
+		rfcomm_dlc_hold(d);
+		release_sock(sk);
+		err = rfcomm_dlc_get_conninfo(d, &cinfo);
+		rfcomm_dlc_put(d);
+		lock_sock(sk);
+		if (err)
+			break;

 		len = min(len, sizeof(cinfo));
 		if (copy_to_iter(&cinfo, len, &sopt->iter_out) != len)
-- 
2.50.1 (Apple Git-155)
