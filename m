Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917584;
	b=LkC6OrC7fx4UrmbBqAsdJiJAww2Cdfy7M+M6N5HQ0pZ0JaNhDM/IS8uwkSPjP6GgLqEC
	 zzVlAMKTSUCS2c7AcTm1GIpJbMCZF5JVgC+/czUpC68XKZmbrJqY6utXhyqCjGO5JOMPE
	 2lUijbXtts23WndqcupTBfmVUS59QZZ3WqTciSCBjgCQsdffZbHQ2lcxoj8u88vqcYigw
	 N6h9p5669w0f7K8hPLvq1Hq903ZFOINXg9E2ZzZe0Eg5hlKXL/dJmSP2Xi+CYd8EOQRb8
	 ssmsTnJNaG2kg2QE4Rr2U4hw2k7gj3u9X3lJGRYlfn3msVPB9ro9WmfZFCXekXMFaSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:Reply-To;
	bh=1EFzN3wkx86Qk8Jhfqlyw0WHReOR/PLfkTSOOjgUFfY=;
	b=o9GwcMFziV98bLbtUFBQe9ho3TRQhD0t3tLr1HDYyQ0qyWopQwq1sltKX47Nb+ge+x+c
	 0GVYmhixF5zkS7CGp0tJ0XlEaLNC+s0UQxmZeBQa4MXmRbEiwcQ2SDBYMaallrWt4V2q3
	 y/it6HNzv4KOIV1nJpFk+5+4Q8/MoXlzDzVrKRAriZiAaxs/MP7HC210G2RBD0UQL27d4
	 JDGHp8S7PjBemU+xKBc71Sx/JGrkSsw1ZhBAvyTASlyzAe6eNlhePIx9pQsOMXbigaGGU
	 q4yZzS17q8JZywej2SCP9mQ6EJaJR+GzjwJLDCk9L3liDooPFzcCAO8aBUUOfYWP0Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yoTIJrHM;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432B2606A326
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 22:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 432B2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yoTIJrHM
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-846566246e8so42516a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 14:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917583; x=1794522383; darn=vger.kernel.org;
        h=reply-to:subject:to:from:mime-version:content-type:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1EFzN3wkx86Qk8Jhfqlyw0WHReOR/PLfkTSOOjgUFfY=;
        b=yoTIJrHM/Rr9jhj25pY7Hpoifhg9OhJM5/drrvhnfDdPCCWfjN/nqchomQsQXLV8DJ
         gZdGNNHA0S4LgYUNXPT1Yoqf+J29Y9kCHscEQne7BJBGzqqXDDG5djozFlZF1tZ/DiSF
         4SpJeM0/frLeS3ez6MTjcHOA3JfG4FATxNhPymwv9v34Jg+W1wyFmoXYKFZhtskepYAU
         nEZqCi1RFiDCniAFzo7eZqBcQzyyyaQDcMB+pEUjRvcLq7qFZOvTSziPunY1MQ1idxBq
         SalpjaBZ9dUsetLx9jHp129Q4ojE/mXcDQ0cPrMw23kQjh03cg+I7YMD4NizHWLCYVIh
         y7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917583; x=1794522383;
        h=reply-to:subject:to:from:mime-version:content-type:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1EFzN3wkx86Qk8Jhfqlyw0WHReOR/PLfkTSOOjgUFfY=;
        b=YOt+eg8U4mKnreGLCOgMp95suIsDT5TkXihHqE634dFOKQbwQ9lACsbnLYYfAcHBi7
         KDWBHXPfOJuhvH5jEV1CMZuJIlp8GeCCvLdXLPpe5kEMO4/xqKIqX+xZ9AWIVuA8tSVq
         HYel+CHuKlGqGetex5ekNPivEUFbjLKVZlYWPsFExgusMNmZjwk/RnCtfqVPGNq7uOAI
         YCAH659ApmPD11b0TbDmJ53zyPDuTmMqnJ72rNPxUAWWJDIci3KUHmJ+v78K+hWPQDll
         i6k5SeNTndH5vFbffUgJdH+m5TI8yWNzmGMAhrrAw5btzB2x+zb+M3RFwdmRRaXyCqAd
         CJfg==
X-Gm-Message-State: APuU4Z/Nt3nn4x1arRN0GCPeMMZS/pbKvj1HOAEdQR8VO8I5Z3SpCqtp
	8X+t0c1NhBMyqV4C/bc1UsH2r7O+0Gio2ojsg04GaFTYk9y9LSGewMG8Tz7BaA==
X-Gm-Gg: AYBFou3XFgvwZRaTUgWq2HVQNVjAEO1LISDm6LmGlS2ND0jR3woFu4WIIVaOAb2QCDo
	HIbki39HpLGF7P7eQH8gNVtjBG82cZnd6rEJjvcXtQczR/4qFVxKQHN3f1gkYy5UjoXSCjwcuSC
	3/SszXdk3Yz4WuCRielOtmxedn3USVcgt2fmPCy6sGvGPC6bC0LqKmQqrty+nle/VDLPP6M6Dn3
	ODArYfF1s93cS0gj7mAAC8sSbIU6wVJJisztpb8lDCCZ2q2d8SKdpIJx9dLM+/EOqVPJjkKoJtk
	Z4SCKVGuP02NkloBq311WLA9BrPe/3OfRjuPZ77P9PN0/Tu8k3xMN6pLsaDYMI9jUn2avibdIok
	XzSjS9do+nspWtnsSpYSjyCrnOlf18l6COwgegjVNfW1SJtelAAH8MJpcNxe4HwLmcBIXpjoog8
	9+/KOXavyxcTEyabAARbv8lGUR9MSochmprRmD2OZSPWAdoLk2QAl0EY1r5Oq72uka8EfEQ5Mqx
	+wat59/qW1EMZGuKUSJgMbWULJEG4BAf/kf6CPwPUKvfykB0/GkB2C8DVvF+B3J
X-Received: by 2002:a05:6830:3d8f:b0:817:c566:93a9 with SMTP id 46e09a7af769-85f0592ada7mr2320662a34.22.1793917583187;
        Thu, 05 Nov 2026 14:26:23 -0800 (PST)
Received: from [172.17.0.2] ([40.124.101.220])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f1dd2bbb3sm562970a34.18.2026.11.05.14.26.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:26:22 -0800 (PST)
Message-ID: <6aed028e.7b3c481a.202ae5.c46c@mx.google.com>
Date: Thu, 05 Nov 2026 14:26:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1745549981731764562=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ] Pull Request #2699 was closed: device: Keep profile requests on BR/EDR
Reply-To: linux-bluetooth@vger.kernel.org

--===============1745549981731764562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

The following pull request was open for more than 2 weeks in the BlueZ
Github repository and it was closed automatically without taking any action.

   Pull Request: #2699
   Title:        device: Keep profile requests on BR/EDR
   Submitter:    chidam333
   Created:      2026-10-21 18:31:55+00:00
   URL:          https://github.com/bluez/bluez/pull/2699

Note that the BlueZ repo in Github is only for CI and testing purposes and
it doesn't accept any pull request. The patches should be sent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) for review.

If the change should still be considered, it must be resent as a patch to
the Linux Bluetooth mailing list (linux-bluetooth@vger.kernel.org). Closing
the pull request doesn't submit anything on the submitter's behalf and no
further action is taken on it.

---
Regards,
Linux Bluetooth

--===============1745549981731764562==--
