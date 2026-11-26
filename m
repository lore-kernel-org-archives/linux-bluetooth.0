Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665115;
	b=FAsiBC1wZSmrKFd7+i+Es+rmAmLuQGtFAx0nXuk1Wou7AIqWO5ThiZYzL6P4wkXhu+Tu
	 eUfx8S739/COitQr/Qf5dlXwRb7HwBLjhWzBLIaEmI+Uzkj7EDwkF/TR9rLTocCL9kp1H
	 p3eFeLizW6cPkCK//asBMM4WYh/g7JqyDFMFblDYnjtW6P4NjHdV81Q+TqDbTPqFhpDlG
	 CChJ8U+umoafBpsuZCFA1Hok0bF9Zdj+w6Y91licA9C+sb6q6pvrpmmCtaN4tDEjn5GEw
	 8tEXNmom42UZddTbr5aeZVcRH81Q2T9mejqMrxi5/v/3nUyTIP9AgaxZrUwApgBbSMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=w/U593bNaV1VQko+dgLULueKGqXHdZR2aWD7qAMz8t0=;
	b=h3wQ8zGtNXv1G3S2fgcR+pXN8AXnP6KaS67pRbmo53rfhXST/kuo9xqs2hBQbli4mkvN
	 TjSVn2P9jXDYpiFpBJGu1Q2f0Q2orKlXt1eQSmdmT7/IrPqY4JWiDFOu6kvxk0wYjghBa
	 FkgIEQ2JdhWvTUIuTvYy9qV0FZToVBFExRNWCgpikgrEcHMp2gO3FqIhbs71LJlKoPTw9
	 WqN+Ugn6ZNMmYD/RQQdlOemliUWuhXJeMLhCCYqoVS3zm7BGnynvkqjnzXZdtO8OdFnxy
	 rTDVQ2veCAvj0Iov4e6B2VNNpuwlRvuoW7+jsY9D6ZEiYaUYEwoE93E4TO6ZL+ROm+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NZRebAV+;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716DD606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 03:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 716DD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NZRebAV+
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f04f61282dso30233655ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 19:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795665115; x=1796269915; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w/U593bNaV1VQko+dgLULueKGqXHdZR2aWD7qAMz8t0=;
        b=NZRebAV+DbnWRhoQ66YeomdXZwTiT/ZHYPMoqSHZhUH1a63iHYIXSdX4RYFZs5fW3C
         HeCU9KGTBl0O6oH2FkvBwW/ZJM5IuL8LXRuinJz556I/FXJxrQZcW0GrZxV46+5Rqi9Q
         kWehlN09Y+Tuz4OGE0qZ9qD8myDMxOd6sLm3X8nAku2ZDiWd67zfOxmkB3N+Wjbn1xNP
         GhI0c5ZeqsXN/PjE+KErftibCiF5m9liqWTHBPCr6a2tjYZo4fIHSnnwwAaJC8ewr9Kg
         EKrhUPdIuXhQQkx0Fu/iVqaekCNylgRfJ82oHGo8oPIOqHhCJSZ5o9/IgKIJy40m4dnv
         j6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795665115; x=1796269915;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w/U593bNaV1VQko+dgLULueKGqXHdZR2aWD7qAMz8t0=;
        b=1AKmWPO3/mRLzE/Aa/FuaO9m8oCOH2plGTdkApYFbGtdj/z9YDRoiGzcZXd3G5Jy87
         fHN7S3SIFDSJRTX9vl0bOV2olWmM5qCr/tp2th91zHmogJXQ5hs1p4kjZvSgurBTQrPQ
         yzDf3eicVysLn2i4ZfRvTrBhcgROnTK4J1owAvpS8dAHv4jBEyJ8IknK2cUMEyrUfoZD
         Xch581Hp5G+MzeFKgYfVuBFxtJdu8fxiEivCml1BdwbDF/mS3sGmdF39zPDqKT12pwuu
         0yeKlhB9hN49U9RINCo0oB88iwtcpmZq+9Va0wjrNEUhqUeOlU/42kGbhZqfoBKVKUke
         CMmA==
X-Gm-Message-State: APuU4Z+0IFWCOC1LWZt/VHqEUTF4gSZiDMcServSzj4+Mm2rjxDTkEzP
	FPvQw2fpj5mSqjsKOiDQI7ogIvOncaHjy89VP2/yoInYaVAdky/zDL/GkPU+GA==
X-Gm-Gg: AZFdTZcM0KiSrrdLxPNr6mbshdwS9A+Bms+Fw+ID9IT3dYOcfggfjt/8XvChrog3SJw
	gZnHuCDE0bKzi9fYMz8hm05VYvvxr97E+zm5tHX0ghNhPyftL3n8rwGE+GP2pbPTkgvccnnvS1L
	kbTy9Tuw+7N+UNKl2rJmpqTJ61VWsnjPGTZX6vXis1Yg9vAHtyyiRp2o7jP8AYEuqA7juh6IgxZ
	MzX128UHKFiYfSPeljfkNvZWbdhf0jguiJWzS82N2PXi/WRRAb7bD7UH0QIyPoJYhNJUHt5hssR
	N+ujaOx8wb6YSkYnTpMSpWF4kBNVFIy7lgJq67JuA2bneWQNmASfXNvOk6QR4RaMAlQO9WE5nwH
	vBGD8O/oMLtbihCAtgcsSWMEytz1LVblToE2ELA9Kwo0cUwusn0OkXKLgZXdExcepEXe4On1aSW
	EZxwVo8R3sKR59ghg5hm495A6XbH5lb26LrNEjkPvdwPmz9BIF7KJJTjJPYTAE/uTPRBb3zG8zP
	ki4TYpQnqO121CmsDCPMRuMEzEmVt+baPf2CEPalLLiNUPkhUUgmCgOLHA21AM=
X-Received: by 2002:a17:902:ec82:b0:2ef:f3ce:1e91 with SMTP id d9443c01a7336-2f03f17ce3emr203302375ad.9.1795665114515;
        Wed, 25 Nov 2026 19:51:54 -0800 (PST)
Received: from [172.17.0.2] ([4.246.71.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f04f6049dfsm87426555ad.19.2026.11.25.19.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:51:53 -0800 (PST)
Message-ID: <6b07acd9.1546604f.10e46b.c75a@mx.google.com>
Date: Wed, 25 Nov 2026 19:51:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1050838279788679547=="
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
To: linux-bluetooth@vger.kernel.org, radek@podgorny.cz
Subject: RE: Bluetooth: find an RPA peer's connection parameters by its identity
In-Reply-To: <20261126-for-upstream-le-conn-params-rpa-v5-1-b7f015a35023@podgorny.cz>
References: <20261126-for-upstream-le-conn-params-rpa-v5-1-b7f015a35023@podgorny.cz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1050838279788679547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222693/

---Test result---

Test Summary:
CheckPatch                    FAIL      3.95 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.83 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      31.69 seconds
CheckAllWarning               PASS      35.56 seconds
CheckSparse                   WARNING   37.78 seconds
BuildKernel32                 PASS      31.05 seconds
CheckKernelLLVM               PASS      35.35 seconds
TestRunnerSetup               PASS      746.14 seconds
TestRunner_l2cap-tester       PASS      14.96 seconds
TestRunner_iso-tester         PASS      13.07 seconds
TestRunner_bnep-tester        PASS      3.12 seconds
TestRunner_mgmt-tester        PASS      88.87 seconds
TestRunner_rfcomm-tester      PASS      4.46 seconds
TestRunner_sco-tester         PASS      5.57 seconds
TestRunner_ioctl-tester       PASS      4.63 seconds
TestRunner_mesh-tester        PASS      4.49 seconds
TestRunner_smp-tester         PASS      4.35 seconds
TestRunner_userchan-tester    PASS      3.16 seconds
TestRunner_6lowpan-tester     PASS      4.40 seconds
IncrementalBuild              PASS      87.45 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v5,1/4] Bluetooth: copy the peer's RPA out of its IRK under RCU
WARNING: Non-standard signature: Assisted-by:
#104: 
Assisted-by: Claude:claude-opus-5-5

ERROR: Unrecognized email address: 'Claude:claude-opus-5-5'
#104: 
Assisted-by: Claude:claude-opus-5-5

total: 1 errors, 1 warnings, 0 checks, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15024021.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v5,2/4] Bluetooth: find a peer's LE connection by its IRK as well
WARNING: Non-standard signature: Assisted-by:
#128: 
Assisted-by: Claude:claude-opus-5-5

ERROR: Unrecognized email address: 'Claude:claude-opus-5-5'
#128: 
Assisted-by: Claude:claude-opus-5-5

total: 1 errors, 1 warnings, 0 checks, 128 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15024022.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v5,3/4] Bluetooth: connect to an RPA as to the identity behind it
WARNING: Non-standard signature: Assisted-by:
#120: 
Assisted-by: Claude:claude-opus-5-5

ERROR: Unrecognized email address: 'Claude:claude-opus-5-5'
#120: 
Assisted-by: Claude:claude-opus-5-5

total: 1 errors, 1 warnings, 0 checks, 55 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15024023.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v5,4/4] Bluetooth: find an RPA peer's connection parameters by its identity
WARNING: Non-standard signature: Assisted-by:
#135: 
Assisted-by: Claude:claude-opus-5-5

ERROR: Unrecognized email address: 'Claude:claude-opus-5-5'
#135: 
Assisted-by: Claude:claude-opus-5-5

total: 1 errors, 1 warnings, 0 checks, 286 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15024024.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1230

---
Regards,
Linux Bluetooth


--===============1050838279788679547==--
