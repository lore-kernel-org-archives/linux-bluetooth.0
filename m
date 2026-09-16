Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E751F503BF4
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568511; cv=none; b=OGxvn+nBZtKXn6kcddD5GRMaLrssTjXO39LhW+ziC6v10L3mtix4OZaBd0P4S2huDK/xc+1ikDZDA/96PIl0JGhaHMXI4AJCzJyVVVZKaRxIDqjyy6AdMPn59m0l+kXP8HdDMLM1ZtJlsTqDnQrWaCdZGzr06McOTuK4h4sag8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568511; c=relaxed/simple;
	bh=8mnCsZl+oibrzXIZLai9CrdFb32ytB89cxl6fzBueOo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lgZg8s9oGwl8aGkAQ/FH5WTptD3Fs6zMSC9lCL1NSpnr4FC1PEzkyiJTl0+sa7d1M6LmvtnTyafbKeuH9cU7Op89o5ZXngKhrpU0GYgZMc4kQfnpnP4joEHVRiwA/HWge43CmfpI1HoYEOabGolmA2Bw+n0jNkW7fWQ8F9mqoZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AK0E8b9/; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK0E8b9/"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8692a856865so835343b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 07:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789568509; x=1790173309; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dT+/T0BUfQDZxNKjWkr1SYl6XlDIz9NKWzrsvYbuZk4=;
        b=AK0E8b9/bsbHcgVv4dVidCblI/kUBER889Ew5aDUji59d8Itm5ZlUFblshxa8nXpfm
         t09OStsx0zZF3HFEeNk6rNLASmGzfu2AKY7Q7oOBRExOEGsg1hYoMz9rbmv6WsdT2nLh
         Y8jzNMfpoRdOcIP5n3bKVCDuzbIXTPxgTtA+6k18yXgNsU0qV8v+E5ul0W8m2Z/phKBk
         S30pZQ4/ZSYKiaFVzNGHayo5fgl4RwFuO9gblGBAiiG/q6ThgASnmDETscqyZYThLC+f
         T8kC2WDrs4DIaeugpV4NsZIoSjV1w1FN2p0UHxMB3P36raZwybuEd8QtuoTgjDMDLGEi
         2zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789568509; x=1790173309;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dT+/T0BUfQDZxNKjWkr1SYl6XlDIz9NKWzrsvYbuZk4=;
        b=Y1hKZ1ZANi84p3QbBSdbUHVGM8z6zTGcVpIhQbuSThMiaBBeOglKLHlcz0/T6zYLyQ
         Nic2RQEl41NolPnANJIg0ajQ/nEL33mtThDBVHBvQvNJwG0h+XgCw7FehLUbIr0oJPoM
         xzhkckpdCDcWeHP4Xo1gl3clV71Oro8fLOHg9i2xrAM4MsZNl0OE/722BCHc4kLAcmUd
         CLMYRoyU2T6g8xblgJ9M0FipE7gmM3bKycyPCZJaZJySg/Yp4HQ7Ls8QusM1CR644AN6
         WLfw4UbBbZGJtCmPWLtcOG56xS+fCC5E9sCe5fLr+2GcHRn8RXmUoVrA7N3/TNkvLEcB
         zS+w==
X-Gm-Message-State: AFuF++kXW2J2I0tv0Vey/GyxqPKKsk8/XE7jW/LF+uYNxYq0M39+iEks
	KQwZowYlNrgtHEdMnyTWup3vAcDHoozeRlsy248UHUCOYX3ZWxRM/w9R4JTPtSh/
X-Gm-Gg: AYBFou1cgo84MeLmyFTMDfGiU7Huil3ZoeuouXluNmlq2YGScugb3Ge7ZxLbzVT+XXm
	g8tayb93nZ126dz1HdTpX03oI4DuM/n4T5C95TOMDU0CrNbdPPttwk9KFBWJbMQ2Gudu3h173Bp
	yz0hGUp72SC9WsQtSq8aRG8Xr3k0Wa6ngywqpdPsHq9+wT6+3UM+8ZpziN/C1tnbz8gBK/ukfob
	LkI7UPDciQkTWlRs5oGebFu4oprlUidWUNEdKp7h/JiKCGOCNozVQXjEqUexJl5AnpQUCCVD55W
	DUG+PQ3TOwbdd/OaoHn5hkCzgrn5XgGjvtUGqxR1G9x/R3qydlLQj7CgC6uivhvE5Ej2cStCuSj
	+G5mNECGSPOoTgxVUT5tdzoxuxLNMm34nhz6EURDkw9tNZbluxUViJpZjEObRQhaJGJH3qkgQRK
	PjskkAxhha7SLg+vXPkmIC5e2QQRzgKiI+22uy3y3v0RM30aPUPFU0f8sMsnEIH8ZQ9X2AQSLsJ
	BfO/g==
X-Received: by 2002:a05:6a00:ab0f:b0:86c:79f5:281 with SMTP id d2e1a72fcca58-87238d832f5mr6983232b3a.13.1789568509198;
        Wed, 16 Sep 2026 07:21:49 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.127.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-872024e6a2bsm1331740b3a.55.2026.09.16.07.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 07:21:48 -0700 (PDT)
Message-ID: <6aaaa5fc.1b3fddab.1172be.89c7@mx.google.com>
Date: Wed, 16 Sep 2026 07:21:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8309102018219903240=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] client/btpclient: Improve GATT read
In-Reply-To: <20260901125440.355578-1-frederic.danis@collabora.com>
References: <20260901125440.355578-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8309102018219903240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ] client/btpclient: Improve GATT read
   Pull Request: https://github.com/bluez/bluez/pull/2465
   Created:      2026-09-01 14:17:22+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============8309102018219903240==--
