Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A723822BB
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415366; cv=none; b=C0x/FcfjwFwPZF8EeiUk/kxXn+rHFdJFM0nchxLsmI4B6pkx1UNmc/Ft3kdBBXeWc4JDCOakzTDOfik3EjfEPxbyiXMV7Xa2vxinvHUM9F2cg+rc5B6C6w7M5nZ3+owBKAnZ88cDzYSLkkQCvw+YQopAJgYgMSF9xmYJhj7usWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415366; c=relaxed/simple;
	bh=saBzd2r+cKQW4DhIhHFd1e0MhaqJdVt0Q4T/mkbUxtA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UapQAJPhB56RZcv9Lq6MR3/hBNXJZgdMiPGQTzneotqHlnhwY2zl0XVSwPiMfs61n4gltIObOawk9BP4lW52SKtFHfTjtREknWdOIjHZBMc21fFNATXbGFlvfswemArWZmu0DZDpJnj13PewJqDZVH3fgN4BhtMxK89q3TqWu/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZnVYm00; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZnVYm00"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-930c0f9c1b1so136990685a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 05:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785415364; x=1786020164; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E+WGwG5RnDJzglvxAueFjG0HJS9P1yQOfNGzobyfqP8=;
        b=fZnVYm00e2WeHYxK0yFSerVkhkMDUikeS7nSPGweUMEfs5uxyZKMgfeIcD7KDb3cwc
         rQorg0DZ6lpGe2MQuQyvdfXT2Ly5729lRwwpemA3mGtmz5sYfq5EZwvbjBSrBOo645CR
         Ct8nk8IRY3C9fhp3GbNnONJzQiuuPVX1XvR+CV9gM1IkOyQCLUM3tvEQPurD7dDlHu3N
         UgH34PUcEGcdASy6W1ttNO2nw7ZiZSvp3D0zSaup6EOY1gU3A4PuDwySZf1/keeHfuwy
         nDfGMKZbFdW/E9uCE5uDsE4WVKDaCAoAh/wRY71wqWTuqqfaiQ+byvwySvDxZ7WqMmbz
         9vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785415364; x=1786020164;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E+WGwG5RnDJzglvxAueFjG0HJS9P1yQOfNGzobyfqP8=;
        b=E1n1qAESBIMR22+T5QVwd8oFCHSUDgsU/b6V2bI72CEge/rz/JzJOfrFKURw/ZLFsl
         JTEmX+0Yv9GjeFWAPIYu2nwj1w2kaxcnbva2Arqe1ej+BiviOHzesZ8Qe+YFdBZJJV38
         8Ttrc75MPVWfLnxZtk9QSxQeTPMLDDy9R6FjWnByQfXzAnChXWx8hRmi4ggUO4eE/I+m
         i6tEYUGADXIsdgSlF3KEWQ2sg6i9qWBKkx6IxbjL7g1zALtSQ0NwMC3ytyRaYD3Ehd8X
         D82CX4qFk11QLVR7UmxI/549HibQvTfDC/ECEuq2/W18VSKcp69QUkVp7cNkjd+y9e9H
         fZyg==
X-Gm-Message-State: AOJu0YzukO80uYhVRarrn4YsjI8w40SeWqVVCfkCIHRxsJcMglTFfEjx
	/fQTQQw58xVJUtUaSErFNupYuUlX9KyZbK2zqJlzHQwysHa7Mu6BbltJfARAkQ==
X-Gm-Gg: AR+sD10SG5o+vpSIW1dYTJblaAljbQy1UWfpq8xPeLWCEUyQGe23t5O2V3+6FakgGPy
	ZCwP7jEGSV5O5F2f8f8JnpOidkOKSB0/2ixGOKUzW1Tmdpg0b2lwleNnWv+/NFq//4iR51K2MKQ
	fS/NeA6CZJzGi+32GmHqvZ2EyHZUg/c/UI1dpYovWj/1tLbj6TQAW5mWi7RePPwRfMUNAu40zWH
	3jfpBAaFxl319OvyyKGElhnQmGtbDqr9gGbXWpt5/9fxDk8jtEj+Rf6D8uCIV8TvEDdG2ThVA+F
	USk1L5vugbS1zNFnhIXheMKFx1+tMc9JekiYECuxMJRlZrjMYfwmobNaWxu8Ki6+hS250nI9gFe
	qN3mrjmHJ2BbRTxRWT1Jbtbz7efB3xGr0TTjiNwNuexrN932clnv1rhrPDFIPJ26BOIKgRD7z/6
	utXY9L/m2jzG+f2O9gmtxMT3IOrmWmwGUYvjj8kShsjWLIce/j5mh+PrH+1IF1pEY2MS+Z
X-Received: by 2002:a05:620a:4455:b0:915:9273:9239 with SMTP id af79cd13be357-9348d89f7f7mr29023285a.13.1785415363691;
        Thu, 30 Jul 2026 05:42:43 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.119.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933e733f4ffsm417237785a.38.2026.07.30.05.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:42:43 -0700 (PDT)
Message-ID: <6a6b46c3.3d6d24e4.3347ce.b4a7@mx.google.com>
Date: Thu, 30 Jul 2026 05:42:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6939229887822471043=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: doc: Add Channel Sounding distance provider documentation
In-Reply-To: <20260730114340.1576049-2-naga.akella@oss.qualcomm.com>
References: <20260730114340.1576049-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6939229887822471043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1137365

---Test result---

Test Summary:
CheckPatch                    PASS      1.85 seconds
GitLint                       FAIL      2.35 seconds
BuildEll                      PASS      21.14 seconds
BluezMake                     PASS      555.86 seconds
MakeCheck                     PASS      19.26 seconds
MakeDistcheck                 PASS      159.94 seconds
CheckValgrind                 PASS      229.16 seconds
CheckSmatch                   PASS      309.20 seconds
bluezmakeextell               PASS      102.46 seconds
IncrementalBuild              FAIL      15.00 seconds
ScanBuild                     FAIL      2.50 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,3/3] doc: Add org.bluez.ChannelSoundingDistanceProviderManager documentation

1: T1 Title exceeds max length (86>80): "[BlueZ,v1,3/3] doc: Add org.bluez.ChannelSoundingDistanceProviderManager documentation"
##############################
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:

Makefile.am:542: error: blank line following trailing backslash
make: *** [Makefile:4184: Makefile.in] Error 1
[BlueZ,v1,1/3] doc: Add org.bluez.ChannelSoundingDistance1 documentation

Makefile.am:542: error: blank line following trailing backslash
make: *** [Makefile:4184: Makefile.in] Error 1
##############################
Test: ScanBuild - FAIL
Desc: Run Scan Build
Output:

Makefile.am:542: error: blank line following trailing backslash
make: *** [Makefile:4184: Makefile.in] Error 1
configure.ac:21: installing './compile'
configure.ac:5: installing './missing'
Makefile.am:542: error: blank line following trailing backslash
Makefile.am: installing './depcomp'


https://github.com/bluez/bluez/pull/2363

---
Regards,
Linux Bluetooth


--===============6939229887822471043==--
