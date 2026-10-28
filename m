Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793176013;
	b=AK5yMWf2YHXd1GNRDO3RIOIdMcqaAr4LXu0v2YG6ywy/Nls1TZNfIVv3ySYUHWvmDXw0
	 OLJ5GmMyd6E+Tobwn1bpc/TL/NPCBjIAl9+gC6j5lY7nvrrHwQQBjAnQdXpOGCBHI6T8n
	 dNE25dBKJ/i1win5uvowDCxFpgXq3tOJx+DLAFNV/JUWjsPFlP5XK6n17lBb8OMFmLEQX
	 z3pHHWFot2QptkfB4kmh5vdymQ8QnrDWGkgOCAaYSRri15yMo8Bw7RykrnbAe49of+FoL
	 K66zB4vRDUc8pvqLODqtY4Do4/u+yfpcbezxMws9850Pa98vtLzCUoTvAvXVl7GV6Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=b7CwUQbUvJjxmflbs6+ekbA2/53Y79xhybb3hcdXLwo=;
	b=fmNGqBFsdwYGeZHJPbdmrvGrAjXRm4X3PaXLl8CItARZf0ayIcSX1gdERrLyPHMzBOp/
	 bvj3jGG4cChcoWy7MvA0jsAA5SA7pp8Zr21+QIzfobrRCxdAUITAda0uCipBpVO8l2FH9
	 MAYb3JWcPBraaAI+ps5JWJVDTrclSN7UtFreAnFqkQK3R0X1UlnnKFT3gNlFz8p/3nu6s
	 zql6O6RMWXJfQMRRaFa1knNWz36lvTKXXSPYfVKhkwGdBjDNDpAJxCH3dd31X9oyPEup6
	 TByxrjcTp+677hkcknt7zXOU23joR6VsJu2Y5D9Dy5yS4NBocEsSpEmskLGGQKwbo/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MJZ49fTK;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792DE606A31F
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 08:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 792DE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MJZ49fTK
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-846566246e8so634430a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 01:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793176012; x=1793780812; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b7CwUQbUvJjxmflbs6+ekbA2/53Y79xhybb3hcdXLwo=;
        b=MJZ49fTKPvx7euvCSpzsw8p9kV5vJbvnCEaCzqZuKBLBN22vDq+fq2aP5P3RaiJSzQ
         gSPF1r8YJSbwE+0h7xjqNdx6p6m/bdCbuEWe6OnPvMkYPV9vst0/Qqf8T/nWqMtWDhMa
         EC71YOG41FvBzl2+fI4lF4jNnnW8/WtITPDf6uoY74pjIM5gez4+YhXmZMRLw7PK2lz9
         fkS6lsnnwNFzZ4DuhnuX7e+hg43JZF95Jbe4iP75yWKKiC3GwaN4BcG8Rayemfia6GlC
         YSZR2HSy94CkCqqGdx7JthRqellazRnweaEx78FnwTn9wWIePQ4aFi3dnS0YNb0CE/lJ
         miQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793176012; x=1793780812;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b7CwUQbUvJjxmflbs6+ekbA2/53Y79xhybb3hcdXLwo=;
        b=HxC0BkgrxvJEfRB3LcVWaKMm4YgZrM1p7kxFfx3B4oL1cRHcYjpi71HM5k5T35lvps
         T2lZYh0gptA20UZMrLjKICV3f7Xy3x1UTFXkF5SN7VNlCHh/UmYNYVOHCbrBJQtWxrli
         CB1w/SiTc+rQGeaPikXRObHWu5Iq9osd+G/0v+vL6O3Sk7Cn0CSCGkIH/WP27u02vuNL
         sKTNBVTiPF8TU+FNVNJdibwAXp3Na7BrDc8bgn/KjfbCUGsnr74K5AkePB+OoPnBaqd3
         zPd1xdJJUOldKQAbV1Gf9nORIvpEiamY6N2zcpqsY3wu/NPnOHOj8OLjj8fvY38pz1wX
         bnFw==
X-Gm-Message-State: AFq9FYKyH+RX/6lLh5VKVQ+EXUSRhmPyp7EGaAffn974kxzWcxtlcl5z
	j1dvEiVjUphwJ6OxbqWR+rgGos87/M2R8/wxC/e1ljqID02D2D8sNsTyPK7gZw==
X-Gm-Gg: AYBFou3kMVR3a7pJ1QP/0U845QghpOwByqjP++fmo/fzJKAHoHYAh0Tl+RYGl0mXlEx
	w4Pi7m0KCwIzW9BePyQtFekTnpPJlTkq/T8IM9LxLg5YOypTmA1P1FzNiiaj8utwEFiMeKGcwgh
	bzj8Y9N6GmFtuYZ4emoHsFHSmyg4iIRSBbAJu66ACK73RBITuj7sdjUSB2iskhaOpigGW5kq4rR
	HOG8qWEP1vSLNPl8AmS2LfMHtzG8KoMrwqZcUXrVD4/8xRoQLQzwJve+P5NeeAmNRQsVzYbIrAD
	abVTF15voSErXDt2TKhXq2fDzoTL6EnpOt3p7fGamvtlhS6RlypRi0bflQSxkLtM8ozBZjtQB0p
	riVNa0TmNtKfCSXl72rGt6WPeCQBeXXFBihTqOSZ8hfcBwdsfp3wklpkq2v6v5TtzOrO9404kqJ
	5mIy5nRy7MUvOzRcSTTT3sIVWsOUpVt3Z/UDEPPozXB86Sgoi7WLQm1JbYEbBNdDLMT+MbWmTgX
	04Y/B2F8P6v5LNqArIYgQ0gVoVvuXRSnxsFkvmN//Bb/tYuSdjyVNHdJR4eARpG6w==
X-Received: by 2002:a05:6830:2e10:b0:822:4c30:8f04 with SMTP id 46e09a7af769-85b20dd2799mr363059a34.13.1793176012347;
        Wed, 28 Oct 2026 01:26:52 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.136.241])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b205fe36bsm980089a34.24.2026.10.28.01.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 01:26:51 -0700 (PDT)
Message-ID: <6ae1b1cb.674ba918.22f667.1318@mx.google.com>
Date: Wed, 28 Oct 2026 01:26:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8160363829027681156=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: shared/asha: send STOP without waiting for a response
In-Reply-To: <20261013034345.513789-1-cochcoder@proton.me>
References: <20261013034345.513789-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8160363829027681156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       shared/asha: send STOP without waiting for a response
   Pull Request: https://github.com/bluez/bluez/pull/2664
   Created:      2026-10-13 04:00:12+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============8160363829027681156==--
