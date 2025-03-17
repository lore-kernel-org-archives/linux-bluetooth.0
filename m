Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86D1DDA2D
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742239807; cv=none; b=HXNjWi905XOsxgJdBZF16MA93osVEhjB6bXxU2ydluGBM4UkVqLrZHeW7t6vrCpwvP6NalB9utctx0cAjtWUOEGl5J1m88oyexHWzlUEFofDf9a5Bjlax/1W0nALyrXIGvPsrPNWt2TXOX/CFwdIjtSZ5Ch3SR+KjAWd1u7STz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742239807; c=relaxed/simple;
	bh=WCdC1wRurR00FEQWv8nyswZ/JVAkxKiJ4u/Pd3NvwgM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QXc776+LhzUccDT67aHpwy101+HUrgofBBu+v13eOZuZnc7WxTHHuelZUy2S/3to6GeRC2MfT1Dxxb0Ff9vIhbzhZ+PHI0aNWS1pzlxysMZ7rp5zFRzwjIp+prDFapGd7FD5PN+oF7hE979q2wDDRsFB4ShezclIAEg/wtWkx1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDIRy/GZ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDIRy/GZ"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4769bbc21b0so48968681cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 12:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742239804; x=1742844604; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u6N294xrto3ElE93yrmHNzYiBwFo5ynDzgNi/LLszv0=;
        b=WDIRy/GZuXIQLP6wkiSfOFO1yHi33oudv9FdKJ/svwln++irNPEdD4a03HZ2Cb6DMn
         W/rxklicbR8nhsRL14yhRj8H23lKQWGRLN7beTdfRPG2koltHWIKXwjTO0m7bQQbXJxK
         oa8eMAXPjsiHtLZ2sBjpI/UUZssgq7ISbc68Uf62+2BHJlmhi/UGOu35rceQhO/UzP9R
         SbCwgeDMxiAg2S3TqhMPI3NMWSqs9mFxUHJN6tRB1/eqmeKtSasL/kA3bBaOkxMPxMZY
         HogLuB5OJhm7W1x+ZYbrixlQZjWse42ik9nRDMWg5m9bJENklrraeqiLCsbgiXU9G5w2
         xJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742239804; x=1742844604;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6N294xrto3ElE93yrmHNzYiBwFo5ynDzgNi/LLszv0=;
        b=hLYnkdnMG9wFBjv+X9ND7M/b59REbtkBaYKa4uuz/7/9P+Yw1ynVWMlF9pglAfR4/9
         8202LpYbqT9WwggDUQY1o7gB3WMTSOSUYKT5hQcX1wkEdUhp2UDbg28Wwh79Ctf8Uvf2
         B3zPJrI/EpOHgpseM9IjJR5XOXJ6DIrsNiYDfCnVGidz/UuDTDmzmszh795zyQoev71x
         Z3Ni3R4GlBpx7xFve2ECCylF6CvChJBZvvshj4bMirwypOLtsnc8nP1Sh0EcpK/i62ng
         3vAjpyaYdsgbSjIYUBzWdqVdZaM1qCFSJ6E4k4zzPlYN4/iLWhoXzyKgubMFrkXNoqwm
         W/dw==
X-Gm-Message-State: AOJu0Yx3eoOof5e+WJqScKG53PMHdPrIKQm4VFln3Axt/z/xPWOf52Jx
	XaOO8XWh/h8AJuLb+I8iJdKPGCmBc2kDdfeMkFr+SxSi9CnmxqxDKpOEuw==
X-Gm-Gg: ASbGnct29WE613cOfh7WwF/9AWbXFYfIbt1ZcLP7ATWzehPPbRjE9Oc7WQQ0hZpvB+q
	Hi2SIxfDVEjqtxQ7PnQaaXb1Jz1xuqRWETjsUBsDUDDlqw1l7RtU1y0z8C5S8Ub6A6yhuTvNO2U
	xTOhQvu2rfoWrG5Zy/p3Ktf8Tf/0IZLf6aFGCEWh+M/e87gyt8BBVOs85E3CYOOnc9dVoOZaMaE
	wDLb84hU9ZJz0AzyRurls+lDjEVgmtfsLHT63FhX90BoAedyQEpJIpygE6Cu8HpgbJE2bLJDYzz
	OrayL4nDJ4n5YxlGoq2X65MoXHJUMjo+yIMgzeF0cn4CpEZ104n0
X-Google-Smtp-Source: AGHT+IGbaoFopZCayBGexEICNVVB7GwquR45Wvs2m60eC5OYZVPo/L9q9R/M9ZHbwMyh1fcnS+ocGA==
X-Received: by 2002:a05:622a:114b:b0:476:afd2:5b60 with SMTP id d75a77b69052e-476fc999df5mr13090741cf.15.1742239804041;
        Mon, 17 Mar 2025 12:30:04 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.76.170])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb82c170sm57227831cf.77.2025.03.17.12.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 12:30:03 -0700 (PDT)
Message-ID: <67d8783b.050a0220.2f80b1.4d47@mx.google.com>
Date: Mon, 17 Mar 2025 12:30:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4566738230193803829=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, guanwentao@uniontech.com
Subject: RE: [v2] Bluetooth: HCI: Add definition of hci_rp_remote_name_req_cancel
In-Reply-To: <20250317185033.11476-1-guanwentao@uniontech.com>
References: <20250317185033.11476-1-guanwentao@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4566738230193803829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=944821

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.41 seconds
CheckAllWarning               PASS      26.73 seconds
CheckSparse                   WARNING   30.13 seconds
BuildKernel32                 PASS      23.92 seconds
TestRunnerSetup               PASS      427.91 seconds
TestRunner_l2cap-tester       PASS      21.08 seconds
TestRunner_iso-tester         PASS      30.56 seconds
TestRunner_bnep-tester        PASS      4.91 seconds
TestRunner_mgmt-tester        FAIL      137.70 seconds
TestRunner_rfcomm-tester      PASS      7.87 seconds
TestRunner_sco-tester         PASS      12.22 seconds
TestRunner_ioctl-tester       PASS      8.39 seconds
TestRunner_mesh-tester        PASS      5.99 seconds
TestRunner_smp-tester         PASS      7.25 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PENDING   0.68 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.190 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.190 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4566738230193803829==--
