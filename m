Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922376;
	b=duG9PfRWM6h2fDObObiIIUCTYhKQdygKIeqDnCuNMlX3ag82pMgzSixcfYcisAMbzjQ/
	 V2pfoDIBfaKIaXxSMVEmXUqyhdo1JDcwHB3SMApMItRhyYjmvxE6WmXYnn2qFN2vtyDRh
	 1ybRVKwpP/Lmln8s9Tl7OAo4VqQJYw3SsyUtvJVE5TBN69PaHGISH3gHROfgzRa2IlSol
	 vTsEyk9SOtDjtNAl74sjfKUa0syAnW3E8TPKrOqmQX1rSEt9ZqnQ3O+mJri0Y66Inplox
	 KMhRNPBD1oVyl8CLrtPqVxV1JA4ioDp5vUTjzM5Nfeb9Pb/s0XplJGH80f2S9GIVipg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=7baA2rtL7kM4sGnECdCuamhsPyeLyCE2si/52aQLWzQ=;
	b=30EIalj5rWwsgGzdlaWIb45j+SrKlsGajPvaP6K6702nOMIUedp/OVpdUZ5BjYKa1Psv
	 3mC/tIkcx2/v295Y4fhj4dznOnvxOdNImK+iGZLYYIcrZbOIcJ6hMAclWoVLxwUZo2qLK
	 ZJflDvSkUTQ3QOir4TNi1YOfdLKsO8ccE1Wg12Yg3UIVZxKz5XmNEuofoxNbiA0tJ5sXK
	 cnjegm5G4/hMDu+INnWsgtu04mXlSa/qIWDmCrvxmHjl21wLWPFvi7Y+yTyrFl32JRG55
	 Vtfm3gJ1nqcEnvtU+7+xh/K1i4Jstr42apCXoEFTKxvKOXztq5XFtFb9acIg5H6lwow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YQeJbb0Z;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9D606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 23:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BD9D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YQeJbb0Z
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-85a5455bd3cso75733a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 15:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793922374; x=1794527174; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7baA2rtL7kM4sGnECdCuamhsPyeLyCE2si/52aQLWzQ=;
        b=YQeJbb0ZcSra9Z/jzSBvwGKtHdv++/5lfIOmVevZbWIdrExg0vIpvEKYlfj2RcDoSc
         aSLIUSPp+/WwQNbDPEb7zrf+BLB0sY0tC45MyejULGawDJj2UbepRwR6l8Y3wQoMk0pn
         xI7NCsylDyjFF1y5E9HtcfhrL+4fTrkkcfK3YCNSXWL+q/0cMPXn6LpRCZoB1z8fbBkI
         +rKzOew24EVWaTFZRJj8Xm/eXm+5P6W89Z7iL29UNFeppmjDDe+QHcovQ+nHxNtP8WpZ
         r6fvDu8QWIPMNwVwz9Z6TkSfM2id/Q89LdSUNuPJ6yF3K+ldbWB4PIBFYVnddfIoVV2d
         SmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922374; x=1794527174;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7baA2rtL7kM4sGnECdCuamhsPyeLyCE2si/52aQLWzQ=;
        b=XohrrBhsqroyMxkCoYEf6/CJooc6/WfdTnapF4i+H08sA0gPyZSsB3zC/OAEAdc5vn
         bxNJdANfCE5Odj7dXeCO748NcTSmek4MCuzJmFMxdpiDjK5E2jUd8t7r9M+Q4AV6Dp57
         zCEMXdoHGD7+C3jVnwlIt8uZMq/k9GKS+12qQffWLb1VynPWd2qQBeGd1T8+Qu0m6gn4
         qhn1AzJB9TTHyVbb0d7mUt60nyQhpnHmMwvEhzoBArpH+GbpNzpxP3e/9IeQphHsse6N
         GQH/nQRcWfR+hYurnT79Z6aHM6fTKQpVbumsUYRXUZAGnZz+7OdvCfuj27pWreGqcWiR
         pscQ==
X-Gm-Message-State: APuU4Z8l1IIH7YF7nFb1F+oIgdqKdmMMDK+9FC6LsfjPeZ3SNvP5NZZ1
	7JaVKcRNezwwivR5vgRMdflgMThBJzh8RWa/Hsb3VgO+aICV/zo2NuvjZFjuRg==
X-Gm-Gg: AYBFou0wTeGQWdmyXXY27or6kgg/SKSLR32Pcr5b6N11GF2uysta0pGdoU9XETQR2Q1
	dnKWzdVoWZ0rXrmcnVnU8GDiD4EYmfmlHlm2gN5+Q444XVFq+eNaHbe2wIDYnTO3G+HFNBMefyy
	ew70GfU54DnfJGH1fm0STqiPxDbIWqLx1xQRT0G2rqa//Z750/KyANC/bmO6Cz7nK/nFUnT7DeZ
	t9cuiiECHzIwPDQmjcptV3ZghPt4wWQFsTT6y4deoVzhW6ZsviUZlY7Lz1gTjNZ4Ixktjnt2cjD
	721lMhrQCMwv1DNHERXrEWxGc7LjfQTzHMwmCVFhM1AlZBt8k/7T6QbrNkcPqg/9qFnEaMsmj5e
	zcbq5o4F/0CI+vTxtzwXWtyYGkSyA1x3Av6RQDnU1YvPnCWV1t2NVnwRs+Kfjg2qYFo6hZCfVwI
	C3kbQCYL/r95k8+Bf5AqbSvJMSHtLytdIThy9fL6m5sFp3DqZAEafIlljWAGqMd2WzpFWHq4vma
	OU+n5A6SSRWVCzLhEijGI7RBIDKLttBuR/DHUst4XwtRP9xYb+U1qRn+vhVyAZK
X-Received: by 2002:a05:6830:6815:b0:843:cc20:9d03 with SMTP id 46e09a7af769-85f1cf43d24mr905031a34.6.1793922374517;
        Thu, 05 Nov 2026 15:46:14 -0800 (PST)
Received: from [172.17.0.2] ([135.232.193.33])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f1d951a8csm635448a34.3.2026.11.05.15.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 15:46:14 -0800 (PST)
Message-ID: <6aed1546.b906deeb.120ef5.a084@mx.google.com>
Date: Thu, 05 Nov 2026 15:46:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4357753014150550392=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Add support for HDT and EKS
In-Reply-To: <20261105171229.2053802-2-luiz.dentz@gmail.com>
References: <20261105171229.2053802-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4357753014150550392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1203383/

---Test result---

Test Summary:
CheckPatch                    FAIL      24.26 seconds
GitLint                       PASS      3.59 seconds
BuildEll                      PASS      20.95 seconds
BluezMake                     PASS      314.62 seconds
MakeCheck                     PASS      15.44 seconds
MakeDistcheck                 PASS      164.89 seconds
CheckValgrind                 PASS      364.64 seconds
CheckSmatch                   WARNING   387.23 seconds
bluezmakeextell               PASS      101.95 seconds
TestFunctional                PASS      1209.23 seconds
IncrementalBuild              PASS      826.88 seconds
ScanBuild                     PASS      1206.63 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v4,01/11] monitor: Use __packed in bt.h and its users
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#230: FILE: monitor/bt.h:16:
+#define __packed __attribute__((packed))

/home/runner/work/bluez/bluez/src/patch/14954491.patch total: 0 errors, 1 warnings, 4719 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14954491.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v4,10/11] l2cap-tester, iso-tester, mgmt-tester: Add HDT tests
WARNING:MACRO_ARG_UNUSED: Argument 'name' is not used in function-like macro
#414: FILE: tools/iso-tester.c:954:
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \

WARNING:MACRO_ARG_UNUSED: Argument 'setup' is not used in function-like macro
#414: FILE: tools/iso-tester.c:954:
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \

WARNING:MACRO_ARG_UNUSED: Argument 'func' is not used in function-like macro
#414: FILE: tools/iso-tester.c:954:
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \

/home/runner/work/bluez/bluez/src/patch/14954497.patch total: 0 errors, 3 warnings, 2922 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14954497.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:707:28: warning: Variable length array is used.emulator/bthost.c:708:32: warning: Variable length array is used.emulator/bthost.c:961:28: warning: Variable length array is used.emulator/bthost.c:995:28: warning: Variable length array is used.emulator/bthost.c:996:32: warning: Variable length array is used.monitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structuresmonitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structuresemulator/bthost.c:707:28: warning: Variable length array is used.emulator/bthost.c:708:32: warning: Variable length array is used.emulator/bthost.c:961:28: warning: Variable length array is used.emulator/bthost.c:995:28: warning: Variable length array is used.emulator/bthost.c:996:32: warning: Variable length array is used.src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2766

---
Regards,
Linux Bluetooth


--===============4357753014150550392==--
