Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41623DBD7C
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907463; cv=none; b=Dhx3W09v042QyUOBRfwyg5SQQahG99kvMYMME8Wuc8QiqdcFpKW7NDMLkxgQJyPCt/AWQSMQpQF3Au8UNxnze9woEvo61t9v7rkbEurplOjppQ1yLX+hZxRcAq+TqYOBwfM+pMMOuap3Jsb/uNrWs9v6PCjJxgAH5aC8OH3yStg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907463; c=relaxed/simple;
	bh=epyxwrL8HrbxoCP7PkosxUpgcxoLg7mTf7gK+mD/Juw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ImNrk4iKzYyy29iKr4ipDi+n3OTub9TiqmSlF4H6uVhHMsXr7XzPQI1PJ9c6RQyosSLOXqBLTjeoYxUIbFMGPEyrINYLrFnvZLNbDJ9zduqD6YfnxARbMNBhbmK8mxwaWbc8r3TeVaxZsbvJrOJv2nXOezPf25BkxK360IRkRaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sUuRjf0K; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUuRjf0K"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so187485e9.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 08:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777907460; x=1778512260; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8WdMGm0rrN8quly4F4KIR+pnvKVzpSZ4Q6VY0RQAP8=;
        b=sUuRjf0KbxyJMoH2OM2N9Q4R/QlouG6oE7rFuiylsWpYGaN4B/yNMUhXxDJ892tGZj
         LlebA4LPDobWTzyWlsRs9hmRTe3QMEWoIpXnq+uPohJxO+VP6/2lF8KwUuco6Cf+yjzT
         Zrpb/K923gsaeWOPhVbuQi1cFwrF9/8KRr9GxG5dKBWok+ND3gHiH5a+m3fjvIfBnmCi
         VI0iM8spmvZH9QJN13+z04WD22tQfgHRgR42HnJY3NWT/+454VmCuxP8a37N8OoYNlm5
         P9pHGYL0fmCh2pimvVv3yoUAok4RHVY3ywVcjqgke+NGhFukmmok0dXdqL8ghmHmpxyM
         U7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777907460; x=1778512260;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8WdMGm0rrN8quly4F4KIR+pnvKVzpSZ4Q6VY0RQAP8=;
        b=IyIy/bFeDD388JJdBqapIGH+k22RGr7dWcMr98xLr0RDTTs5iIaIZTgFXJnXZjCOBI
         BuVqw0/NXuuR8VQsv6Xo++0Q44Kn8YlUW1GAFFCKNKyvTRCn+1hICX5bFF2Nn0LVH/Lx
         wOn/jeBiLp6lt3WO9ngSqXqTBRkfa05dJb9xx0mjZdco5tawZQgNtVmSwV49irPtAYDu
         US8hUYiTlvdF2bHFHMZCzZ2mZwT3vchYJYtRvOA7h4j96Tsz/jHpqA/Zc5Z6uoMp7j6n
         urnNyaZ5z7cTz57/1epwcGxG+76nT0uwE3Fgq2h7Dvmgfjrn3OdYpOb5wESSdoNM9O7S
         daGQ==
X-Forwarded-Encrypted: i=1; AFNElJ+DNvFpgjZlVCR4JwowOE/oOMB7csokU3QyzB61Ey6RfwHpzpQOo7/Y/HR/wilaafPce++rTk/e17me6MDWgZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbc0rNLsDNlgz2brx4suJ8lH0bsaNkvEhcgLBMfC3U+WLjP5Dy
	JyVLibTVAvuM0znx+j2ZSJvYe9mceHuuOU3PoiZpCuayV3uYfPhkeL7qIryqy4z1ww==
X-Gm-Gg: AeBDievZ4XF0vwzpzR+fUC+F8tLQ80fbXzWbI4P1H/0+z4JhppdZWvt4RahhPXQVLLU
	st90n0kIBOpFx/4W38NcrGqMtfoUknzMaKGx3cr6fRl7C1Y/OEPdmpVqolwMuUUZBcdX2G4WN0C
	RcSEwhVvhulZmNbJwuXUeUB7MRdRB67v9SuLuggV0Fm06q6/2MI9l/AzZ1PVq248GXjzeWyX9um
	wPKSNgXRUYf+ow2V2k06AnZYHdy7g7rhAY+cdRa1PYwKNUB3dtdsI97ZvYnLbDU0ln7kuqKdvT9
	gODdUeIZ0JP5e15mfmZg4gwLt6mhwT8LMTnOZ5621nfmA+v7FWUkrDi2yiFq2XWAWpziXA99YBy
	sjx/9AVn1taZMh/NaC3wYru7Z5QZd1JFKBnSM9mu6tPcMYYLZ8fR+K8NqN8BnnKV6WNUBenFAYb
	+3vlO8L9R37iZiZfuGioeaHV6t1xlh0Y0gWzSdKx+tPUTiSZ1xbk0kEg3bK0aSLYcdImPj0m1MZ
	hRmMZvn8sA=
X-Received: by 2002:a05:600c:6c01:b0:48a:6321:87f7 with SMTP id 5b1f17b1804b1-48a9852d32amr2442135e9.8.1777907459745;
        Mon, 04 May 2026 08:10:59 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:ee16:7cbd:ae26:6ec9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee8751sm140677795e9.9.2026.05.04.08.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 08:10:59 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 04 May 2026 17:10:51 +0200
Subject: [PATCH] Bluetooth: fix UAF read of ->accept_q in bt_accept_poll()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-bluetooth-accept-uaf-fix-v1-1-1ca63c0efadd@google.com>
X-B4-Tracking: v=1; b=H4sIAPq2+GkC/x2MQQqAIBAAvxJ7bkHLgvpKdDBdcyEy1CKI/p50n
 IGZBxJFpgRj9UCkixOHvYCsKzBe7ysh28LQiKYXnVC4bCflELJHbQwdGU/t0PGN1rVDaxarpVR
 Q8iNS0f96mt/3A1I0V0xqAAAA
X-Change-ID: 20260504-bluetooth-accept-uaf-fix-df393cbda114
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777907454; l=2723;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=epyxwrL8HrbxoCP7PkosxUpgcxoLg7mTf7gK+mD/Juw=;
 b=QoIgBmQLNzGorMBeLgzY082aDS4VEiDU46sH6OYp3kRwhxKnglkde1HyRIGwFeBEpXI50XpAF
 ueO6oxPOUaSCINSshOm9Vq2+5uvIxVsKaQXkEMkLeGnovKOkGIyW8Js
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Use lock_sock() to guard against bt_accept_poll() racing with concurrent
close(accept()), which can lead to UAF:

task 1           task 2
======           ======
                 __x64_sys_poll
                   __se_sys_poll
                     __do_sys_poll
                       do_sys_poll
                         do_poll
                           do_pollfd
                             vfs_poll
                               sock_poll
                                 bt_sock_poll
                                   bt_accept_poll
                                     [read ->accept_q next pointer]
__x64_sys_accept
  __se_sys_accept
    __do_sys_accept
      __sys_accept4
        __sys_accept4_file
          do_accept
            l2cap_sock_accept
              bt_accept_dequeue
                bt_accept_unlink
                  [removes new socket from ->accept_q]
__x64_sys_close
  __se_sys_close
    __do_sys_close
      fput_close_sync
        __fput
          sock_close
            __sock_release
              l2cap_sock_release
                l2cap_sock_kill
                  sock_put
                    sk_free
                      __sk_free
                        sk_destruct
                          __sk_destruct
                            [frees new socket]
                                     [UAF read of ->sk_state]

This UAF only leads to incorrect reads, it does not corrupt memory; it is a
fairly tight race window; I believe every race attempt requires an
incoming bluetooth connection; and the leaked data is limited.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 net/bluetooth/af_bluetooth.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 33d053d63407..d24897167838 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -521,13 +521,17 @@ static inline __poll_t bt_accept_poll(struct sock *parent)
 	struct bt_sock *s, *n;
 	struct sock *sk;
 
+	lock_sock(parent);
 	list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q) {
 		sk = (struct sock *)s;
 		if (sk->sk_state == BT_CONNECTED ||
 		    (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags) &&
-		     sk->sk_state == BT_CONNECT2))
+		     sk->sk_state == BT_CONNECT2)) {
+			release_sock(parent);
 			return EPOLLIN | EPOLLRDNORM;
+		}
 	}
+	release_sock(parent);
 
 	return 0;
 }

---
base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
change-id: 20260504-bluetooth-accept-uaf-fix-df393cbda114

--  
Jann Horn <jannh@google.com>

