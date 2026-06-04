Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6783F0ABC
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563759; cv=none; b=Gpvi2vXoEuPU2Vz40kDd2TPZfhyExv7RMyX5O40/U8s42dvi26kCyDW3qqJq+LlO4hBmZ9Mji8xmCK34y5OoCvnjiCom2vmOB19ug7IWBmjHFA7479VZMKt4txxN2U1qotkgI87y4/NqTpsRfDDhKQ0Afg9uKfYJFEfEChfy8IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563759; c=relaxed/simple;
	bh=SwAbnkCm5kImMxXaXiOLus3ErG1HhxHC+xxITtbnvoc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ilas16NyYmeYvl8nZpsQb1G88KsbRJ0y7QRw1nMi+/yBRPP3wcvIUteAhKzeXQgq1uEq4iDzo83Vosg+Dp6XBWEVCcQioljX9NBk0RH+WoBQCx6KptEdHjfu0jpkcw1bBhrLcAgqXlYqI3NC1dprCDXwh/xWOtCkdF0G8/MHW6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJlfLofT; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJlfLofT"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-915671abde5so52481185a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 02:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780563757; x=1781168557; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d9lLiMnwxMe4SQMdq9fmzHjQwvLYtogAKX4W9Depkb8=;
        b=TJlfLofTCIWu0L1xhHfMdf18gRIlo/hgtRytzDUTJrccDoOIpj9AhMKOfPs5j91Eob
         xDDKDg1Y8MmvpRvNqHcN3kgfljSeEDY2LO51niOo4NgoMzBzMqwmEakwVzrgFAR3rX8U
         sIO2vEmtOpJt86JmECVLcXz+yp8W7z/OQ448cGgxhxoap3ZUM5ynwIH+xGBcInbzuXUO
         rxFSyPQ7kJexv2XheCsBvjw1Foc3fAlM39yV+lVosg1YKkB1S15ioL+K43Dv+a9UDYf1
         TLH8H5Ef7n37Ncwrlua9SU7mF61B+GJedE5NGF2qn95+k0LtJ2mARlUke+mrFIIMiYue
         JooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780563757; x=1781168557;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9lLiMnwxMe4SQMdq9fmzHjQwvLYtogAKX4W9Depkb8=;
        b=nHtBPWulplV48tN06mrp0WwQC821r4ItyGuGlsIF/6ClqCg0quGG6C+jNHrBoIXOFJ
         +h1qknv4Od30Iep09xlZyfijAe4sbejRlGYdmRGqygSqbizJxCmxtFlNqQfGsuoi0xZ+
         iUvQYeS5L/+h8Ao+D8ILTXi/6bGmS0k/ZTGfopTMtoSoJ5Reg8imIR9ZsGAzLAEe8nMB
         DGoR/jo8m0YuCOk+QyzENNvfWJ7xFcYco9Dj0fDpxnmwPJ/9VHnc6N2ApToNvBiDZJ9T
         NiEspFahUE9oPkVPM6fpnHa1nH/L2FCF2ER0wFXMPaO2Y/KF9/npg7styTYDJKYe6JNP
         /0Zw==
X-Gm-Message-State: AOJu0YwBaQH3uNzxJL4DEhMWG8b08q3D5nlBRBTxzChnLGyroISNYuYO
	2voTsFa5sr49cPxlJ2iBzRe2veUrfXiS/MQpi8mOqZth0jyw3RBjVh9HUNSy5g==
X-Gm-Gg: Acq92OEmF084QpQYTXEffQWuaFUSYtjj1aQk9Y6E4uFqbevXoUk2fCtR76YWH1Acrcz
	QAWQKB4geGXyF65bvPIeZy1HxzwZW+8wXEuXMtUtWpZYLSTe6euALd3wjRGZxxnhKCvSrzLiaLy
	CXeC9ugvtbuEKwcsYvduIuZnwf9A2kXds2ybHiXjYdsd7eQ5f39aNclTZ5Yj5yjU1whoaoRa3MC
	6A6tAQzPb4mtsdA4BIzuHVxuMOh6uC8CDhNc05X1e/7bCyUWRwxD/Ab9TJTbmK5T3j10mg7CW+m
	E/DN21w/p3/9fnw9l4g0mwdpusiweNruJHuaK3Muv/i2TMzyxsh+iasUFNdk9GLNMxhenbscnVQ
	CvygW7Qw8uS75fDMl3fVn6Bg13R8topCn2FqNwV2W3rudP9oDWJqNN9Sgf/I/lq49aEu9+XcAc+
	EFa3uqgrvdyDIrx5N9ZOjVlAZ5il+6wYijbT6ZLMm/
X-Received: by 2002:a05:620a:3184:b0:915:8502:f7fc with SMTP id af79cd13be357-9158a6af979mr1171475985a.16.1780563756791;
        Thu, 04 Jun 2026 02:02:36 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.88.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a2465e7sm538851685a.19.2026.06.04.02.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 02:02:36 -0700 (PDT)
Message-ID: <6a213f2c.0c039065.e7a4.8ca3@mx.google.com>
Date: Thu, 04 Jun 2026 02:02:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1352283431436424515=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raghavendra.rao@collabora.com
Subject: RE: shared/bap: add ASE Control Point error responses
In-Reply-To: <20260604052052.10667-2-raghavendra.rao@collabora.com>
References: <20260604052052.10667-2-raghavendra.rao@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1352283431436424515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1105699

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      20.05 seconds
BluezMake                     PASS      612.41 seconds
MakeCheck                     PASS      19.18 seconds
MakeDistcheck                 PASS      234.26 seconds
CheckValgrind                 PASS      274.34 seconds
CheckSmatch                   WARNING   322.83 seconds
bluezmakeextell               PASS      165.13 seconds
IncrementalBuild              PASS      609.37 seconds
ScanBuild                     PASS      919.20 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2174

---
Regards,
Linux Bluetooth


--===============1352283431436424515==--
