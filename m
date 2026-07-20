Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9961639934D
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536618; cv=none; b=SZi0xZxMORsgTiVJMBILh5h9Ee69WQuGbvJ7WWYK4Xup6S8hH74U/2qriRx2CaW9jkfJOJgKniG3zEkA/TaABMJHoMbEPv7AB/y99R2mSoI5gb2Pb9PIMbDd1ibiCmDBrRIm5ckpwBl1OAWNxJ9uHRpxLMDWbW36n9Kf/OszsvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536618; c=relaxed/simple;
	bh=YZWgV8FnUsGyQxXK8aFTTTFiaDarMQvl8ta+gNpovSE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TPSMdpu/p4mBST7u1f/FvTTxYeio2iha169Bz7nbEI2fjDAKkE/+tgVv6tTMV/JJechHO8r6Old1B8ncC8IJF/xzpiBoh59k73WGSJ5LPO933t0Y+fOYyOj3UhtPc0IAx5/m1EUDCoBzTxXjbwhuagq1HwlHxsJkKjcTClu7jTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjvkZYaI; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjvkZYaI"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c149c5722so44472731cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 01:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784536616; x=1785141416; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lBMzXMMJdZSsfZyWif1AbkDxofytVsidF4tzeQrWfA4=;
        b=cjvkZYaIzETQnlQh2xsTs58QHf2CyMUvY+jI07iMeaxTh3SkgKyHHVgQ7aTDCzMrp4
         Lsk2AFdcBy5pEjUd2hN/V/GoTxew+HonD8TtkQu8n/W8NDt0kB1cD9d/NW9mD7cSzeLW
         USgjBTOIvLGQPD1di8FqR+B9KDaEZIuOO1Qdc3QsY27F7U05TQbYcRY5iGz/Rm9j6wPo
         NJbvmLbauexyuxbTomyWWDJ7NmF9qizTvwtBq8V7417Wsw9NBEGt1NqSteh2oWPHZEvm
         58nReXShrk5RLU9I1tLuYp5poOZSCgZU1fX/Cz2mIr0YuYZFc4EYu3goTxgg355ar01h
         nOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784536616; x=1785141416;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lBMzXMMJdZSsfZyWif1AbkDxofytVsidF4tzeQrWfA4=;
        b=e0PJuEwqbTmq+hGC4t1P0b9TOElFW8TNZB+18mmzZwnWml1kVLV7UcfYqWO/ScQkDn
         u+XHcbixSnrbzgeeoPkTpSSGEFcbXxZQdVVaIPfPMHQkMdYrpjc+USLAmFV99U/qsYRh
         CCZddNALcNXaOM/BURy5s2DjH5s8zqRlVN8BUVPyOg811i1JZFWgwFpCzooVqP0BjNMb
         YNI/192tfZKw134xHXBINZrg/Euc+V27VssJp/BAlQrdT6KVw4D9VIwJeomep3txGGHy
         kQOggmtJfzXnkh5cmK+2QDoIuIygYVzxw7BzytfbVQoCm1Y45mlB7TYiw/RD3zGAfcnA
         WLEw==
X-Gm-Message-State: AOJu0Yw8dRd1pdf1LsVZ/PCka/7B+wT3nTj9xfk4YFOBlnvJ7amK8NLn
	E/HsGXnwD/UEkkxXKR6oSbKF3KLucawC6XYSkJzA/wkVtYbPzmnL3wBAXLk6og==
X-Gm-Gg: AfdE7cnUMiiCmvgvuHvUdqSXoI5w1HkI7KEG54IdjG9m4p5Hf+wprxi7FA+XCow2wGl
	uVBFhlROaU7HSHudjV4Jod6OeSjhHiLa5uFXvJDC51z7OhVA7DQLOUr2eoLXgapvEGB+9/crxyU
	+HKZBM21/ERKvEPlbWgwT+9yhgBoTZ4xT8GFDJvdXXw1G6O4ucQ6PNsNewHH3ToXKEZWZZBbH2Z
	09FzceEh5UpGKNLlECN8hkpHDNtMTOFn7Zjz5OiwFH9ZNw1bM392z1DdvSekmxMU6eCL0umXi8n
	Cx+4PAhsbWVFW2igCJLvucYZMiVT1zv2XYKH5egbycK88G/oETNRI/OF1EaUwevfmmO8OHyrWni
	fl5JR/QtOpRCbyW22iZMnGsvA6FFXHmPx+jd0pHPTAh+tOhDdTl/Ly6QEEQGrLLHpgcpyfVgFR1
	e1MaaAo3YwOsTv/EKZI14j
X-Received: by 2002:ac8:5850:0:b0:51c:753:4679 with SMTP id d75a77b69052e-51fc129313amr170948821cf.28.1784536616430;
        Mon, 20 Jul 2026 01:36:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.223.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214f015f71sm68526821cf.16.2026.07.20.01.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:36:56 -0700 (PDT)
Message-ID: <6a5dde28.b5fdfa5d.50fed.a89b@mx.google.com>
Date: Mon, 20 Jul 2026 01:36:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0902848544341883668=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: BlueZ: Add generic support for vendor HCI frames
In-Reply-To: <20260719-vendor_hci-v1-1-df2ac5a50117@oss.qualcomm.com>
References: <20260719-vendor_hci-v1-1-df2ac5a50117@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0902848544341883668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1130548

---Test result---

Test Summary:
CheckPatch                    PASS      1.46 seconds
GitLint                       FAIL      1.02 seconds
BuildEll                      PASS      20.51 seconds
BluezMake                     PASS      548.95 seconds
MakeCheck                     PASS      18.66 seconds
MakeDistcheck                 PASS      159.62 seconds
CheckValgrind                 PASS      228.86 seconds
CheckSmatch                   WARNING   311.81 seconds
bluezmakeextell               PASS      102.54 seconds
IncrementalBuild              PASS      577.00 seconds
ScanBuild                     PASS      971.49 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[bluez,RFC,2/3] doc: hci-protocol: Add sock option BT_RCV_VENDOR_PKT for HCI_CHANNEL_USER

1: T1 Title exceeds max length (89>80): "[bluez,RFC,2/3] doc: hci-protocol: Add sock option BT_RCV_VENDOR_PKT for HCI_CHANNEL_USER"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2003:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2332

---
Regards,
Linux Bluetooth


--===============0902848544341883668==--
