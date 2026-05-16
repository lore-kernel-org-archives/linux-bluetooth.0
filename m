Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841A405C4F
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 04:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778906784; cv=none; b=VETS4n5Xc492ZReLc9JkNMTfp31eXbpSgC5XIrfv1welNGRwwml5RxWcWup/aFLC/keFqHTSnMSTRVDw4z62KfjLo1fhJMONOpyzca58lAC47/RFUTPr+Oib0POpN3U05V1Hvj6VP66KlYwtefUq+JorJw7SjgbO6p6IcNbjlYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778906784; c=relaxed/simple;
	bh=9FWrd3emjwZ56bVMoqWIjOPR4k0IMq9QjElohqigJS4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hQQX0JEpPqH1tMjZsw+SFrXRoi4mF+OnikYl0BdpLbUZSdELAm/Bxgo4sBmCuW6FZbgEU8dhLw0QcJd7GjmEZ/5NYXOB5bYrYKn2e/a59/S8/6y3km/ZMQ/pFsBj2+JSsNNTljbcc7RD8XNL/R2tE6iYeuaWDKPECgFJa9UUhHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkoC57IZ; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkoC57IZ"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2f0ad52830cso684860eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 21:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778906782; x=1779511582; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9FWrd3emjwZ56bVMoqWIjOPR4k0IMq9QjElohqigJS4=;
        b=hkoC57IZPAdePnsB8mPhuMIDUAHms3XVz3uEO3PVfbcU+5ylZDfsvr3yyLBt8E/BJK
         N+Mac3ShUeZjCATCN9By4LyvrRFc2fddfOx2Zy1qFN/DVl5KhIXhUpGBzeeArX9CpTUg
         QPlOL1VOopTKEuEKiN2IJXs53X/eBBcpP0JyaUE2xiTlGibLdaG00foe/ksWWsFaUfBH
         7XDs+O2Avuu2EpdW1HQ4+kCvqpQ134734ogq/Oxtk4WLe3ERTVtkk1xPi42os0tgShxv
         HhdHwMp8TLQDHBKc6zakFZkeBBwWzr4pHZ+V/umOAQySOwJBxXZMvg+Y4HCO52LYaGAQ
         9mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778906782; x=1779511582;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FWrd3emjwZ56bVMoqWIjOPR4k0IMq9QjElohqigJS4=;
        b=E2fgVCnHHFjs9EAkBB7+X8qJi9NOmcSwe67S5l+ML+Yw68wZkDmwrA6Wnk79f19CD3
         KQzwlVN2NBgPR3+b+bvnvUMd1QGyLy/vk3yKgK72lfRQvPOYYTOdirjioDiFgAVfeyi/
         Q2LukA/2tHlBKujf40rJ5dcS5PrtsKdbpcB7NaVO8TNoWEyoOCDr+Yhh5UJm9/OCOpOW
         dI/97NNczT891i+PxH5FN6SmjRs5tpxYKY56IrX7YDO4/VINadS+SqmjgQrNIX6hy8SQ
         /lyAfUBiFEQNaZRJPUh9IpBLOBlyF8eyAiqDBfyPWsNoLBiVGX4Msxd3KImgV9p8CLsV
         vgvQ==
X-Gm-Message-State: AOJu0Ywo5XsN4lbHSsb1aByYyfMbNjAsos2r48ZppR2jzgYZHAzs3DS6
	ZD0DFmZa1bZtmSMnngCjPvhcTkLhhWDPkskW276MEdUCVayiFCiu1jrfXZfR9g==
X-Gm-Gg: Acq92OGwKt3+wVgrvW3qlJSmXCbq1wtTCkv0QaR5cWUHlP4lqzHrKf7cnodZOFWekVi
	Zobtv2FVcOqihbhoagEatTz2zkdWYjFUS0DCU+ULf2khdqdre9HLN5Ofb314bJk5oa/3Mp48awN
	JqWCw2OYKlVb/hMIcsJ+RS6hCVGgA2QWQBxCLP295T7sAAh/wXDFfAzKaBuBmjZuc/fEbMHV+Zk
	DLWkPEnBWGNcCNpHFjGFfHjoSh6c6neOh/RbOVUtH/pmf8eh5k29CQzK5cLaUsojXQ7w8nc3JpG
	s9j7DEuzS/9iFzlgEowt4V5E1Tqrqf0qU65EC0Id5zU3TD7kmHg0cw9GKs/6BZdpFlMfjVKAi+5
	uLpwuzhAeixre4K+Q+S8LGfGcW+sLZjmRQbxRyNMDjbsaUqeacV+pLoPuIYWVFTprVd3iHEmq/X
	NCXAFXPduDpbbCUrSBXJrYn2tJX7SJ
X-Received: by 2002:a05:7300:4307:b0:2ea:5057:a331 with SMTP id 5a478bee46e88-30398655963mr3333013eec.21.1778906782099;
        Fri, 15 May 2026 21:46:22 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.227.1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e686sm10424523eec.5.2026.05.15.21.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 21:46:21 -0700 (PDT)
Message-ID: <6a07f69d.d5797644.3a982e.8420@mx.google.com>
Date: Fri, 15 May 2026 21:46:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5091812217174337692=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 2022090917019@std.uestc.edu.cn
Subject: RE: [v2] Bluetooth: btintel: Use skb_pull_data return for bounds check
In-Reply-To: <7dc0dfd1-7e23-43d5-a855-d1c73943d40c@std.uestc.edu.cn>
References: <7dc0dfd1-7e23-43d5-a855-d1c73943d40c@std.uestc.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5091812217174337692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel.c:3356
error: drivers/bluetooth/btintel.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5091812217174337692==--
