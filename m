Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370933;
	b=5jfa+hzAYP3h98XZz6bYgP4mMzIjr4XTDPjaj7HultQ9CfRvz0wkJiBOhY/nZ1LEk+bd
	 2NqkT9jnv2UeM8UsawsyJJu+qDRuKJ17A67CVu6LBeA5XUQ+wpgRuf7+EUhOsLN64cGWH
	 iUiLuoa4i6HmWeEaTeIywrTpceK0DmCL/tKoV5G6f8/C0DRSAjxgIaM5IX5HbrSfMw7bV
	 ue+7ErsmnwsMHnN2nEhcs0DY0epSBBEGvEOtBxKgmpVOMzFq85DaAHvo6s3RAaVvgNK8m
	 B9stfKTlz9aMQ5lPgL1X+sIyp38/ubJssO9NtneIhJ8MF/oUTN6g5KOYj5FC45/83pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=7uhfQQ+897FGT+99MAqi3kUHT0R0r7QPGGrduKTgkRo=;
	b=2PUJGu2b7MVYdvQvaaqZ1XpvAPDlj5bRXTk7bxOzpLRduAQlPl4q8hV70Qd3SMksOUKZ
	 m0rS6RUmvLpkDJVxw9iseAOheRdYbHWc06T42mqsYkSdiScie9zG2Kb8LITC559sbkRmf
	 mlx3Hz/CjLQW45v9F+XwEHQY16tl3n0CXx3Ae7tzdV2GhSUPW7yGXh7mmOTzmGInSo8wH
	 qIGmGXrZ1QYh3yOeJSMkhKMG7b8HnmX1iPaMLQFNQAYLCLsthG12Q6La/sUDwPJkgdIm+
	 lPcBDpz3kePgrFgKuLxbKDUGtw0zCiHBhEQUIzjP9dzjaQNTdiB0ad3hvBQbBkkJ5PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bAUdoy2G;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7E6606A31D
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D7E6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bAUdoy2G
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91c7a0c1617so12353356d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793370931; x=1793975731; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7uhfQQ+897FGT+99MAqi3kUHT0R0r7QPGGrduKTgkRo=;
        b=bAUdoy2GiYd6ORWm3cUHlvk2+t48++Acv3eW6ngO94WKPqqWggdBZOsLqAOiPMPqwC
         k9iRRinzV0mGQbpSxNPvjGUrANbqS8TugwHXsDWbgeGox0ktJmL/OFAUtvSB64iD+XZP
         HVtY0bby0w9RqikchLxKVzmDegzLe9XDzRD/xKlxCO3RJBGOkrco92cpjTimoqtMnWnT
         5T0o3hQcHJpw3PRNATi/EE6fnqRrTB+aKBdb5j3B4ODNWEM2zrSoXe6XZQdqwLNWL47F
         cG8BcF68kWY2YaQAqIECFlmwY20bNbpRsSHNzYUZAOVUuIuVrDt4lshkpi2KqMSW0nZt
         zHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370931; x=1793975731;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7uhfQQ+897FGT+99MAqi3kUHT0R0r7QPGGrduKTgkRo=;
        b=Qq0PGSez2VrQDejkV5UADYPZS+bNHIcCDqkg1WsGJkKgMz1YK5yhmEMe7DxsOx+Axc
         TDFLI+fDaWIlKlq+2U74FG3iyKOG3dE08eYUf/j6B8HabFC3J3T6UOjeIEBYFrJPe1tT
         tOOSHD4tZQlOUpzclvUHcqRDCg1kQFU+emF8LDx19d/2Sicm50PSY8VIkxudG9zfrSfN
         uUgPSOSBiFEuvgPvI3/6lZQOOa9RpzEbM98PKJNaKiP8PizF1Vv6fcGDBbM3jRmurURJ
         p9R0pd31xb7AKG2SY9UwTJNqHZhY8qgt0EwlUqUSCIMPXZg7B2ZiwQsS95LgnraN46jA
         JLGQ==
X-Gm-Message-State: AFq9FYIRCe75G47xDFzRJngs5R8WUYUcsiFjm62YZ8mdaK7+BOXvOagB
	OuMGOKOy3uFHq4p0A888k0b7yQNAlsKI2JxxCqomz6gSMfhEqDmyKSsGKVikmA==
X-Gm-Gg: AYBFou3X3dt+Om95QNWgOsCDIS4YqQaEZvsE3lJuxERD6qu6Faskar9qSi1mMbPovlp
	G5ozPA6YLCwNFpxq8SAYu8Wt0SpsKe61XFuPW373tUTCoanQWyCrrlblIWto/SFxqGsYvxJrc1o
	gcPhDGLWc0WQwPeQDNuny9uLuaDWS2d7Hv9P8ZZuwOW7zm8gbrZCLTOdB/OdWILWz1CRMiOoGoM
	RXTHSOIBStJPCKTLEOJ4CFdW6RCSwB48cb2lFJi8awkhPIQiSoMlDJ6KhP5Q3PmbkybVo1NJEJq
	MhKfu9J4L9QRoWJNMzbp5ElBZTNuNF+WNB1uwb+YAYicqAUwFTbZgpvPgEDHRgEB5lVFGjqdOKO
	Q0ipljih0oaE5bMGLhhDabaoHOjNKIgyiuIzf4VtWw/x6Yfjlta80dBOX7JS9ZIqL2Mkf/3o61X
	bXuYrxk+U9+v8+CQvWbftEJ9Q4fnk7R8ZlAmu5SmM2i0Se1lJMo4sN9dj6jftNewj6wAhwTG3s9
	5I2IvV2V8NOxtW8Y3wByazVJG5JWpi4aeJxU4/w/kK98N3LQGd2eL4lCRkeJptBaUs=
X-Received: by 2002:a05:6214:1252:b0:917:7d92:6486 with SMTP id 6a1803df08f44-91ca4a0c511mr39361836d6.6.1793370931263;
        Fri, 30 Oct 2026 07:35:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.206.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7e2342asm16690116d6.5.2026.10.30.07.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:35:30 -0700 (PDT)
Message-ID: <6ae4ab32.73a9dbe5.1bfe29.4791@mx.google.com>
Date: Fri, 30 Oct 2026 07:35:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4717189323069412505=="
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
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [BlueZ,bluez,v2] hci: add ext adv interface
In-Reply-To: <20261015-extend_adv_api-v2-1-8b76d8a1c0ef@amlogic.com>
References: <20261015-extend_adv_api-v2-1-8b76d8a1c0ef@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4717189323069412505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,bluez,v2] hci: add ext adv interface
   Pull Request: https://github.com/bluez/bluez/pull/2684
   Created:      2026-10-15 12:08:07+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============4717189323069412505==--
