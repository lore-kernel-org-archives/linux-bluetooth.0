Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699328;
	b=L4keioPjtUZD/zA7Fb6u+dY4HNWlyT28qdDVkc2DQU+Th5ijiEhxKmAjBxc+IJVm7KFl
	 2Rol7ZG/brJ9xPr+ZJ7FnD11ML+9KFXmbbcgBSd0Aef8ELsF4zmTo37Hd8dIDtLufWIoH
	 t6XQN5CqFWBqbXlWd//YRIcBzTK1YLLwupIoi87wI0UGabBYZmehnBkN0bPhw1JM3mJRu
	 FEGXXhwipQdVegSsJvGqdwxkw+RkRy39nxr+UhppVETPcfmulntc1QPkkpI+g60iqSzGz
	 2HuHHHFENX5wwpDcMrRYeu+u7dx8FHQHIoSTC8DgLPev80eWWvo/cF2U+cfd1qOUo/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=6UpnyrJCBBnlr4q+a3qajlauIpjxQtOrXOYlU26TRm4=;
	b=t6woB1K57ULgEOVVUZgqjYkmuRYcLqb1ICZB55fK4qyW7z10M3wacKbwvQxPwcyWPrdJ
	 iqx7OKXsmpKl/rXHj2ijfpov/PDbkCwj8xaN05VhaN0CTQmzRr5MG72O9ckaHgmsLVouB
	 Lzl22VVTkmRkxLodK+FTY07KLnJWFz+aqFCnvS5tL/gzPpV5Kp19o4jxgZjaJkjaTULNG
	 BlLYGW8jDXB2coJGavKaTq26oPWkbXmLUFcGbfyqdFytLUMy3M9MNNlEC1qsDHSBlJ2zA
	 G8hnI2553O3XJUnPYkXBJFEg1QqY4Y5SV28gMk78OhnDVpqpvjAEQvB8LE40GfSAL1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KBYiudQW;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4A606A31D
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 20:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CF4A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KBYiudQW
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93cc1ab5f6cso16996685a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792699327; x=1793304127; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6UpnyrJCBBnlr4q+a3qajlauIpjxQtOrXOYlU26TRm4=;
        b=KBYiudQWP5N4khNj/0oS5t9+NW7xzgF6lEccQuQWG93wFHQeDaMHF7h+GUvVIuGtqs
         8fKpbDelSF+fIj0WUwGkxkENSH8luITKZYd/Ih1K4aWSBIpxegzGDTnkZySBEqQfzCyw
         N1WgR8iqgVIUQyMpMGxP9y873RUankm2sLBTY4Ay7nCzocLdlN/iQmnlgBTDP/fxSdcH
         T4jj69QZvc4wd4u6MfB1CK+jEMTkba9zMP7bDg5jjhUWExioiZt2ELtuRrXZ4uRVpkr7
         BX+KfhJQf3TgbCd0w9sVzojKfOvqSgOHjIv29bR3euly5Sh6uIXTti4tChH87ZrnLi0u
         Tnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792699327; x=1793304127;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6UpnyrJCBBnlr4q+a3qajlauIpjxQtOrXOYlU26TRm4=;
        b=T9qAFFXtLc32IMSI2/TySnvoT3s48kpDAh2XdYAufg6aQ924oSbYaafKC+u+d5wajW
         jQ0vJ0nEjUTi6CDhs9FAu1xjc3AMI7o3BbIfq24FxV8cimME5S8VBPIpzEitIWbbs4TA
         5+cygNuGlrYIK5bRZLDC4pM408O7lwTYAxmuI963goYrvBm+Fh0uIys23Y2xXVb3AHXC
         f3g/E1w7DTDylJA0RX7UGMGoCW7QvMweFXrF/Ts249VMPV0jZUbjzTpi6LdpfrnVNqx7
         lbysUedQcCOXcI3V6FybaZnWyCPrdWYluEicseEwf8YKQy7DMcRlddOo0FU19r5PgyIe
         TgdA==
X-Gm-Message-State: AFq9FYKHuT5sn/Ac0mwd8008vCwQ6of9w16oxkuObIav4R3VfLASAfxz
	kHYL2ydbooElNypHfaK0ay6CLr9O4/dTpPy+rpGONAYwbOGXWTREE+ogcWGLDA==
X-Gm-Gg: AYBFou1HeHi0uXJ/Bi0qi/1Yi4NIp0imLSyBW9wdiW1KHoAT//F1qzV9iLWgavWeLtF
	6tdMkI9yEzQdloQm+ZgYtG3d9Kq2yV+w7Zx8Cn42eAQfMzps2hFjilsTF/aiGvLIAX9uG1hFlFr
	/QnDjDuJU8/aRpgwD0w7sdRvoBM1A8EEuaDEnwxu8s7c8ylx9uIUrbkEvaYIg2XZp6XgAxODVxk
	2kQVqQV72hay7erRaUKxc25TSjBXF/aqtLTtBapuuuIoiyE8J7JXhQfTDtwru/S6PSYsH1UlCaU
	Lih7j2h4usP5DTohjSzqnNiTM4KlwXCH+wyA1fmYA3cwkEi60DuwpL7kWbgSglT1MPijdZv3M06
	t4E1YV2tgjMxFrsSi2uP3APvLRIZO6d/vgva0Da8+rySdsjNcYlz5jc5ohynH81Ax506Jq0MS8A
	eUbDZ11r76Vp4R+dE8xhiC8B7gJCJEkHsEyzSn8zhJJQDsouKoy0N761/XHL6DtxMdeItBxPfGP
	j6Ew/NDl4DjNa/N65tAcc5ZnNNiL+6h1VUC0Em7RaPHXlQ5/c893wdC1b9AcCBRMw==
X-Received: by 2002:a05:620a:462b:b0:93e:5cf8:e5aa with SMTP id af79cd13be357-93f6f9b885cmr92838785a.61.1792699327394;
        Thu, 22 Oct 2026 13:02:07 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.223.101])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c39505351sm1318706d6.3.2026.10.22.13.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:02:06 -0700 (PDT)
Message-ID: <6ada6bbe.edc255e2.1a3c38.be1e@mx.google.com>
Date: Thu, 22 Oct 2026 13:02:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4546929441923071726=="
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
Subject: RE: Run the testers under User Mode Linux with time travel
In-Reply-To: <20261022154701.3959500-2-luiz.dentz@gmail.com>
References: <20261022154701.3959500-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4546929441923071726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1191414/

---Test result---

Test Summary:
CheckPatch                    FAIL      18.23 seconds
GitLint                       FAIL      9.50 seconds
BuildEll                      PASS      19.55 seconds
BluezMake                     PASS      301.82 seconds
MakeCheck                     PASS      14.53 seconds
MakeDistcheck                 PASS      144.54 seconds
CheckValgrind                 PASS      237.04 seconds
CheckSmatch                   WARNING   298.70 seconds
bluezmakeextell               PASS      96.09 seconds
TestFunctional                PASS      1154.77 seconds
IncrementalBuild              PASS      635.83 seconds
ScanBuild                     PASS      1186.64 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,11/27] emulator: Add vhost-user backend
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#258: FILE: emulator/vhost.c:87:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#263: FILE: emulator/vhost.c:92:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#272: FILE: emulator/vhost.c:101:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#279: FILE: emulator/vhost.c:108:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#285: FILE: emulator/vhost.c:114:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#292: FILE: emulator/vhost.c:121:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#303: FILE: emulator/vhost.c:132:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#310: FILE: emulator/vhost.c:139:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#316: FILE: emulator/vhost.c:145:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#321: FILE: emulator/vhost.c:150:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#327: FILE: emulator/vhost.c:156:
+} __attribute__((packed));

/home/runner/work/bluez/bluez/src/patch/14908110.patch total: 0 errors, 11 warnings, 1094 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14908110.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,12/27] emulator: Add vhost-user virtio server to btvirt
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#368: FILE: emulator/virtio.c:48:
+} __attribute__((packed));

/home/runner/work/bluez/bluez/src/patch/14908117.patch total: 0 errors, 1 warnings, 491 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14908117.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,13/27] emulator: Add time travel calendar to btvirt
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#474: FILE: emulator/timetravel.c:54:
+} __attribute__((packed));

/home/runner/work/bluez/bluez/src/patch/14908111.patch total: 0 errors, 1 warnings, 1088 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14908111.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,14/27] emulator: Add virtio console and time travel client to btvirt
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#345: FILE: emulator/ttclient.c:43:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#737: FILE: emulator/vconsole.c:60:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#743: FILE: emulator/vconsole.c:66:
+} __attribute__((packed));

/home/runner/work/bluez/bluez/src/patch/14908112.patch total: 0 errors, 3 warnings, 1221 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14908112.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,24/27] tools: Run sco-tester, rfcomm-tester and 6lowpan-tester on the mainloop

1: T1 Title exceeds max length (88>80): "[BlueZ,v1,24/27] tools: Run sco-tester, rfcomm-tester and 6lowpan-tester on the mainloop"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/sco-tester.c: note: in included file:./lib/bluetooth/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth/bluetooth.h:237:31: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2701

---
Regards,
Linux Bluetooth


--===============4546929441923071726==--
