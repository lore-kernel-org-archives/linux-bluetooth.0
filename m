Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D2C3ED109
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789809083; cv=none; b=W3sWN9q9Vmr4/umvCZWpGO55bRFT+jYKzhjwf80IAsGdvno5Lm6tFXIGZSBNHPV5dRb2oR9gAQQmvBIsoJpkO8XQG70nQ8orxq2otUcKSVc9o0d+dVcGVObC050x6LYrCP3y8qjQLcdk7lojNrXJ0YYOn69MPMiJDcN4PJGLnMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789809083; c=relaxed/simple;
	bh=D6ph7n5q0URhHNzxQIE75QUv6yBpzCie/CEQlOfn/y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onZxql8XmauXOxEA0JYrW9nucuLt3cL1zgs9BRc08wYmxuTI7rA80QE+dO8g4x21pucw5yxAi81pb3Wu6OwOyaN+fPwnq0fm0CQGaKtuS1as5Ei2FUm+paRhiWpHDUjXmhrr/taWBNKIqASN2v9Hyf3CBUBu45fFoSRycpvNIn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ga3RmkaU; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga3RmkaU"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso1660964a91.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 02:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789809081; x=1790413881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DsV9Fsd7Kx2vmgwJA0Z2vvtQ9MytD8CHEdEDo7dy1uA=;
        b=Ga3RmkaUi8qnXWAqUoVgRrVYSKjZyCt9fdn2t5YWupGHz2Gc5we7iSsTIdJn9rnKNu
         QX8Ni59WOGrrwts08zJ6Ye9UXDzPoheqe0QA3dIwNnpfPvJCG5NWn5EbaaCiD+7+yy82
         QRrPBuOkEF2oI3gkOJOBMewAbfztMZTpbWS3dK0OpXs9Z29aoznjAzqkKr3NYj/seIoC
         8hHGuSjk0DsmQIuJy1bA4y/04YS8b3ZWW5XOTjXSbZ1D5+rtBNWvHvrDoqjkaYrQ21py
         YEwu+UOL4jmHPMja8i6GccIL7AArrqLWvPSZ0wMFW7mpmfBWvzKzsceAxr2nfXL4HnE+
         4dxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789809081; x=1790413881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DsV9Fsd7Kx2vmgwJA0Z2vvtQ9MytD8CHEdEDo7dy1uA=;
        b=WS71dF1acCqK7UZCwztrrI2+t6vHoz60IuPJB9O6cE+5sNnxe9xK+whAg7HvnmzZsI
         WncEeQNnng0z8gx7+Fziftf/xbwXeNFSuQGWCn3ZagbgvKxIRc74ojyQnuC/p5o1rfyu
         JyRSCot7LMs06+Y+O2ChXmIYk5xxmNY22XHKZsyPEtFN0au4l5GIBIytPIjQlHUlTVru
         jGr00DgglAN7pEqL+7R8mkomoqCR3p8mMTBmSUcP4b5uPJoUcDXJvMkX0ZQ+IwdK7ejh
         tiHRjDuVAUQ4H4hfv9Y5fCjwDWp3vD1K+2eASPzj8RkID60Pr7rZY04IGaXjsn9D7Dla
         ZnbQ==
X-Gm-Message-State: AFuF++kNjjRDvR0mcxkANzHwzY2Lj/HaVnmkXQAIzTYBLrP/ko0Bk99l
	oF+g60aUJYgaiLGB6uBbhhcI3DrdQMfr/l4tuX2mHBOgoV/hgPy3d0Gt
X-Gm-Gg: AYBFou0af0EYGPvtLi8lOKJ9RP6FAJtIJKL5FdcyKEXdDwSsPEDb/e0eJXaZDtJdxrE
	d3Q1RoNA8a+6l4l5qn0423Zt9dMESFDLRvuIyLJYb9MYsnBhFkYymi1OtFtHnaABYByDiIwrhUA
	GsAA3Ujt5vOFRS5bCFU16/jQ5Z87KHX48xFe+/WK0KeTFsPuhjS4v+v4o7qOx4MexHCGnVA400o
	thZWnd5KwktcsAslVPPJ4NRiWzIqq9xfjXuWYpMgxAsn6+Pxprr9ANccZKbBgm3S4QGu3btQWzF
	RfB07l7uaOp9dk788hPldn0C8pETOmZ9VsWTJCPqAs3a7itbSDlQfoedsoV+yK09pdpxn5cvqkQ
	I62YOeDeTSpYO/hdKZ60aIQXvZ2w6CxAxv5NMsPTI/v14J/A/J1eflv80FreH0DI9kieSzEXJUA
	8uPCYVEojAh2qMgmAliGP8UHKHc1btFdPd0plcvDmR9snpuEc88PBh40AL/8hYPvxtE8asoSIcU
	Wl1jGtUxutUTuvLT2K5pbyd4XqIv0+caFLat+Pq1E9sg9FFLSfNliszW9sKra15Z3s0gdL55MW5
	CEnrgk2dYw==
X-Received: by 2002:a17:90b:280a:b0:39e:2530:2102 with SMTP id 98e67ed59e1d1-39e54f4221amr17113972a91.11.1789809081235;
        Sat, 19 Sep 2026 02:11:21 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cae997csm3596214a91.11.2026.09.19.02.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 02:11:20 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH] Bluetooth: RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO
Date: Sat, 19 Sep 2026 09:11:20 +0000
Message-ID: <20260919091120.3273038-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
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

BT_DEFER_SETUP can be set on a listening socket, and it is stored in
rfcomm_pi(sk)->dlc->defer_setup while dlc->session is still NULL. A
local user can therefore create an RFCOMM socket, call listen(), set
BT_DEFER_SETUP, and then call getsockopt(SOL_RFCOMM, RFCOMM_CONNINFO)
to skip the -ENOTCONN path and dereference the NULL session:

 Oops: general protection fault, probably for non-canonical address
 0xdffffc0000000002
 KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
 CPU: 1 UID: 0 PID: 150 Comm: init Tainted: G B 7.3.0-rc3-g5dd1818b15d9 #1
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

Deferred setup only leaves a socket usable here once it has reached
BT_CONNECT2, so restrict the exception to that state and check that a
session is actually present before following it.

Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
No Fixes: tag: I could not pin the change that introduced this with
confidence, so I left it out rather than guess.

Reproduced on Linux 7.3.0-rc3 (5dd1818b15d9) with KASAN under QEMU with
a virtual HCI device:

  s = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
  bind(s, ...); listen(s, 1);
  setsockopt(s, SOL_BLUETOOTH, BT_DEFER_SETUP, &one, 4);
  getsockopt(s, SOL_RFCOMM, RFCOMM_CONNINFO, &ci, &len);   /* boom */

With this patch the getsockopt() returns -ENOTCONN instead.

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
