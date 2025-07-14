Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B734C13D531
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519721; cv=none; b=lqdiH9CKOTHHNfYpz1ccLh44lIQwSjkQHjPHTruA7jBmgNE4NcJ7XcQurjrgAjKy8OYaMW+7FmLDTgitQBvojDT0AqztqS6h+XDn28s6xfVCk/T+fFsrb3+wVCuBkakeFqEXqckVuyi5+4NfoQI7wWVNbH9d/jJlzvMQZugmR3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519721; c=relaxed/simple;
	bh=EljlR3l7iwWdWQKXwmxhYCdUQ9GPgRyhxJkiX4nnroQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Cigilr6R6dRcCgpOlKyjqRMFquBJpfCmYIUex2C6AUjCU2GF85YdiFturrzsNa3JqVF0cow84zFEtzDKqVWy7knZ0rWkzHUZoIt2CwoIwFUsiWOO92hMpF8OFvxoTfDvHa+LtkdMm9ZTt8vDP4yohLjZBd/8pzV84OfTTf+P2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBALAZ/o; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBALAZ/o"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-704cb8b1314so8319876d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 12:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752519718; x=1753124518; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gKLRHQFlXVtZUSErHDFLxLc71CH0iUq/TabhaWyZmF0=;
        b=FBALAZ/ogiQZzxs3U942jVRSoi4UJU634mziqdIo8w8v54D35Zsu+vpsLgUjT6d5FV
         uTZbrqVm5bu0hQpiYhtG08KBCc5HN0ua77rOxRnMpGMKVcCgE8PeDZe6LwFGBgN/TWw7
         Bnpmg9qtRLDDxGxd05TVZVZ0GqSfBthF9bLXmV0EW8Xs+XXqVimgEwU/AW0H3/G8QVCz
         yPH9eGaYG1OWfldY4K4O1aSj9zBo4xyQDJBHSvPtrXCZ3NgrBhKGL7Z0CF/eX54+ywlG
         LBIOCb0nhu3SHQZWY8SkfJvtWrK1KEZYy17ZaVedO5EbOpPGnZtrYaAR5OGeLSEJ6S3d
         x1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752519718; x=1753124518;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKLRHQFlXVtZUSErHDFLxLc71CH0iUq/TabhaWyZmF0=;
        b=AKfeL2btXpscA2I9bf41X00N6WYU+SKvEeM2ap9ngbCERvIQDm8ogC9RBGxAiym9qN
         CytPQLW4ux3MWsRxypyGRDXpqnI9kvm7iPv/nFVKYbYtAhfZX3ln/sB4hk7TkM3BWsaw
         aTYHEAlhKwp6ckPZscTCytr4OPGHm6kt+Df2B+1mOvRgrmmbdNgdyPWcPdT6Uh9aYTvT
         9qWAsTZQBxyjD2YbsijbjD7sw4RJ5TwUfUjVnozKtfMZD7VR9fBWMba0n0MOvWI6YH6y
         +Rv8LJFq9u25PIeDdcLmQG+h5Lue9ObBd+RRLwp8+xa8jpiZtOUkoP/aHy6MglDQXMZa
         NtMg==
X-Gm-Message-State: AOJu0Yy1zxckYXwV1lfu1rxG2GPjYGJiYbiUkJOdyPTHzeSfGAJZEaJm
	jlUsPyxtXBoQHMoyl+Rp5bS6GMtQc1VBLZyZi18d+qGIUC/ka3qkCO5MzrnuEA==
X-Gm-Gg: ASbGncsqVN5v/KtbjZefMjnh24OYpyoH9Vw/LAsrCLN02yMRLmcLbizI1ZXFW5gNt1l
	W3DRQGskJIFo6uan8bEpzMFXevLu1mxyq+PWxk1MwisZbej58i8ugWJWqzyAJTVJQABPA6Vwlyw
	ZkcoHSir6Mz8ZmPzjg8C/uUY54F4SWBMM7AlS6ao5/s7Ln+KHDKPTu4JIa75EQrsx9Zwmt7uWZY
	NPiQ7r8Mm5VcBh+d+1mdo8Gw2mrg5V271SstHoOAY1LcH7IHbgRpSH4dctR4QQbm2T53s4FmM5b
	QnQ4BY1P4HGiW1zHFE4s7r3vfGQPCuWfqaxjLS5aBaEv2NQukSe2XfimPQbL9rbm7nlntmLqfcb
	TrTblL1t/UGhclHtK1tCeyFPCWhI=
X-Google-Smtp-Source: AGHT+IHJZ43ljZsbfOJEMsp3aJPyjfXqjxcR83D32QuFxYZHIYrDRCqdGGb4sOTzXJlIa+S+B2kLGw==
X-Received: by 2002:a05:6214:400c:b0:702:d634:1d03 with SMTP id 6a1803df08f44-704a42d8f42mr230734816d6.32.1752519718110;
        Mon, 14 Jul 2025 12:01:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.241.105.9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d396e6sm49881746d6.57.2025.07.14.12.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 12:01:57 -0700 (PDT)
Message-ID: <68755425.d40a0220.21ddd3.3744@mx.google.com>
Date: Mon, 14 Jul 2025 12:01:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6156684015087428547=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] doc: explain SCO and L2CAP timestamping related socket features
In-Reply-To: <8968b3ef55340c6d7b16c33685aa87e3368b526f.1752514576.git.pav@iki.fi>
References: <8968b3ef55340c6d7b16c33685aa87e3368b526f.1752514576.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6156684015087428547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=982181

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.21 seconds
BluezMake                     PASS      2543.70 seconds
MakeCheck                     PASS      19.83 seconds
MakeDistcheck                 PASS      183.41 seconds
CheckValgrind                 PASS      234.04 seconds
CheckSmatch                   PASS      304.47 seconds
bluezmakeextell               PASS      127.37 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      906.02 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6156684015087428547==--
