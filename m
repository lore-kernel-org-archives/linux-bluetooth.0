Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900303;
	b=ZACXEqIQaOjRS4EOCYAhkEUxCxvb5UlSA5QD2Kz07jm+J72SJxyc9vz6Id+pW3iDf9MN
	 sqqSWxVnCUNM7ofnulv1TtMHcHNdsmiID3qZCdDUioFxeZxfmGjBoJc8T//L0/ujw3QMt
	 zp3Ru6YzwOTok7QgYdB4qL2fyu5toJox4EOAABfruAR6zShGYmyp8Fe+ga4AlCdVYP7ut
	 iQlC6eu8cICbnzsknjLKHqPcP+4PD2JWSbwB+H931Vg5z6SYf4aFog6jr6smSQhHMRTGI
	 ZMwltXl9cbmdCpCGbkjwFzHmFLO+dEUHdq4kDI8BSTQlnu2EB9EpvHN/DyF7Z19JcVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=j0J+eZYiw5xV12js7fNPzjW3saOfPH2WxVmvac0Qksc=;
	b=nvNH54ie8uHcvzdYWBchbENgzSiMAnubvbue8XJxVoJrcP/iIDSejg31eL3u4eLKHLzZ
	 fPVvtt0/OBVdLccZeG2pQbTHzueo2mpNVgdJTrRHJ1YefdXfDAAFcbPzqxKK2zagd4z3E
	 i6PAJ5lJxaloNz5BJtyWXug/yICIeQOc13jcMBvdqE1FkrkY5/e8rBvCmoeoPZ2pvthuL
	 XHXOLHB/0QZx5IZvdVMYjuxe0Vc59RzmWZkrfSUXgBhNzvzLekuVsDTtlrs+MCCbBE3Hw
	 +GP7jSTnjAX+Y5MQTUedyusCMO1d6wlvAfE5bnfYb/EqGWQxz6XhQcNkxbD689GqkbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v2aMRcE3;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E04C606A326
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 17:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E04C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v2aMRcE3
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1ae18eb9b69so2248812c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 09:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793900302; x=1794505102; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j0J+eZYiw5xV12js7fNPzjW3saOfPH2WxVmvac0Qksc=;
        b=v2aMRcE303iCO47zgnEK1ck73l5a18SebhB77/1tMZGmsPhowTksKWd0WAIulSGbe1
         hmYC6NhBwiCAO0wwXcBpFrBwDfdUkOP9C32nTzUFwUwdP0Avs8g0ISOP3l2a5A7acvlo
         GRxdPVwUjzyhdl1Mouex71HqkJxIGjXOnIKRjZ4fY5w/qLPe1Fvhbo0whcIKIGcf9X29
         mjky4tBG8YvkmCi0epsM1JRBYr7Urk8P5BCpgk/4sZaolitq26Otsu3H8fTdCq5LakSd
         3QRk0823RqsfkU8aTDdoGM5EC+YgFvmVuAT/crfWjl4IQLPnIN2zE35AeMhKIqlFcnIR
         ZssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793900302; x=1794505102;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j0J+eZYiw5xV12js7fNPzjW3saOfPH2WxVmvac0Qksc=;
        b=IUGh4ZsyeF6Ydn2qXJgNReV46c6As6iOpYjjFmf3aBmp+dfeGJlYk0iBNffBbZGUL8
         LM5k4z7hknHoESicD3d9TPHO9AeBynBs4DAq8YJf71Kzkl2+1UIJ/dGgEWm49Vndqa46
         BMaI+72lOA3Kpy0gaDld5mRjgactjCPpL7E4nOkrB76ijqE6da6eb4sNrGb2iBUBVdZ5
         brUCtQz3RY0E66Nh6pLqqyliQ4FB/Anpvpp3QgkDgrtsesZ5AA/PmL2+ag4Tvsi1H60g
         LW+sZ/GdVASlbAU0APlpS8x0PmikFET5CDxPIrObn7rcvlTRgB7liucDTfDs6aRzlKIc
         8F1Q==
X-Gm-Message-State: APuU4Z+WfsBGkonlaD4FLVm4mo/LE+Nuo7SekkmSRTZ9zek91fWQWDp+
	IMtDg33FsmLspz7JV368UnMj/O0mWMQumxUNcWd1xcGsYwCyJrk4JolLLLAjqA==
X-Gm-Gg: AYBFou0iQvjbiQO/PJEnxmPbM7z5+b/PenhE9YBp+xN5fWT6xjLp2CtCIYVuljl5a6n
	L42UyEEm+LQy5csa9Pg186+At5lWIGp4VcX4dS61OsVesW4y7Ghb8kXFix0ByQY2gIX12g/2hC+
	fT9ou0REI4BOG5KY3J/Qb5GxsrUW9SshYZi4mPQY8H8YbxSUPG5yRyvkIn6NTjwdkgKiHFD66Na
	2fGrT7QIDAGRiHkJMiOVne//pU2V4CK+SqyuQmy+ur3bJTh2f1VjB8hpDqf9BX0AXM41S0pmiwP
	fXIRwKhWaT103D8Bc7FKzFFkW6aNta5ob0Wyylyeppqt/2/YpFOJAQ+U2GZSthBRBLSemuNuNlu
	hw9pereyzrL7msDDcldXjbEiwXIp0DSd/FmSaSQUL9Tqip7UH8xnuKJTBuZcvU0hVn+CYYegE1t
	cLkSBXCbgpWqXOhI7N8m/BOC+mLO4KumJCT6hzxNf0WaWA6kjijaE+UhufqwOcGnZ0Ew1vAHAJA
	s8x86TLaS0KBCbYQVjCjGjBJcNbMfq8od6Rnt0b8SFUYDH2sScAlYzl/APEwA==
X-Received: by 2002:a05:7022:f115:b0:183:7d42:cfb5 with SMTP id a92af1059eb24-1ac5d88c1famr26727802c88.19.1793900301895;
        Thu, 05 Nov 2026 09:38:21 -0800 (PST)
Received: from [172.17.0.2] ([13.71.226.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2de58sm16749968c88.12.2026.11.05.09.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:38:21 -0800 (PST)
Message-ID: <6aecbf0d.5bfb57e8.8fec5.93c1@mx.google.com>
Date: Thu, 05 Nov 2026 09:38:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7859005525101484267=="
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
To: linux-bluetooth@vger.kernel.org, dev@deq.rocks
Subject: RE: Bluetooth: Broadcom controllers of the Apple T2 Macs
In-Reply-To: <20261105085750.120392-2-dev@deq.rocks>
References: <20261105085750.120392-2-dev@deq.rocks>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7859005525101484267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1202866/

---Test result---

Test Summary:
CheckPatch                    PASS      3.12 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.66 seconds
SubjectPrefix                 PASS      0.46 seconds
BuildKernel                   PASS      31.70 seconds
CheckAllWarning               PASS      35.36 seconds
CheckSparse                   PASS      50.29 seconds
BuildKernel32                 PASS      30.91 seconds
CheckKernelLLVM               PASS      32.74 seconds
TestRunnerSetup               PASS      742.33 seconds
IncrementalBuild              PASS      33.64 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,2/2] Bluetooth: set the strict duplicate filter quirk on Apple Broadcom controllers

1: T1 Title exceeds max length (87>80): "[v2,2/2] Bluetooth: set the strict duplicate filter quirk on Apple Broadcom controllers"


https://github.com/bluez/bluetooth-next/pull/1071

---
Regards,
Linux Bluetooth


--===============7859005525101484267==--
