Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6FD3F1643
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791575564; cv=none; b=uWpL7sewODUnoS1v95MFySIvfFXTsMD3HZA+4XIrsEY5QzMt4rlPxCHQJpEZIcx8thdmLAUXPFEQ3a/km/017OK/94QHsF0e+MUk6tzmrVYbxSrOVGWba+UuTjdFQmyc01yzowlm4ATYxW6KC+VcTgu8yCsZM4ifTvPkv0tXnUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791575564; c=relaxed/simple;
	bh=pvuqjbW042n6BGb+EY6UBTrDS7hNOBm+ab2Ccf3kYY4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eh7/prBKCF4OtcVVtePyLZ7Oicy0xoygGOYrzXS5Jg7OEfwwfCiYNysxnfa8NSf2vLh8sn+gL0mjkxHrpe+AF5GW78L2EQGbBTymuws76xIR6Ej2z7dSWjRuO5m9oPws251Kw6b8PplJtr6MeE9jkkLBGZEzYoUEmLyoInYhXJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fqm6dRSN; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fqm6dRSN"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-354ba08cfd1so90402eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 12:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791575553; x=1792180353; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AvyNvOMJOwvAlYfc8Md3s+xlnkUN81wtqrk05JhXo5g=;
        b=Fqm6dRSNZcVcdkFHK3FHX5sEg6KijXVUddaWlRP5F9EbXk7us1t6PuTbEi61Yvect0
         JPh1cTJ5QAfu5INFDZP5phorcg6n8odbBlaDSme+MyodCIajBwTDIMUly+oYS7jW8ZIM
         f6iqs56IwHAA8NuxXn6fqldEEKepV9WQMIw9UNIZlwEBGvyIJl6MlKh/bu06uRFgPeg7
         z15XlfS+Hg54OoqRtFKvO5CgYr9T2PlIAspND3OMxvZAZy6OpOpAqEoVrskiuP2Nvkv/
         xDzOlfF3Hl/imGhS+SxzpJLROoQGQNVcjpR4yavRQtnl27FDsRuKriMLp6eAQDnlU1wt
         LR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791575553; x=1792180353;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AvyNvOMJOwvAlYfc8Md3s+xlnkUN81wtqrk05JhXo5g=;
        b=fjbGmOoQJsSAS+2SN68a5li1/ZrjFQ2ZkxmP71DxiLFk1VfjJOPZQ5Pa1XXBBCeEXZ
         QyKO0q/XvWyiOKVbxMQ6+uQ/i8p7t1WacHkGK2ZRh5b1FNmTEv2J0TjeRkTdsPM+vJIQ
         1V1J5IL719Drc6xbPX4nHNDa3BzogEDrQKJ2nx0jeZrmuJFsnwTm3f26FYNbb4xxNFQt
         xSHya5h8e7Wj/0LoA80K81YOvqH6DzrKWL+edCWAiloljLdeKJ4UPg+w0VDYq656Zfha
         rMvpjFkzPPt+KcGg4dd6m2IVjLFfOBnDqhjyqnIMYJvhD/OEvF916+PJfvioiQez5avl
         HUnQ==
X-Gm-Message-State: AFuF++nce0rJ/Q0xYjF6+Z5syTH5u28o/zoenF+lbStqkwqtrjWS2Gr1
	i30N6/X2KMRdU0en7b5s3BxlsfSZUH253lcYFc/FC9/fVeG7EP2Ty4Fsa1Xr0A==
X-Gm-Gg: AYBFou3wEaofG3OV8qLkIFd/Z6Ofr5nIW7Edq7lsVV/EKPVEG7BOaXDS0Q1l+caFfsZ
	uTxbu8xijxC09S298AQoUCpIZIcc0RwY1Q1lrtu43L68YH+02LbijARZUWoG7JKlgM6AZ0qlpo7
	10nEK1rrw23sY3g9SjgPwk0R1I303vqniOx+ghDKuzMD+uwnmn4WRVi/J7kqc4LL32wpdddJwZG
	aMPa0N/4fn26wQ2Ik5c1xbDoWwIGp+TukaSI/RNuArjnz2U44xZ4qktwgGMrk5pDzGXiG7sW1CG
	1bh3fhAB0ryrjJpG9aMH/LNMUONJSzeCT0SP7xDevB2dFjNgyW5rYsIROgrta9VTVbSPAwGzulW
	j5qSNzJPHyGFOXlqhETA9k0EZUqb5srMZY4DUVPwYHaBBf4JXsCijBERmpT1GrXKx6KCHVficpx
	uJMzlUoJ1+a5ySQQMFGeyz3tEufQIxAd/3Fh+ox3+RMMi++2Ec6tPUl9MViFFn9f3zyXBKLpe8w
	O8XFWSI
X-Received: by 2002:a05:7300:6d06:b0:34c:8f9a:30ed with SMTP id 5a478bee46e88-3537e08e04bmr5986373eec.18.1791575553322;
        Fri, 09 Oct 2026 12:52:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.210.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1cc25sm9666571eec.8.2026.10.09.12.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 12:52:32 -0700 (PDT)
Message-ID: <6ac94600.1619dd05.33e34e.3364@mx.google.com>
Date: Fri, 09 Oct 2026 12:52:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0483711719886195530=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, as@discnull.de
Subject: RE: org.bluez.LEAdvertisement: Add broadcast name support
In-Reply-To: <20260924151720.1769259-2-as@discnull.de>
References: <20260924151720.1769259-2-as@discnull.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0483711719886195530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       org.bluez.LEAdvertisement: Add broadcast name support
   Pull Request: https://github.com/bluez/bluez/pull/2579
   Created:      2026-09-24 18:32:08+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============0483711719886195530==--
