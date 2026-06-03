Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085AB31E85E
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519004; cv=none; b=dTfsyc9FnTGj3mYea7RUFxIKbzgYJvsSCfnmulhX/t/h5HU4g4UdlE+QJ6C4WuwImSnPorOiJVIdzmGPOxF2u8R082+aKTIGAFkXtd5+xOwPq9VvSkQBDi2CSfsQqr1SCHPWc9B/15Vf1eNhyS3J81K+9hCmu3Y1foNBtECLq7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519004; c=relaxed/simple;
	bh=KM5difWY5Q9AMDsjVA37kuG/Gy24BuzP29ZK7NrE2H8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Iv0dBlMGa3RM/EQRCgt0ViPsiha7wGOikZcachs0msWn8cHTTGJuGy5BMfCl6GbHfTgHNXr7yR0yoVVhJ252byGqbd3SLC6YSLpkh60KenU3/0mcbRwCsdvpS53cVhdgy5Inw7XaVme1gzdJev/Kr/WZ+zgx9/sHVSusdwFBDts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeNLIbYh; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeNLIbYh"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-91550dda53cso3582185a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 13:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780519002; x=1781123802; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MBEht+d0ksOceSUgzZwkMN3mEPmC5PPedhZ5atYl7eI=;
        b=UeNLIbYh4MSwt9rGOUAgqrpJyRbTKmHsMK0dizJPJmcIFiS/zhN/kKAVbjZHQFHp0l
         vlTDLtT5DOAMGuC8Uwlb3lVn0+R9KyjqE1vVorOllsdwAF/bSJSEGQ6Ni197eF45E95b
         GwTMLpI8p2kog3ZA/W3kIM7o1amkkotzgZyZVbWwx25WWb0f2D2ZCn6YoPYXHj4vv4s0
         HjjDyn8zMSdsZNCHzZzj5/dMgu03gcmYA5VVY5GBVPIPgY4XJXXju2mqZhMhNE6kdY+G
         wa886Xr64AU85RA3S3wZ5OFmEEG06G1AXu/xp3/qGiqnljVPdOD018H14orQeoZvRkkT
         C0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780519002; x=1781123802;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBEht+d0ksOceSUgzZwkMN3mEPmC5PPedhZ5atYl7eI=;
        b=WGXKFCSaMYg/llz1+VeYBvxvv0m7ce430q4MfCfemo7CO3WWmgiFOfVh7hH46vFaeo
         CQRPYh/8gXxVuWG8lZ1c8xgHWSzZ7KO73j/Qjxlb3l1bZXV+NO0GOJlAgGx4Qzu0X7Ls
         ItANq4ax+1xlk+Cqgot8UwcP5aBd6ovHHuSPodPXp2srUF0cIBIn475lycmu/JB5Zsf/
         odgu6u1z2tAJz7S/h3UsY3g4yOMPrefGf7hbyHB+59jbreLz9aVh4jpA+rmuba8X5bZs
         wwuAllC+iEbhx1Z0HyE0+/IBn9ft/6ONjrqMIC0hHMg7+xDTDkyEGcpEIndgU6QkKmMA
         HRCA==
X-Gm-Message-State: AOJu0YzlZps7naO62rb3+NPy/pSivC08gHb6MN6chCD3mLPlDPQCCV5U
	ESPO86/Wcb0+xFUA3Rrcqrtjtyrbl0n6wiWlRStTgIzK+pXQiKKE63QAJuDA7A==
X-Gm-Gg: Acq92OG20I7IRwhIdRSvduUABG2xoE0zyKgyahQQ0u+HnU4Cv3YdkhoVfDV5joQ2B9B
	aFtPG8FxMJXEmzGYTg3JjbL2++fvsR4pVBDVoKzkIfyu/MYlBWb3zhTNzafWXEr0zH6WV89WX6Y
	RRkySdjRVEJOSQy9Sn33wKar7I33BBfuEsnwqRuJIdlAEyokNfQaZM/88C3yDVX48zC9oj0ljEp
	fhnKtAcPPvHevQaFJG+7dUyDoRptH1LgGRddqbjPUj5Jn31hohpo0dcf1THzosfu5hgSnp0VYAb
	vm7Ac0fD0WuFb5pHlCIhtEGSSk3hRqFd3njTf/qkLPTwg/6CbaSjYN1MQ2CLnx1K4jwhlbFl34o
	v93OVQc06EcFngkpkSzi5ulz2RlTG2FKYLZcKPme1pPLOxSoMWH+E9ZkMmxXmrBnM3u6UyTCTFh
	HBtySt3TS3h7cWl9CwZU6LgBp5ENey/iFbaneWeNEWqA==
X-Received: by 2002:a05:620a:1b9b:b0:915:9a1b:83df with SMTP id af79cd13be357-9159a1b990dmr266052485a.57.1780519001900;
        Wed, 03 Jun 2026 13:36:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.223.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37c50bsm357041385a.24.2026.06.03.13.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 13:36:41 -0700 (PDT)
Message-ID: <6a209059.af142770.29dcae.eb1a@mx.google.com>
Date: Wed, 03 Jun 2026 13:36:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1064362078246847360=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] client/mgmt: Add options to ltks command for loading entries
In-Reply-To: <20260603190358.425835-1-luiz.dentz@gmail.com>
References: <20260603190358.425835-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1064362078246847360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1105509

---Test result---

Test Summary:
CheckPatch                    PASS      0.88 seconds
GitLint                       PASS      0.58 seconds
BuildEll                      PASS      17.95 seconds
BluezMake                     PASS      654.52 seconds
MakeCheck                     PASS      18.33 seconds
MakeDistcheck                 PASS      223.87 seconds
CheckValgrind                 PASS      277.86 seconds
CheckSmatch                   PASS      312.38 seconds
bluezmakeextell               PASS      166.67 seconds
IncrementalBuild              PASS      636.29 seconds
ScanBuild                     PASS      923.83 seconds



https://github.com/bluez/bluez/pull/2173

---
Regards,
Linux Bluetooth


--===============1064362078246847360==--
