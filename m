Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C339F35CB6E
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776078115; cv=none; b=oVYKMdOktgN8C5e542PD7QGa6xirNQOGnMsFXrr1TXBwV5Lk48O8eop5UAxE2yr9IXvRJN2uxGfbLBkwxJ86w1dfBEHzrN+/AreQ74LchTwlViYLF6QXPBKx4IYGq2Xdmqi4b8jNFGCXz+hba15sBIoFRNLRXrXdA2JHWFQbLyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776078115; c=relaxed/simple;
	bh=LDTjnqcYCFadDVKqceC9G94IaJd3pvDpey37RJCJUZ0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jgLc9iK1lOZIexnXsp+ZMFP1C09EcwIBt1B3VBkSRUQ0kIUGieg4JrNjEVcScN7KnNBubvlQYFza5/HZUxn1kEJAlDAXhUnxT6lkmYAKWbPj+lzsP0Ruz8NtcGJDsQNjjmDNGK4kAW/vwaOaDFDNyxPH94cKhMeDEt2KB6+271w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SchrMePM; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SchrMePM"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-66f747175d8so1920321eaf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 04:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776078113; x=1776682913; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LDTjnqcYCFadDVKqceC9G94IaJd3pvDpey37RJCJUZ0=;
        b=SchrMePMVfelDyaozPdW+HUb71LIzsVc6y26Kg0V+LEPtBAE2b70LePaCViw8eRAqu
         lxs7mlDENYoV0ezwIv5JRrqLXuB36Thly/nEfAlwto/fR/l914bM3dGtWQezd3ku8pxH
         YzLZ2tcsqLZHNPPCmbcJdxsmDgNS3FEbyNSiqly/NCHlLv6u2mdD9ABnTqyljJw7fuLC
         YxsIaSK0YgtMeAUK9MuleK1cqdlXUroH7GwoAazfSkSMoMHFL2XvTDoTADOoMZESjK2i
         ifltMuuoHqXYK3pz40HI+fToGLPmPGEE5Z/Sraox6jnE9GNODmB3EzfG7zOGt2YIzayv
         E03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776078113; x=1776682913;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDTjnqcYCFadDVKqceC9G94IaJd3pvDpey37RJCJUZ0=;
        b=evxJqhUULjkMvcXi3ycmTcjCKqGfdvukNzIeIC6Sq9AsGZygUeEeEp8gV/TfsVHn1W
         K2IbW1mdVa5WMSYsx/VW+mjaZDslPp4npR+KzQXYdX46Pi1kSQFHS7Qf7TkL3PHDbeu9
         gHFG2KtpznngY+3IHeDo/yDrDIp1/M1r7BjZknZ6HRfoVZTrt+4bWA3qjZKYtqIRQTiY
         EOQlKpZDyHOraKTlscdnv5abknRrsmCpVkmKmw5Dg7Ix8dd7BCqmvfzrBDs1fYcs2dyY
         c1cEtXC1UV9r6k9byuVrb42OfOVTTP1jVuwSMvW4Iu2UJWq8cDEufKiENFeYzrD0XB3T
         BxuA==
X-Gm-Message-State: AOJu0Yy5zn0i9EhfXSg9sEGRGS0mcXBkLXdMaumBjNABWwUeKU1Bt9U4
	9P5M1ezh4pfJPUIf3r7rYOBJKqcEF+gYGhpHWbrrxRPmPDHuaV9GEqvUGgCZDdZB
X-Gm-Gg: AeBDietjmY/esHhVNlSLTIsTg6R/Kj11QOx0WjFD00hH7XO44p3q6Ca4DnwbtYP+qq6
	HCa2RKwoxmtGtULwHx2mUW0tkqK2tTD462d/vHi65p5YawalKH6a+oaXDndZONqlb5Xlmi2usjU
	mtyRjAulj5ahgI7xaWFfhKGAMjDzs65aBCbkylS+NG6XPCi8EVMFICO+Cbz6FVNKbnyxSTN6Qqi
	Bg1N3ER1C3k0gubON5TfcHYmXJRnJ3x7qNHMUyahhs4XYA3EKbfFTSxyrMAZiLGraK3pDiVIqIB
	1xANUk6E+OR7ppEnu/kBTOsHK4UgjniTMfR4WZqH2tP2GdsKB7FDn++ZrI2vuRXB8+y4ksnFQCM
	WHXYTOAm0AeWgvZBR57w3VGXT/IrnQz/IQwRBslLid5Tl4mUwLDoQ4W6GjugcyRKgsI2SYSsVOs
	BUQ3qvpzk8q2jkhMglQCRxCJh4Qajhv75lsmxlRfv4qg==
X-Received: by 2002:a4a:ef09:0:b0:683:63f2:a42a with SMTP id 006d021491bc7-68be7ee3977mr4407902eaf.33.1776078113177;
        Mon, 13 Apr 2026 04:01:53 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.30.118])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd539b3f3sm84321131cf.2.2026.04.13.04.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:01:52 -0700 (PDT)
Message-ID: <69dccd20.c80a0220.15cf24.b623@mx.google.com>
Date: Mon, 13 Apr 2026 04:01:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5167442288115579956=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: Bluetooth: Add initial Channel Sounding
In-Reply-To: <20260413104116.1605357-2-naga.akella@oss.qualcomm.com>
References: <20260413104116.1605357-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5167442288115579956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: src/shared/hci.c: does not exist in index
error: src/shared/hci.h: does not exist in index
error: src/shared/rap.c: does not exist in index
error: src/shared/rap.h: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5167442288115579956==--
