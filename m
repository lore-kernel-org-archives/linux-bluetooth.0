Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684054;
	b=KmFrqSiKNyOT+OzXhSUgfVgHpagCfQMcT8VEhK8wFE1wcZKPtfQ9ZVkLM8iFnqBD5Lc7
	 fLEUtJAVf0Vgbq2LKWQNho6yXAfZLvGeH48H4Vtkq9P1XO5J5HQrmqILhsJPFXYIsZL6M
	 Ei2GI/mRtxALMymgrYNfJZqlJt29lzs8yiJNg7Sj5igLV9i/WIGNTik5QMvmxCsVtUQuJ
	 rdtlJeJJNi5w73blltwtHXEkReBWSBn6y6rxyZmt8jaS4zsc6C6mK9dpE1/i/o7jXhZHA
	 ym85LkTsOChCy4gS7CvtgobVhx2TGUd93YoJpVmNJQwEz9x+PL4AUK+gwrQvhjS7Scg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZNRVBc4gfFhu1iUE/Ev6dMj13xtV8ch3uxkNNeI4USE=;
	b=lUXVB5CuytiSrIMGxterhqv5ireN0oxPQCWPeF5V2F+xW+SyESTB7CazicTWVL0cfuKw
	 hHchNB1RXgqanc3ud3RMVp1hbMuwdbQPyNyr5pklr26Yl8Dp6yQdpeG3Xbeg1m8+qwumr
	 eyuPYrDcPm+X/EPglFtZBRmFG6t2wUdjn6B8wwiRNeJQibZC9O5iFzVQ4DKMJpuz8t0x6
	 2GJyq87cmJC5d9a1o3UNbq3Rf9Tediw7d+sLHD6E4Ds0Iw3WUIly4xHxQCE+IpRAq04qj
	 W5msb/P/WKMw7u6++LGskUtZtE8wB8PiM3Zec6JkG75SffPIEmtFzeHpa1KZKgnu88A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KKCKcMwE;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12356606A319
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12356606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KKCKcMwE
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eae1276409so843e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684053; x=1793288853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZNRVBc4gfFhu1iUE/Ev6dMj13xtV8ch3uxkNNeI4USE=;
        b=KKCKcMwElNfIZ1C07+Qrj6zKyUlFUkbI54bKNYMov+T8QYhRUZcIvl7G2xfb/V1c+G
         J4sIHEzc6LWNGaUZJxdrQ7VQf0Zymdd1RXHKVIYVBFLyyQylBikf1lC9ngvA6QGbBE3T
         92NOGnwqpv+coiVkO83Hq72U6z77Q0Nd8MMp4VqVvWNUSRBHCrjV/BYYXvxlJOIYxhh6
         cWgSCmjXUAtxs7ews2qe9WeNYEUGDULquPI821FiWjWC/j8QmG/ANJtkU0bydvAttdY2
         QBsH4FCv6tweJX96QvekY5dPE3038WfPlYi7hi//T3Lr/v4NcWS+ZGyTyK9HOUOSOEjU
         dV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684053; x=1793288853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZNRVBc4gfFhu1iUE/Ev6dMj13xtV8ch3uxkNNeI4USE=;
        b=RmilyJdaSwAe7PTC08Uv6nE+h3U0yjbeSh9vB2TFp67vXaMbT4qR4y4Ypr0SNblp+R
         1v8TWqBh+VvrnFTDI8sulIfKJzhRTuAZO0GlQJKuqgKuaVhKF1lcMD3x1R1jNaxebWlj
         tQsuvS3KqA8Sc7Oxrtp0lt58Ze0PI8NLQUsr/cJtxNLQHt+r/1YRZ/m9UptVOGK06CUb
         wfgUnoz4zT9Hdy+5+YnDr616VY/XVk6mu74eW87Br47Nx7F4Jm8VwYm7su3i2P9M1Zwx
         2dWdm7NuWP72Qd7wljcyftEBcq3n74R8GLoulpc0zKptuTrGIUPzGyfJoITcVSOlGev4
         QfiQ==
X-Gm-Message-State: AFq9FYIFNzEDSMA8aGEdqBhE1mupLNpkBgKi5KEm3jNrvB6GQmQaMlde
	pYOuzAXg+pLfYLyNTbY8NdqdI121AjXRKu2ww9jaOgs0+oMjMkuwIY4NylAt/oVIBrk=
X-Gm-Gg: AYBFou0HdSGLzjwPeqt2b4nvPmj0z5IeV4kRNEFbnlXOfX9ZIVA7xFM2Rmci/GqXZF/
	dHrKIkaxzgE9d6tL1Uvz3usIryZOkfrpammZMZYxxRiUcsUAibuWdXVXXNAsNbAwjvkXQ3OYhgo
	kj2bzw1UEw3MKlofdS3Bh7XwoF6Ofgef5w3+AuZP+CiYgTUTmOdAnXN07qfioNqihfXOwAj0M29
	cWet+cDvdDFECgTQCffK4VHBPlHsTWsoHM0nXhUaafOvzti8TRYBRUNsG42miXgFoenGy+VXkbG
	6POYrpkYnocCuo/y8Ey4P55HYBwpf79Idi+w+OPYCD1iTrx0lScoFLkACMeTDIhjf5o11yTSfxe
	0emGVAvUbBEyGvQKZiD1K93BK9FIzHvk79FxDy50rOQjTRDj79vyU00sNl0euj0kSpkO5LWU+zX
	8fXXKxN9ec66sCayOpPweego1KTdf3KqAUPNyWLpch/prYPRCEq+tpxGXcvHUluFd8FoVqb0ugY
	4dIEhEHdF5bWWXX/NSmKalLIB/1veYC8eJtM5fKgp9v93torS0h3DGucBm3/sPgdv7YjkmHf0XM
	2lFHuDjbSTMAvHd/+VJ06aKis0afa8RCnunLaGl1ZtHcKg==
X-Received: by 2002:a05:6122:3b88:b0:5ea:c6c1:8dd4 with SMTP id 71dfb90a1353d-5eaebd457b9mr2256218e0c.5.1792684052932;
        Thu, 22 Oct 2026 08:47:32 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 26/27] doc/virtio: Update measurements of the testers
Date: Thu, 22 Oct 2026 11:46:59 -0400
Message-ID: <20261022154701.3959500-27-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Update the wall clock time of the kernel testers, now that they run on
the mainloop, which unlike GLib does not read the clock, a system call
through the host under User Mode Linux, on every iteration.

Assisted-by: Claude:claude-opus-5-5
---
 doc/virtio.rst | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/doc/virtio.rst b/doc/virtio.rst
index e1148a50c797..36a90e01de4b 100644
--- a/doc/virtio.rst
+++ b/doc/virtio.rst
@@ -375,14 +375,14 @@ version and machine, User Mode Linux with seccomp, with and without
 **-T**, all tests passing::
 
     tester            tests    KVM    UML    UML -T
-    mgmt-tester         514   83.6  111.6     42.6
-    l2cap-tester        111    9.6   13.7     10.2
-    iso-tester          141   13.7   24.3     16.3
-    sco-tester           30    5.1    4.1      3.6
-    rfcomm-tester        11    3.6    2.0      2.6
-    smp-tester            8    4.1    1.5      1.5
-    ioctl-tester         28    4.1    2.6      3.1
-    userchan-tester       4    2.6    1.5      1.5
+    mgmt-tester         514   78.2   94.0     20.3
+    l2cap-tester        111    9.2   10.2      5.6
+    iso-tester          141    8.1   11.7      7.6
+    sco-tester           30    4.6    3.1      2.0
+    rfcomm-tester        11    3.6    1.5      1.5
+    smp-tester            8    3.6    1.5      1.0
+    ioctl-tester         28    4.1    2.1      1.5
+    userchan-tester       4    2.6    1.0      1.0
     bnep-tester           1    2.6    1.0      1.0
 
 UML runs the guest's system calls and context switches considerably slower
@@ -391,6 +391,12 @@ small messages are slower without time travel. With it, tests that wait,
 like most of mgmt-tester, take no real time for timers and timeouts. Small
 testers are faster under UML, which starts in a fraction of a second.
 
+Under UML, reading the clock is a system call through the host too, about
+6 us against 0.02 us with KVM, where the vDSO answers it. GLib's main loop
+reads it for every source on every iteration, so testers run on the
+mainloop of ``src/shared/mainloop.c`` instead, which waits with
+``epoll_wait()`` and one ``timerfd`` per timer and does not read the clock.
+
 Time travel helps most when tests wait: timers, timeouts and idle time take
 no real time, and the timing is the same on every run. It also lets
 controllers outside the guests, such as btvirt's or a firmware simulation,
-- 
2.56.0

