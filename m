Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D6F47F3DA
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789817121; cv=none; b=Qudzb6Ru4cCdX1EwHaDCC4J+DsLy0xcMZCxX1j2bf3qcdupRxNp0LOkW8Z8D+MLOFBommWFZRvcrrHtuzW5ZFIMPlR51/KGUaKR7Z7cpZZHlc3XJi+Jfldg2zvSHn62gKKcLKfdwGU+j9WCFaVMIOdBLybizMaLLYAZpVbQtEnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789817121; c=relaxed/simple;
	bh=Ixb6cmMvU+LTEqMJJk5Ke8XqUwLJgxrw4wJOd073H70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShXowaAeoJIVa3Bgx3xjpa8xDzv15g8+3T4QaGBTL9xa6943Ud+cRDxfFqlkJyLEhB/6y/9l5Gl6fY5aVwahoRO7iGGjbxqBBxBcR83PRjkdh8r1Nwvx79YOVhauvPbthiStYpbSZh8VULTSXFitJ/IKACTguFdudjW4wR3K/6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rHLTbpt0; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHLTbpt0"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91c22d27dso9690735ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 04:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789817119; x=1790421919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LDwLwQAewal+PyLIhiDnDta3QTEMBb3CNRkINRzkcs8=;
        b=rHLTbpt0Dq06+5LPfIN7VQuwSF5dD5+zXUTk36r3bTogpccc9otHAUZB1QCT57ifi1
         gRGs9UBlFcYgpox1/NE8u9Txm3ICAC/0HGdseebXhjMqQsS7lqKO/cu+dDcebPwCpAfB
         2F/7LYw+G+dLWfflWld3eMq3BgoHA+MZZ5uiOGuUc7yapfsFw90Ps+qjXps+iT6oSHyx
         A4Cq75CrOK/9n5wFS82hpTzFWhu+JcvfSDLSjsxM+2fuiYeZkXcMXfmC83OZc4lhWEUh
         yZC/uwXz1xrO4uaD1FZLrnvfaslCiS5A6xW1fAufbEKhuTOnxJsbRMp8G4siDXqmUtGG
         RmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789817119; x=1790421919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LDwLwQAewal+PyLIhiDnDta3QTEMBb3CNRkINRzkcs8=;
        b=kIsrYQ0eAaODdCol+ANKNes6iwvDHjkOZIVltpSEZCX4dXJDFWHBEFXuqmR9GYYk36
         QXoy/6GYYIz1fupFGEvhIJ1MNDchgYZxAzyJnGcZvlm+NvdC8vRGTAwmR2xz63zENGEp
         dUgm405PuyayaxImnhaw2E1ANXE2P4reTS7MogOAIKdPtQTnstArojFDrWbhePlVO2iu
         +gJntwDdkFL3bVizbKWvA9m1bhMYpKw5jtJZ+18rZVU/58f6CJKYOZhNTObQ+/VzJggT
         VOYnvAGTvdwlTnJ8bzuxm64P7SZLvkcZ1ujKBimNnG2K3MCbbqYsEuMHyY1ZcvDq3xdm
         Pc4w==
X-Gm-Message-State: AFuF++kgjq83Ge7QjymStmAdMIsKGICqLCEPCjBjxyHdfrGV3zFRjbm2
	R+dj8XPMPFhkSbJE0HxnWWLHjK1CPbKO2OFfv0s1sifP9FoDNhDJDHBN
X-Gm-Gg: AYBFou2+yWqQudm9XQl3hiuFy/iD7c8TzHs3jHsQQmVyIETjfqYOvCWMA0ZozpkoS7T
	Wb1sJeJBHE68Jc/pDiUgsTRzNzTHfsUY7AcVtpZzWjgEfP4v73EKZB1EJUmx+2Q4nLcupKN3P3l
	sGitHhFssr6di9oXQH31GQCGi4rMIUT7t4jPLwetPAreg+D0P3B1I1FC8bfWSBxCtRJSk7HIivk
	S2AxVw/R6IGrkhA49xGbA2E8OJPKFy3N/Pt4pcQQlTpbBzH4OtvWqaI51MBxLkPY4QR5Uhj/P4U
	3OKqEt1sJWgk/LAQVz4pdTSVVJxLfnXRWDciODejeB1JCM2og5/rMBAtZY9E+ULQ4s71pwOYIFq
	29BtKbhYAZMO5k9UR2S5t7mQOWZcSkJfQXoxD1wn37B5zoP/+xbxa/PHljIbdW0PLuFjTEG7vhz
	eczp/p5lpe52wNGn6Uar2zCnh6w9Z8mNnHGuPXDQ4tW+1KWWZvfIC8IDwjH1yJGzot/FO+onYiD
	fdkG906o6mm+27uJuimPFN/tLtzgplm3uQG+HJlddLnA6NyZ4Lc7sa51GwmhN9UYnQloE8rATFT
	v4smAwRXQg==
X-Received: by 2002:a17:903:46d0:b0:2d6:3c2f:6a4 with SMTP id d9443c01a7336-2ddb1b04363mr98475925ad.13.1789817119229;
        Sat, 19 Sep 2026 04:25:19 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2de217b3a97sm8365665ad.31.2026.09.19.04.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 04:25:18 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO
Date: Sat, 19 Sep 2026 11:25:18 +0000
Message-ID: <20260919112518.3872094-1-benquike@gmail.com>
In-Reply-To: <20260919091120.3273038-1-benquike@gmail.com>
References: <20260919091120.3273038-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RFCOMM_CONNINFO getsockopt handler accepts a socket that is not
connected as long as deferred setup is enabled:

	if (sk->sk_state != BT_CONNECTED &&
				!rfcomm_pi(sk)->dlc->defer_setup) {
		err = -ENOTCONN;
		break;
	}
	l2cap_sk = rfcomm_pi(sk)->dlc->session->sock->sk;

dlc->defer_setup is set in rfcomm_sock_init() when rfcomm_connect_ind()
creates a child socket for an incoming connection on a listening socket
that has BT_DEFER_SETUP enabled. It is never cleared afterwards. The
session, however, can go away underneath it.

rfcomm_recv_disc() forces the dlc state before tearing it down:

	d->state = BT_CLOSED;
	__rfcomm_dlc_close(d, err);

The RFCOMM_DEFER_SETUP early return in __rfcomm_dlc_close() only covers
BT_CONNECT, BT_CONFIG, BT_OPEN and BT_CONNECT2, so with the state
already BT_CLOSED that switch does not match and the function falls
through to rfcomm_dlc_unlink(), which sets d->session = NULL, while
d->defer_setup stays 1.

A getsockopt(SOL_RFCOMM, RFCOMM_CONNINFO) on the accepted socket after
that point therefore skips the -ENOTCONN path -- sk->sk_state is
BT_CLOSED, but dlc->defer_setup is still set -- and dereferences the
NULL session. No race is needed: once the DISC has been processed, the
dereference is unconditional.

Reproduced on a KASAN kernel under QEMU with a BR/EDR peer emulated over
/dev/vhci: the peer brings up an ACL link, opens L2CAP on the RFCOMM
PSM, starts a session and sends SABM for a channel bound with
BT_DEFER_SETUP, and sends DISC for that dlci after the socket has been
accepted. getsockopt(SOL_RFCOMM, RFCOMM_CONNINFO) on the accepted
socket then hits:

 Oops: general protection fault, probably for non-canonical address
 0xdffffc0000000002: 0000 [#1] SMP KASAN PTI
 KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
 CPU: 1 UID: 0 PID: 150 Comm: init Tainted: G B 7.3.0-rc3-g5dd1818b15d9
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
 RIP: 0010:rfcomm_sock_getsockopt+0x529/0x780
 Call Trace:
  <TASK>
  do_sock_getsockopt+0x3ad/0x7d0
  __sys_getsockopt+0x10e/0x1b0
  __x64_sys_getsockopt+0xc2/0x160
  do_syscall_64+0xda/0x4b0
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

0x10 is the offset of sock in struct rfcomm_session;
rfcomm_sock_getsockopt_old() is inlined into rfcomm_sock_getsockopt().

Commit 43a556b2fd43 ("Bluetooth: RFCOMM: take rfcomm_mutex for the
deferred setup accept") fixed the same "a remote DISC clears the session
while deferred setup is still flagged" problem in rfcomm_dlc_accept();
this is the remaining instance of it, in the getsockopt path.

Deferred setup only leaves a socket usable here once it has reached
BT_CONNECT2, so restrict the exception to that state and check that a
session is actually present before following it.

Fixes: bb23c0ab8246 ("Bluetooth: Add support for deferring RFCOMM connection setup")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
v2: Corrected the changelog. v1 claimed BT_DEFER_SETUP on a listening
socket stores into dlc->defer_setup; it does not - it sets
BT_SK_DEFER_SETUP in bt_sk(sk)->flags, and dlc->defer_setup is only set
on the child socket created by rfcomm_connect_ind(). The three-line
"reproducer" in v1 (socket/listen/setsockopt/getsockopt) consequently
could not have triggered anything and has been dropped. The real
trigger is a remote DISC unlinking the session of an already accepted
deferred-setup dlc, which is what the reproducer actually did. Also
added the Fixes: and Cc: stable tags. Apologies for the noise on v1.

Behaviour change worth noting: deferred-setup sockets whose session has
gone away now get -ENOTCONN instead of crashing, and deferred-setup
sockets outside BT_CONNECT2 also get -ENOTCONN.

 net/bluetooth/rfcomm/sock.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -786,8 +786,10 @@ static int rfcomm_sock_getsockopt_old(st
 		break;
 
 	case RFCOMM_CONNINFO:
-		if (sk->sk_state != BT_CONNECTED &&
-					!rfcomm_pi(sk)->dlc->defer_setup) {
+		if ((sk->sk_state != BT_CONNECTED &&
+		     !(sk->sk_state == BT_CONNECT2 &&
+		       rfcomm_pi(sk)->dlc->defer_setup)) ||
+		    !rfcomm_pi(sk)->dlc->session) {
 			err = -ENOTCONN;
 			break;
 		}
-- 
2.43.0
