Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCAA1E481
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337574; cv=none; b=WYEp2BJ7Z9eNl3WCTtOTMQnPm2QxUoyBHkS4VtEsW9T4xlyh9hpoE1kNh1EJ/YguOX2AUCrzRrPQ3DLXcrbufHKVebDMKazf3bkwtacp295R4ISKXPRgL7NnW5cCyKspIELZWOnB4ANyR74NsFWUa6r42112K7/TMYJ1RkvM/G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337574; c=relaxed/simple;
	bh=cNmwx/Tc1dwFYfG9uG7QXX2RvMKD9PxqLJXSatBTmz0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WHYCcOCCo1OltXa7vpajX/LMkwzoaddOmEY+jKvMeIBcyG/70ihqa+UGnQrbmBSojaszKiv3gZVhib6eFTo27haJ/kNGw5RNkxi3WqJz1QogtwsWcRuqw2GaXyOgSmKJY6ywYpWjctowgvey71Afj3D2K+dIaOdCYKUWymVi3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCXow9tA; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCXow9tA"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b1418058bbso314184785a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 07:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731337571; x=1731942371; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P88pHuZPCBIQmD4HrJNI2GueRiWD6cblQ3DIznrrQPc=;
        b=BCXow9tALNE8wvPdV82IjwfDaBPZ+bhjHm38wG6Y7LnhJkzDgUVoly8EHQ20Go+sYF
         aqbhzFfO3umsv1G9kzqvvfoD9tRFq2W4YyFviXPFd0muBhb4LW2jK1mpp5y3miXLkR6Q
         q8KnSd4obJQconv91tNULp0+8EnRgm/dEqn1gpMwDry7wRyk7ymjsJHec7Te+AVhf8Et
         SzcQM8OCcCRWJiHPufqge25M9y2S4UYdxVLHZsqMOy+ka5Ldn/Ot+v8bSsUXOD28DPvs
         NEfhcnaKAuGLTq3J2mlYYZyx1cfYFjSjuNZDHsG63GW0TzxH/PGvKDgICDUF5knEIVaH
         pPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731337571; x=1731942371;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P88pHuZPCBIQmD4HrJNI2GueRiWD6cblQ3DIznrrQPc=;
        b=OGosAo9JDUxXqrXIwedkYpOzAZhowh7Qv77tPTSAEbTWrTkX7Eqi7mNz/LKeqAz8ap
         dntLHAVkY7TZgY1yuA4G6VCYPSDAQ+NWUE6nAN1ZxW6m1pWm87h3Nrg1xydVjXQ3xbsT
         zJFAoq/qAcFwWSMqhxVe6ZZQdkhRHRnn2TqyHLXyQNJnFiX3J66k3shgS3tCgGIO3csE
         LKXmOEcBscJo0T/FI/QEDOw3CMKS6hTPDUYW5myTQIhFE2RToF8wTeCfQZvZ0UIGCgGS
         021FFfX1hS7sH91elIEISsb8IpD90iXr7SmN8m9DS1kD1MC+g1c5lKqFVSLYi+CIZNcr
         AxIg==
X-Gm-Message-State: AOJu0YwzNCB4eiT/0xrbHQI48HsA3kcuvgNtgZtw/JDoL3lkmWP/voDy
	s7r/0zUaCWhBCc6asq2aihBaaONUzdKNL/Yw1U6DJVf+kywl5TFgetwsnw==
X-Google-Smtp-Source: AGHT+IGLVqnCxqhamlM9fV7mpsLobPYlC5bpA53Ge7wncKHB6GLyotpn2VYMCoVq93vXdOg2Sa4wzg==
X-Received: by 2002:a05:620a:469f:b0:7b1:4869:38db with SMTP id af79cd13be357-7b331ec5fc3mr1904069485a.32.1731337571079;
        Mon, 11 Nov 2024 07:06:11 -0800 (PST)
Received: from [172.17.0.2] ([172.183.161.216])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2da70sm505792785a.1.2024.11.11.07.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 07:06:10 -0800 (PST)
Message-ID: <67321d62.050a0220.165dd7.d35f@mx.google.com>
Date: Mon, 11 Nov 2024 07:06:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5457016420815119628=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obex: Update the FTP version to 1.3 in SDP record
In-Reply-To: <20241111132238.2162878-1-quic_amisjain@quicinc.com>
References: <20241111132238.2162878-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5457016420815119628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=908415

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      24.85 seconds
BluezMake                     PASS      1702.13 seconds
MakeCheck                     PASS      12.99 seconds
MakeDistcheck                 PASS      182.68 seconds
CheckValgrind                 PASS      256.64 seconds
CheckSmatch                   PASS      360.20 seconds
bluezmakeextell               PASS      122.13 seconds
IncrementalBuild              PASS      1454.19 seconds
ScanBuild                     PASS      1026.58 seconds



---
Regards,
Linux Bluetooth


--===============5457016420815119628==--
