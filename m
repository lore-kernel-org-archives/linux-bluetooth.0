Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F929A2
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 03:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744084123; cv=none; b=RWv0g98XQhmaKO0ayTqFj18UC0EgG8cG+8i3+06/Vf8hEefZMMo254W79wRjsavUX1fW161emm4UZ9ivuwFwtlIxA6YFCwZiFOCqvFEKpK74lopA9lzvsrs4HmE3N5QMGeBRCnF+h0sDrfFrsHfo9xIDdc4DROxWFDUYRcEgdH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744084123; c=relaxed/simple;
	bh=35HUcMAM6FfBZPwxgCwOKvEZDehD7m0CiiPKMIKn6E0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=J9djJ3pbQP8daEroVHjhxSegNCOEBpAtlOgns6LDITr04aiSHPteI7MOxSsIvkri4geQt0bp3m/GeYuiJn/tzp6IUNi37XltU0On7/XgnpU5hlKPBk7GxWh8Xe8+b0q32MMtyXFi3U3s/IeGRdYkmcho7ssxwRLTCGwLVxPhmaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmEJJBgD; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmEJJBgD"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c54b651310so701891085a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 20:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744084119; x=1744688919; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fqYJE+it5Ovg0RJ6K19K1X7VES5dex+EjFH4QtK2Dxg=;
        b=AmEJJBgDOaFuOFc7cIMRRVT7f86HLmDb+UMSxl+kXmotKEIZP//Ud3xP9ojGLgrRlZ
         wTf6agK6VQfxtoy2VpLeZuaA02r0JWvCZkH3WF4+K9Ar8alCLwB88axLrCPebOxI0zKB
         uhkHWyiKbOqbumWmfa+9iNZQr/vs3KylRSusDOY/dAGKqep2l8K7I8RPVCZuQp2dEk2V
         pKh+wKfheCLbpPtUz18FZKMtN4gLWhW6j2MYfpHO1B58VlyPXRnlaV18vtEqp0WtHSG5
         TuefWQYzaZd76rfnB6rFSZh3K7Hr4ffKzveQKhoHoKRBRyRPECVypiIic9bgmYJerTuQ
         MqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744084119; x=1744688919;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqYJE+it5Ovg0RJ6K19K1X7VES5dex+EjFH4QtK2Dxg=;
        b=PAp3FFLFtvBUOSHWCz77G0m1Ja5LuaynWld+UOCKHMBTWodc4+05o0oLKncX1gvd08
         dj/lh9qoKzWo54vOOSueZ3PQZc+G9P81uqbLaymTPOiGeN5Wlex5OKuEoNfny9u+2Fbx
         dC0TyY967/dbzSJGOUrDnnvlr3j5vgg+B2ieLah0LnYymZNp8WEkrPZXIJU62O/01+Wj
         ugjGlw1L1JsSXW/Wylx+yF3o/5qyRkDdcCi/fcFsWt0Yz3TKS9uaDR5XfdRRY5fDxMjR
         vQB2msTiMswVYuoErNXRa0Uz//x+rYaLH98YJQO+QY+zIYO2U9liBUX4bzIQHTEZzrnl
         FTlw==
X-Gm-Message-State: AOJu0YzLVBiKK7RY6hUv+/n8n90aAC2JYXIWX6P6REG4yyTKQOU9fhCb
	PG+UtxvFKRuGo23Dk68avAJDVDJNRJzW20462T13SfiBGZUHb5xHUhG62Wwc
X-Gm-Gg: ASbGncvcKF/tUrPpNjlgWDBhQbd2jFmM6wUIysHgc3QcepUigcgnw2/+4OuLnGEsYdx
	yxDtt+hYIQxd3UnjHDbBhyuhigJeaZbFXyhtb+D0BHjN/lAEqvi06w9Zak3bJCuTWlHsCwuxoTm
	/1VfUYEuADtmxTB2eWvZL2ZifRIwmMLPuFLdReE/qvcDxBH8aMzOEXs+o6fpqoAQjgh3inhhiJb
	j4h4S2F6UkOFcf8BzxQyhbyeBtF3mE0/L7vTN4an0eb21+f/dyTuVnvg7tXYZE+N/41V/1DOQT6
	Eq5Br3cCVinM8Y5T16tciPKMiKHLXcghhYg1OhLOOQ5vdtgUHoE//A==
X-Google-Smtp-Source: AGHT+IFdmVFsqXsGgs+IhoCVuG80UUxkIZ3KDmtd84xuQ83cZVzdw5i3cL9pSoKMNxLZJsArMJ4p7g==
X-Received: by 2002:a05:620a:4544:b0:7c5:44d0:7dbb with SMTP id af79cd13be357-7c774d5d871mr2273399185a.28.1744084119304;
        Mon, 07 Apr 2025 20:48:39 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.132.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e735382sm698617185a.16.2025.04.07.20.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 20:48:39 -0700 (PDT)
Message-ID: <67f49c97.050a0220.3925a6.4bdf@mx.google.com>
Date: Mon, 07 Apr 2025 20:48:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6587073913678986611=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: [v1] Bluetooth: hci_sync: Establishing ACL links is prohibited when power off
In-Reply-To: <20250408024646.1784057-1-quic_shuaz@quicinc.com>
References: <20250408024646.1784057-1-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6587073913678986611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=950871

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      24.64 seconds
CheckAllWarning               PASS      26.81 seconds
CheckSparse                   PASS      30.00 seconds
BuildKernel32                 PASS      24.39 seconds
TestRunnerSetup               PASS      432.17 seconds
TestRunner_l2cap-tester       PASS      21.39 seconds
TestRunner_iso-tester         PASS      37.28 seconds
TestRunner_bnep-tester        PASS      4.77 seconds
TestRunner_mgmt-tester        FAIL      123.60 seconds
TestRunner_rfcomm-tester      PASS      7.90 seconds
TestRunner_sco-tester         PASS      12.77 seconds
TestRunner_ioctl-tester       PASS      8.52 seconds
TestRunner_mesh-tester        PASS      6.13 seconds
TestRunner_smp-tester         PASS      7.35 seconds
TestRunner_userchan-tester    PASS      5.13 seconds
IncrementalBuild              PENDING   0.69 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.178 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.194 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6587073913678986611==--
