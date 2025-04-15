Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C77134CF
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 03:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744686537; cv=none; b=TTr2PgHkUvBc4uT5iZ9aQc+1Jb5RV51dV+oBKcC4LgSsu/Pzsvl3/iFPo5XtQpe0dQnYW7MhWDuGRF4AvQARMX90bnsv2u1HqRR5LW0EmGTmcU4DYbhL7lYMKbdvbJukNaxleGSX72E/0+INhx3kSTS5Ij6LnI7MNd/uK5WeUmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744686537; c=relaxed/simple;
	bh=hN3B5m/agAqYSkQWqjFqyte4kUEIgEkjB0fP7Aa2v5I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oNo6nwNbjj2Tf6yIVTyj4RrV3uKjhevGl8FX2sxl96qZAgEkaR5T0IBeN8SRbWJY4awSsJB2GQm7VPYRCRPoQ+AfZS7OuiaQz3DbOTHvJazcQRfAo5+LW/MMdZnxuGU6VuRYZWNzniJ4GJhbR4owJ4eg+8ABSwon59rEfHT9K7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I90fdvNb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I90fdvNb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22423adf751so45917555ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Apr 2025 20:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744686535; x=1745291335; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rfa3LyyI4eR+zkZjoRECvi1U1OmPOQM9bIB86vA8ykE=;
        b=I90fdvNbEohf751e21FvdXYlW1hZQsQyYy0e7cnn98v/XJFSpmFiSRunwURpK4CdlV
         EPzVmC5P3EZPD2TRRmQTaKgdpci/Cc1USoCTETP0vjF6+XkCnpJ0VzN1rRM+jKnthtAc
         BuhSU+qODaLRMtaNZ02TWvz31kMvUmyTnYIvKwjHPkrM6FVuFtSL4vPkKzP6v443/pPT
         i8OhMh4X6L4acokrNSgscv+9rBAp04jAu4ggEQsUjvz/ZVOqDe2kFK4XN+Q+iXvaVt02
         VzD6DARrMjdXka+nrdeRXhWApiogxGnXMUAXddyPbzHYuNRIpHPcIYIIqbfZpCgY0Z3e
         gnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744686535; x=1745291335;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rfa3LyyI4eR+zkZjoRECvi1U1OmPOQM9bIB86vA8ykE=;
        b=m2CEYBW3lzmqMqINVxz5jgqrhIJcclZdMgkTfraItzlVdLMlywN1w6macXk0bgj7rk
         ud5AV0y1Id9xXJCryv5/yC2wnTXr2B9msYX0kdL/wSSGg+SoZoNeI3B1gYp2BZAd4q55
         S10qmDah1pgJhx6NkvtOIw7SUYAFQ/Ft7Cd2u8MbCW4BgLKJ3h3AYmzKdc31LXf5M3+8
         EaLuv34fnzoNI62tHQmy1od8js5gp7+UxJm40SIpD6Ysa40TGlNukHBQKHKqhewctere
         WkIBXmIoYcFZCJZyElfmTg4JyXggAh0YxV3t9IlRbZCgj4D8jkjK68N8sh5DCkqY8jb2
         lKHw==
X-Gm-Message-State: AOJu0Yx+NLMW2SbkaCS0F+YPSEIocId+CrWEvc1TvyF/wejqpH6l26YJ
	CbW1empy+F/s0B2D7p/BG+6kz6Iva3Kl0crwlMdu8/wMHhON0JsEKdK2Sw==
X-Gm-Gg: ASbGnct/AmvP26bmEBirCuLlHuRsFE1FfMA203KjDrrE21+wESjtX+BOk796AYlzh/0
	tU9w64Hsn1ET4pLL7UdDg/zN4U4KPZBuqvGOCmNWvBAbrslgJ937SwZKEdHd45V6X+jlV3A9SBZ
	qntA14bWdulGa8V+HgZfEcMhUB7QOiZ0tHCKfa87ZH9HXhSYRzjG7VR3+N5tIBdCm8CTMa5ISFS
	Cm2s6F7LShrTX6+Z7f0OtlUVUP9fhsMqR2s0S85htdxJ90uhJM43D69/I8cHHW0DQKs5xqvH6zh
	yYpq9McyfvFSeClG/zabMur+at21kfQwGMePSFN62q3T9w==
X-Google-Smtp-Source: AGHT+IH/2IB3xsxvcCT92dXIJ8jN+xZCvUP3JDOE4b8enIP2rTH2RgpgLQZrdeJ4uibHI+rD7cCiwA==
X-Received: by 2002:a17:902:bc42:b0:224:b60:3cd3 with SMTP id d9443c01a7336-22bea4ab833mr160538805ad.19.1744686535366;
        Mon, 14 Apr 2025 20:08:55 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.44.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f0fb7sm7581878b3a.109.2025.04.14.20.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 20:08:55 -0700 (PDT)
Message-ID: <67fdcdc7.050a0220.234cb2.7511@mx.google.com>
Date: Mon, 14 Apr 2025 20:08:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6871910949854503886=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wangyuli@uniontech.com
Subject: RE: [RESEND] Bluetooth: btusb: Add RTL8851BE device 0x0bda:0xb850
In-Reply-To: <CC9464EB852D10EC+20250415023350.16083-1-wangyuli@uniontech.com>
References: <CC9464EB852D10EC+20250415023350.16083-1-wangyuli@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6871910949854503886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=953336

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      25.82 seconds
CheckAllWarning               PASS      26.59 seconds
CheckSparse                   PASS      30.19 seconds
BuildKernel32                 PASS      24.23 seconds
TestRunnerSetup               PASS      460.83 seconds
TestRunner_l2cap-tester       PASS      20.96 seconds
TestRunner_iso-tester         PASS      36.63 seconds
TestRunner_bnep-tester        PASS      4.72 seconds
TestRunner_mgmt-tester        PASS      118.35 seconds
TestRunner_rfcomm-tester      PASS      7.75 seconds
TestRunner_sco-tester         PASS      12.65 seconds
TestRunner_ioctl-tester       PASS      8.28 seconds
TestRunner_mesh-tester        PASS      6.55 seconds
TestRunner_smp-tester         PASS      7.79 seconds
TestRunner_userchan-tester    PASS      4.89 seconds
IncrementalBuild              PENDING   0.50 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6871910949854503886==--
