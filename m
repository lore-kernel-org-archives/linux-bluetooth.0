Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AE53101B2
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 05:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896466; cv=pass; b=nfme9W42BEAEF8P5P9hbsU3Gk+3RXNzXMy/x4MVkiwrBYpi2PMdo6RPjaOxmbdpJ38sXDOUqjuT2dc8qQ2W2ZoS+uy0vSej/6BGNCWp8twV0EYlQ4aiVcVD9uC/vipxz4ee7qy5A1H4qS1W4/gAQLNjQdUbZ6nSIVqtuvx7chVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896466; c=relaxed/simple;
	bh=/0Cdw4au/NWAOW1gKcqBCl9EGWFO+qvu4+6nyz58oT4=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=BXhlIfoV2TOJHwOlgmwHR6tk1ufI5xmXpFCay0TPPDgia+czaRm4S5a8VwXMUUmJ2DF5ps/okMFVJtGTWmia85KgmFUXFr7xU/a5OdSK2cyD1o6ZVALfIzgbDzV8iPv7w4OETqVKYHWIojD2HWFLEaSCRwdFHXB1jejdBgF6XqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=BTauciyj; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="BTauciyj"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d6f9e2f681so3972465ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 22:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787896465; cv=none;
        d=google.com; s=arc-20260327;
        b=M5NGWwAl7aTy6luX213cu0NZVkVgxh2vOAtJtxFdec0oTamaHZGGQki3RHUZVnIaUk
         OqejUIhR5bpO/zindGfoxiXc/s2GU3x001k0xTVgejCO8R9pvEtQ8+GOL4cCDo2crp4K
         ggSpJJx2wSHiYWlb8hs460NItNkKuYy3DzH//AQdXVlocFchPQLlFd9iTKP8bgLuCPwr
         N01n6NaYg1lGboL5i27FvaVeSA4CvCjbPGVr1TKcb9WUUgJTpN+xCsYSjuK70MhxaRaR
         6FG1Hs340fpC2phK7Foc5IZXXTt6liVEPBoJo5a4xFc1NqIXuOCNMLoXamBp2e08yS/Y
         dC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=UZoqGay6KxEWFh3xndMaQNDY5TP9TwG9uYWqZuch+Fw=;
        fh=dSmVJtgsw88mNpwZ4Hf8W9FAFAqrVSPWNOZLPyeX93Q=;
        b=EzB4P8iwM9jLKUv0SqHKoB+KlEi0IF2BZ6yFk4cl7Q+8IKRXIuF73vu0pQX08XzObO
         PfENY9xf85xSSii6DKx1Uwt+yWG2vrDSxH+o3QTr0NkmHetH6FNozCB77Mv/+sKZ6Mgh
         UOFbXhkfhtkM0XNIwnWdG2/cmJSyAmVKECNyfCZQXTK74L51AU0e1N4uVAbwS63+ItJn
         goG+4OHaqEGnkSuANacVn4Gh2zZGzzTpB3iBm18TgPG11iMyQPPc1EL37Wcux0vFzRaB
         ANYz//+hidRUbELuAmgNvp+OBcFXhD8BwY2OFFnZ7dZXC7jx/2//QH7Jhivhco1quRsv
         byQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787896465; x=1788501265; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UZoqGay6KxEWFh3xndMaQNDY5TP9TwG9uYWqZuch+Fw=;
        b=BTauciyjJrJ/o/uyPradylDDgOcI2GMjrNIwj5HMMvyVuNnes2yM6Pnm4HF3sygsxP
         UhIYAec8mlm5AQT+K+TEk9uygYsqKkICobH4DmDNpdRk0WMPXk9OpXO9Q+Rj9FJk6lF+
         862SL3CI4JowCCDcsMYBXyAeBr38tEM0WQJP7BP/d+Hvq8Z3y+VeNx3lZg9pRCYTk+PH
         75DK87x2IiA1afTV1vrqFrfBLElbq5tg+Vb5tyMuVhMx8GjZ2hR8x3E+2XWIfWYLY5gJ
         3YXpTYDq/wUdMv0C+k40U2mlrdK3dkFynrlFIlOHjycxWqjBeJl+Riw+IPiLunBqvXX4
         kMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787896465; x=1788501265;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UZoqGay6KxEWFh3xndMaQNDY5TP9TwG9uYWqZuch+Fw=;
        b=VWQWvmet2mBPGN6i4xEagglK4WE9JU7FFMTKCvAAEkFkxgh+MMwVTG62UyGjm2aGbG
         d/7mOi4taEexqBP4+JOinAz8C6DirOFwAH3AYo0TGGL844qZDvvLZhzOM4a7St/maHaJ
         frvq/SbgMxLzFDVL/6lXaSGw7CkXW5zIaE3Rf3oUbAa9HZ8foWcWkQzteqUKyndsOSEP
         Dwk1O/7pPhe/OW4mp9mk2iibTkCuPPFyvurLf2imBxSlO+XAzlk989iNFff8FdJSv6sF
         opx/prM4uWKLIunV+bHXeCDPTDyE9ZW7MoeEA/frVdX583knXh2iOURuPcb18QyFBNDN
         01gQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq/vX9eVaIJg7qYIirjiLfi9RfKboM3ICaJ6Pjt+MRq0OsrHGFG/M2IzSpHPr09UXKJDXw+v28TBjlligJx1fc=@vger.kernel.org
X-Gm-Message-State: AFuF++mMc5EqvkgbXcO9Ksn9JLqSdeJQnbx9LEiINMvSwU0P8sBpHQyx
	pTbEnjEOKcwRs3U5JIWEfUcZMi8hCDnGC+lSpkH018gCEMAINpg+QbweauyohRsK2iG85tmbs5d
	iX0RzuWsk2wxk7w1FkRnqy4O88g3+XHkdLoSgbRtl
X-Gm-Gg: AR+sD106Ils10/11s7RnY/PSuzfeYlhaw9/I58tC/lJNVgTsURgD7A4eETzR35RWgu/
	Felz1JHRQytuNOkh5t+2rPsDjUrU268L+j43x/WNSVuek7G67iwi5+wV6Uqk2QK16+UmbkW1Kqg
	mQ+xcGOYPkXdIuyDaBXyd6LEb/rtd5mJucDmjzFoQxjs3QMLfVDK5rUZbj5NI/4X6MDcYSbTnSk
	BKqi4wDGoD8uRi2L4DYSnKvwEYqtIZuaYGWWutAD1GGC337LDddhEh8a0hWrXs6kybWWSLHBJei
	HFAuZgxBNoKRntXhpEF1u8OkM67ox6H5Q808VUET0XOUEfKjLkGhfKAdlWKn5biHFZFI7/FPuHA
	gMEgjZbOfc7ANN2vSrJW2W5DWU9sCwrbk
X-Received: by 2002:a17:903:3884:b0:2d6:3c22:993a with SMTP id
 d9443c01a7336-2d74dbe96fdmr93208675ad.3.1787896463846; Thu, 27 Aug 2026
 22:54:23 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:54:23 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:54:23 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Aug 2026 05:54:23 +0000
X-Gm-Features: AcwNN1WqSzPeWvvBW_uhjPicafIKj_L5muzKaoHy2ATtmGpknySjkignXwdG-og
Message-ID: <CA+0ovCgjFA-dX-jdTT22W0SM6UFiDb4L8GFn=Sq7Z=cAE_Xsog@mail.gmail.com>
Subject: [BUG] WARNING: ODEBUG bug in chan_close_cb
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: falemi@asu.edu, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/200-warning-odebug-bug-in-chan-close-cb/

  ODEBUG: init active (active state 0) object: ffff888114db0d58 object
type: work_struct hint: delete_netdev+0x0/0x40
net/bluetooth/6lowpan.c:252
  WARNING: lib/debugobjects.c:632 at __debug_object_init+0x2a8/0x4a0
lib/debugobjects.c:790, CPU#1: kworker/u11:2/9426
  Workqueue: hci1 hci_rx_work
  Call Trace:
   chan_close_cb+0x3c9/0x6a0 net/bluetooth/6lowpan.c:819
   l2cap_disconnect_req+0x305/0x510 net/bluetooth/l2cap_core.c:4515
   l2cap_le_sig_cmd net/bluetooth/l2cap_core.c:5556 [inline]
   l2cap_le_sig_channel net/bluetooth/l2cap_core.c:5598 [inline]
   l2cap_recv_frame+0x8ab5/0x10400 net/bluetooth/l2cap_core.c:6964
   l2cap_recv_acldata+0x682/0x1330 net/bluetooth/l2cap_core.c:7688
   hci_acldata_packet net/bluetooth/hci_core.c:3855 [inline]
   hci_rx_work+0x4f9/0x1040 net/bluetooth/hci_core.c:4082

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
