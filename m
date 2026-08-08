Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010FE54763
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 04:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786163663; cv=none; b=aK1H7uODYqwGsz7ODltelaVrPbxhSleYvaYrh+WhdAzjl0a3UbHvTecR/s5vFymvyGv4YUoA463eyI9upGI0h+9fandrikpbbdqNQzVFpR2p79xwvc+lGE0I2s3pXYrlmHGVMvvqWrZhlkQm43ItPDSqTDvb2CXv21586Il15kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786163663; c=relaxed/simple;
	bh=/fpKtyH4sueWQ2eeomqm2G+VwDRNqvcMiDdi+/OdTG8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Pq9eanx3/7xJYLs10H9LhoxNN9HnWywaevMl6oSRAYlW8V9lBTZi1if2MAjB6+QlcoPacu3qrKXjpmH99SmFzuiudjCqhoku1tfe9dyyYQnafJBd8xhpgk7GctM9Vpjc+iLlYb9UB7U3zgHYX99l7mJ0viJRrfIEVF4vwL5/SCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bS2aaq+Y; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bS2aaq+Y"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso105758a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 21:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786163661; x=1786768461; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=td39VXGEsrjf0a+N8wCt1KnGBmjOdttG7rv7jtzoeRo=;
        b=bS2aaq+YeyzaDKmDJSnX6sFqQsZPCKSLPHdxeGXz/6LYbdjrjL4Ae81sj7Xe+9XTT3
         J8S7HUQptkhFPVoMdMzvl7aXlyNor0LgijuiXkb5SWeqNyGa5gEVKRWtdL9+wP2IgUxL
         /hdW/gAFlbxNEcIa+hC8OoJUNYE456Mb6JHUgj914sdewM46zb4j2LWK5S05yGFf4ocl
         722b/QkJt/0EhF0DYXbGsK7D2QrnG9d8olFtz+Zk3Jk0iWPVsEv/XSX3BocCcsagc34v
         0asNppY8QmA6MgnYENUjLStJ0wV4TbGpJM6x3xLicGGjcOB1AiITy5tsI7qUeO+BcAev
         Q5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786163661; x=1786768461;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=td39VXGEsrjf0a+N8wCt1KnGBmjOdttG7rv7jtzoeRo=;
        b=P2A7WF3237V3rg/a6z1raSLq618ctvhglIGjJfUzFNcAegWUHog53w4F/I5iUoInPN
         tDL1BB3d7Fn5htpDbObpn8WmujhJIJ3kL/cSqufXELtzTwgLPPS2MHtMdP3J4kZ6ZTH5
         wNOj6LUycCY/z3hxZ4n/reY7SHPS2joUfxElLR45KaN852CEmXXQAUO9uCLJLitcPH1R
         kOX5nXLfkJ/d+SfIOfD2I5YsCDU0IUzSCS/lS8UjVWP7HwIiAiiXEEeSb7C4TuGGTCoi
         /dJu/9V71HNwDVU6YbSmPJb3t2InJCHH7qXfwgA0LOxI/uBulk1sSL9dzGhNFHDLOUFD
         aRew==
X-Gm-Message-State: AOJu0YzLeLAm0dT767jqK/i5HNlAHiFQuhvCOTSCOhQfWUqkMSsNMqoD
	o0Qj6yvbVes3Sf24iWbCx7B1ShKD7x4kg1CET3+G7eASDzc7qwQwMSI88ElAOwi9
X-Gm-Gg: AR+sD12F5XAz0aHqhNnb3xkN4Y1/UMaFqPLxpxBqoHDuzn0W+6r12c5cF2q32MHOqyK
	tFXXlRoAeySuG3AZKcCrXJZRotDaeDrJlyOvoHLCkSIaLX5QLT06y0dMY1FQgoc3H0gxrIe3a6O
	TKVecD1S2u8FNCmdib+lHmJWTUdKLZcqcpiyYUJMJ0azFgWixcc0wAXhyAfbXSMSMA+vsl9j0az
	bBAj50DRTOk4INqa4Lb1PuwEbR31I+jILqHOrM9xfArDmkdMQEx5hjAv6axh7hKnKIMb4yOTQ0F
	THdM+GqrxUlfOemoZRRBIHQ5zpCAdcJfL3Nr6OZ5eCCcJyYYwE+Ob0tNrSW4gCiiLIJvNVc9boC
	EX4zYh80AoyeCvx9hNq+9T+6ueuOyjI2mO8N2Zz+gqCaPEkk+A167QK2TKv8bG40YDyYu85oMP5
	absQDtHIx6byOVb2JN3PbBGtv/9eCu+Su/5mOD9nkvFas9RxmMb6vHI8GxY9SU2ns40lGj2EQBI
	rSBArs=
X-Received: by 2002:a05:6a20:4309:b0:3c8:ead5:bf7b with SMTP id adf61e73a8af0-3cb85ded991mr31306337637.4.1786163661150;
        Fri, 07 Aug 2026 21:34:21 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.253.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88473sm13060832eec.17.2026.08.07.21.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 21:34:20 -0700 (PDT)
Message-ID: <6a76b1cc.881e6cae.4accd.ccf6@mx.google.com>
Date: Fri, 07 Aug 2026 21:34:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8239486681894501302=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, proxy-alt@proxy-alt.dev
Subject: RE: [BlueZ] shared/gatt-client: discover the CCC descriptor instead of assuming it
In-Reply-To: <20260808031940.66686-1-proxy-alt@proxy-alt.dev>
References: <20260808031940.66686-1-proxy-alt@proxy-alt.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8239486681894501302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142517

---Test result---

Test Summary:
CheckPatch                    PASS      0.32 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      18.42 seconds
BluezMake                     PASS      571.13 seconds
MakeCheck                     PASS      0.98 seconds
MakeDistcheck                 FAIL      118.10 seconds
CheckValgrind                 PASS      144.24 seconds
CheckSmatch                   PASS      249.75 seconds
bluezmakeextell               PASS      89.99 seconds
IncrementalBuild              PASS      574.78 seconds
ScanBuild                     PASS      809.47 seconds

Details
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

../../test-driver: line 107: 52684 Aborted                 (core dumped) "$@" > $log_file 2>&1
../../test-driver: line 107: 52701 Aborted                 (core dumped) "$@" > $log_file 2>&1
../../test-driver: line 107: 52964 Aborted                 (core dumped) "$@" > $log_file 2>&1
make[4]: *** [Makefile:10247: test-suite.log] Error 1
make[3]: *** [Makefile:10355: check-TESTS] Error 2
make[2]: *** [Makefile:10826: check-am] Error 2
make[1]: *** [Makefile:10828: check] Error 2
make: *** [Makefile:10749: distcheck] Error 1


https://github.com/bluez/bluez/pull/2387

---
Regards,
Linux Bluetooth


--===============8239486681894501302==--
