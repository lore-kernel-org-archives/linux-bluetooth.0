Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1B376BEF
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134304; cv=none; b=fI/jia53WZB4HI0W7SZl2v+PqjSVBehUcBYtGUBjmORW5j+v6j9BMVaeKZClKQXYwhxXLujfuIHHW5niQtSZCvmxBDwu0bXWk2q6xxUiIjKrmQuLkk7vy0XxWcotqMc87PlLH8vamNMMQzkoKrowjoaU4f8KjktFoU7o05zdhJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134304; c=relaxed/simple;
	bh=8pT8fOdFwJEpDWnVCdqilzVsHUJpdj6kRdy9mbag+oU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a89QiXyyvItvkW8bp1gd06mzIHziEpppR+smR367il/WG/3RjkqrYjuoeVnx3KbZMxHAcOI1Dz2gNX7gP7MCi3y8bZrYhHBmndTQh20NhkZYX3QY9mclNeBMcZHmkUkaxGRHPgiGX5ZOy/ZsmC1EWJf6AS0Hh6JYQZRMBHFuptk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGQIcVBn; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGQIcVBn"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6acb63301acso659217eaf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 03:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787134301; x=1787739101; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dQYygIlDzFAi3d8APxy0366WJaVKEu/jKfYyf3mYaPU=;
        b=LGQIcVBn5VaQcrjNs5AKJl8djmPLWaVfvTJy4hVpE9BMHyQNTttyb6xBbPFaOdc2ri
         dSX7wuyeIvarkCa2o1o9ZLdRK6R+bQLRQWmrXOGnogRB3QC2tCKS5U9ycltAagG1Tn7c
         LKU6bJpULNZEPhq13L+HOXK8rsz5BHtyD2oDV58Zvg9VjutVTNQiL18IicpdobTXbnb+
         GruS9V5kN1mRGxXNNgT/nBnVyV0q+wz1qsQyQHJo4A9gFOdq9KLMLiOzvhiKs9n0dc0G
         H1iOkW+zw+vR7T38Uygpl1P3hwDf4ttUktA0FjOvvwF7Sdwk+tIK0r4xUJICt1SfNCT6
         hmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787134301; x=1787739101;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dQYygIlDzFAi3d8APxy0366WJaVKEu/jKfYyf3mYaPU=;
        b=eMloy6BK0T+hyHn94jvbGzCQAFK6QSrjyjK3YY7wu90j39chk1jkfw/qqTRLadhBrq
         VWpLxLOSa3myTr4CT2mCxmCgKde1SBLIwwFcQlWWi3dgSP0roORAJG0tNARpLYb5tvFQ
         LYw3t0N42GVdNGIU+FWALYZZmav52hfnQGskimrDLrHAa9e14Kf9Iom7u2HQS67z2JU6
         sIcrtymn+fJ7Sy7slDo87o0eJYXyBB7BCdNAcO8uXLXsH9Sh9RmyBoHwWGrLzLFyt9s/
         WXYvHKg2D3IbiOpCZVgia1oci01+/HjpO1uQX8OiucriTnGNxCvsGZ/rrhB8I3EuUo9r
         6OSQ==
X-Gm-Message-State: AOJu0YwWWthnGH1GbWVTk/Gav2fIoEvMtGaKfGWAVPvYRApzDgjKSgsh
	xZWOf4thGUOfpFiY5wIa82IWJ0YXzl/5wlwDgj/oNzDJaiYkaGnjr8Hozv7m+g==
X-Gm-Gg: AR+sD11EGcilWWAI7cHyAld5rgQxQjVWtaoBB3Nqh3L3cPGNCmsugTG7KSsU7KBzAHJ
	gxwt8YX2LROvLVMS/60IpCzy1kI0YZIIk+AV3hq9FglOuUJYGwOtvSYHQMcmqyafYUlfsrYpxXB
	77XaDBzRUO1GL2EODfnFgAvYDEZVNiP/qlk906yy2rjE8FoLZp7rM2dhS9hxjHo9F+HEC00pd5b
	nRZPcicqbbXZw5bP0d8JaogOEFgWjf0ENXIAaXhFeJ8jo9TN3kOIDGcpwxKIVmjgXicpne9MmkO
	o7DeC1JPIs2iN9yCOaL227Y1ens8aBBqDtcCOoAqumjEwOh4t0EKVY/tcmcUNxwwHddLQKME7JL
	WS8KszcOvzHAcXiYtM+4iGimkPNmmygag2gFsfp/znpsAYwMPknoYAeaAWY6gbYaviXePBtopTc
	/ejAo5IczV45aOXTXsHqGWoi7DeewRgI6uYZCY8niFGOzt7AgELFc14YW5tzAAG+usGoY=
X-Received: by 2002:a05:6820:4cc3:b0:6ac:a658:b952 with SMTP id 006d021491bc7-6b13c31f756mr2605870eaf.2.1787134301414;
        Wed, 19 Aug 2026 03:11:41 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.101.53])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b13cb557c1sm1624520eaf.2.2026.08.19.03.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:11:40 -0700 (PDT)
Message-ID: <6a85815c.ad4f9334.3ce649.e8ab@mx.google.com>
Date: Wed, 19 Aug 2026 03:11:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6932175261715963376=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] test-runner: "-a" option also stands for "--all"
In-Reply-To: <20260819091347.1204005-1-hadess@hadess.net>
References: <20260819091347.1204005-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6932175261715963376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1148341

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      14.69 seconds
BluezMake                     PASS      497.58 seconds
CheckSmatch                   PASS      177.56 seconds
bluezmakeextell               PASS      62.88 seconds
IncrementalBuild              PASS      556.14 seconds
ScanBuild                     PASS      546.38 seconds



https://github.com/bluez/bluez/pull/2413

---
Regards,
Linux Bluetooth


--===============6932175261715963376==--
