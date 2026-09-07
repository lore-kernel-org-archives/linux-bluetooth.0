Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D5F318ECD
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 22:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818857; cv=none; b=LswJ1YHZERT2tApD/ySZi404/tRuHT8KTBk6pdw8jMY7GxUyBZ8LBNFbTPPWnOV91heoBiRZLC/H7Mf8pyBm6quee95k3zRnEUP9R+OEi0q05ZxuV47hFIT5Vz2qHiiZ/8DMB7U4ZBVex5EyHD66qlKzqDaj6/5Nd7JGzH+rjMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818857; c=relaxed/simple;
	bh=E8X9wOYhmr7mtcVpmFOYWS6j5sO0wUfTXinPKDUHS80=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lPC/CclCAlXRCwGrVM2WpdikQ6mi3QQ3z1HSAoprdC/ssfNxNR+GaK7/VK1fcdLF5ZhZUMQR3uSAr0l+5JFKdA6CssfQNCsnVIpN/F7+tcg5M3gfA5RlnPe17zCfR/eRXWYkQU7FZaIK8JoLFJyrOAS60z5scg8upEFPdow2uMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpXDDlKH; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpXDDlKH"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so2800666b6e.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788818855; x=1789423655; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E8X9wOYhmr7mtcVpmFOYWS6j5sO0wUfTXinPKDUHS80=;
        b=MpXDDlKHrjyBnNcm0J5X+PKiLItHgqdALmML6hmFO5JyTmgcAX9KcMdnwQlKfq2Npd
         owDNWRrP79aQ274tKLdBN2L9poXoZCjb5VF9b3z8pxpOtv3QJIDR7IUmz4K3HKBeIWdu
         J1trgGiVWPxohv/JnkxIoSbiGwD76qgPNWK3n4C6NLjts5CK743zVycLqe9IojXACw6Y
         dULDqZqHpG4ZJMpvOF04+CHCdxNpQYDPZiURq7U4jpBPo8/Vh7BsHIv4R8QSgHKd0QO5
         IAbMRwkiIm5yO1+D1P45stuhBMv83p1EiDmh8PVqk+UjHfY909yC9J5v2J243SdfKKgX
         dT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788818855; x=1789423655;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E8X9wOYhmr7mtcVpmFOYWS6j5sO0wUfTXinPKDUHS80=;
        b=YoJItKxINTU9q8KSjUlWJSrjZCTSAcHjX4sH2+7Lmu4TFZrXKm3eZqswOIWUv71BX+
         +3iQdrQ7HrTGitJU1Ph1byUgCm+AQLISMF2jHv5sCJXh5mi+0xv9H/ZbYMJ21xmVXd4G
         EL8HJRhyHyUcaY4QXu8NKrqEzr7R7T7CJD+IhkM1hQbkGK94ObprBweSRfc5OpIgx1pQ
         8PSUiwfdXx/ou/mPKNqUyX14ECcxz+0vvpeo3pVBdhP9JfZ+u6rDvZdI1i3wpC41HzKR
         ltGCspl9/5J6eP7GLMam1m5CRbFaSqEGFyyjnGXKQ9/pakLldBhSq+GDmeAPe1OSsXN+
         vX4A==
X-Gm-Message-State: AFuF++nEKABaq60OmsuzuSlNbiNcNlBy80zByY7TgO94kfnNCmpSiDc8
	xqzdQyPF6MBWAX72/wQgAD3azCv2LbssVBbvDANbZE2XxryAgkbu1qj+wzIkRw==
X-Gm-Gg: AYBFou3XOJYHSdzBVBgKKlUZ7WbU5k4amLa9vMsZlTGEATiiJ9MWJwfSpBErnwLMIp2
	KENV+Z2cZoaogUxEXqYM1eaxnyNkxkq4H5JO4nJvqbGuBeh/yQPSM11iqmiD7+AIzoxIivhM4IC
	lUc8SBs2qaf5Qs4k9JSZRlnMaYRdyoaX7/u8ynQ6KeU7JQHLTIdMFyjoRlWtBNcnBDaxoVvB4Db
	1N1NDJnP91YMZZGBkfPg3d7EpmykMDPOTCzHtwps0ZAKYjnrixY4QCtlHfWEdHCKcOG5jNn6ZwS
	fuyYD1QT9194Lzg51NpOxynEmQ9js0vHy6axVBwPNkNQjfOsA8sYZb3B/JIE+LZDjl/4o/A8nha
	KfXBw2Hhikwsxj2yqidQ4G6Olgtkv23CSzOElG3UwqubvEvIJdv2WxDYy3kSV3VdLNJvAskdqKc
	lHwkJSzt0ORJoPcio9n6wzYyFAbHQ5u6Qpe1eqLgv86R6A90siF77vAlZ/zUhKnQaJyGn4
X-Received: by 2002:a05:6808:13d2:b0:4b9:a8ac:47e with SMTP id 5614622812f47-4b9a8bb6b98mr14291786b6e.28.1788818855370;
        Mon, 07 Sep 2026 15:07:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.165.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b97124b081sm12055944b6e.9.2026.09.07.15.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 15:07:34 -0700 (PDT)
Message-ID: <6a9f35a6.08f94d98.4ad0a.3184@mx.google.com>
Date: Mon, 07 Sep 2026 15:07:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4827162749523032811=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jan.brummer@tabos.org
Subject: RE: [v3,BlueZ] Add cover art support
In-Reply-To: <20260907193404.124504-2-jan.brummer@tabos.org>
References: <20260907193404.124504-2-jan.brummer@tabos.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4827162749523032811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4827162749523032811==--
