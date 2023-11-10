Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5957D3C68C
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nduWFAa5"
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B5B4205
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 13:36:06 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso2028550b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 13:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699652165; x=1700256965; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PMXg9oGiAlF45ofTlP0WIOo+qkt+8jlhsy318P6u+GU=;
        b=nduWFAa5zFhhkpaIssh5F4gZecRXUduUofP15jn1OHoMA47p8L4OPMLYqBGitGPj96
         UJmV35V9FHI3Mk6GMgFInF2Tft2Vzu83f+DcPd4r58ACD2jsV4cf+fYU2MMwESBI8Wfo
         XvUbHcWQHCJJ6CTWnjNkV/Z2J5y6mZTLmb5vXjcy0wfpNKEMG7AQSwgMDPkTrSQkIXC5
         Oh7VLmse+nVSI4HBRN3mIgwhEPazF/p9gRatqHCB0f5dpkruY+Ht/VrEN8bWtGacM3af
         kpZ+2aWPK66xy/UJwtiEnWTnRBfqklewRcZiS0JX4tVEhDfkJEqLYvtMgIDEmILijwW0
         HK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699652165; x=1700256965;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMXg9oGiAlF45ofTlP0WIOo+qkt+8jlhsy318P6u+GU=;
        b=bajk+B4jqaXyzyKGPuT4WIbG2gtBkqDaqkdLFvT25rHtAC1FyQiFEAMY/rMGcNT0gi
         6fr0hzO/Z8NzlTMVBINHSzTTJQ2gQhOFYT1ldz56U0zD0f09uTIKgiDXcsl5ur7yCaDQ
         AGlrx6XgHCGu5ORiDFV8+5rJFQSEM9guNxZpZTVsDE3IKFkAUyuVmN65/LLdp9y5L8RD
         6kxslOjAGQpu1j3obs0xeeOY/LxLEhc7lXjvUSHDLgu68AcXr79HwUKQo8bp3MjgaVl2
         xNjGYIdE+ORnRQ9IGCEa1DKbcCcLLUVdnHvyRSSslEbuPENzDx+k9qz5H/LK6pf5RVTR
         1HVA==
X-Gm-Message-State: AOJu0Yx38WyAqW4eJR5vo70Vb0iKVhXCVlALJrcLmdSq8h/9EDGRDlR9
	acNXesXLYJoflRGzmCKdxXxMQYw/0BE=
X-Google-Smtp-Source: AGHT+IGFTuFBWgeUFYnylidlsTNzyivlM72ah0y/m5rorite3emCEcTcISBdBRq/aVFv94Sx+IEjZg==
X-Received: by 2002:a05:6a00:8b8c:b0:6c4:d4b1:b535 with SMTP id ig12-20020a056a008b8c00b006c4d4b1b535mr5215079pfb.9.1699652165214;
        Fri, 10 Nov 2023 13:36:05 -0800 (PST)
Received: from [172.17.0.2] ([13.86.156.33])
        by smtp.gmail.com with ESMTPSA id b13-20020a056a0002cd00b006bd8f4e398csm158866pft.135.2023.11.10.13.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 13:36:04 -0800 (PST)
Message-ID: <654ea244.050a0220.6b207.09bc@mx.google.com>
Date: Fri, 10 Nov 2023 13:36:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6058703760615680461=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] bap: handle state transitions with old_state == new_state
In-Reply-To: <5c65fa8da174de15074310ec368f537c717ded43.1699646238.git.pav@iki.fi>
References: <5c65fa8da174de15074310ec368f537c717ded43.1699646238.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6058703760615680461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=800308

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       FAIL      0.52 seconds
BuildEll                      PASS      35.07 seconds
BluezMake                     PASS      1196.96 seconds
MakeCheck                     PASS      13.47 seconds
MakeDistcheck                 PASS      218.17 seconds
CheckValgrind                 PASS      333.14 seconds
CheckSmatch                   PASS      453.58 seconds
bluezmakeextell               PASS      145.57 seconds
IncrementalBuild              PASS      1064.96 seconds
ScanBuild                     PASS      1400.66 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] bap: handle state transitions with old_state == new_state

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
20: B1 Line exceeds max length (108>80): "src/shared/bap.c:bap_ep_set_status() ASE status: ep 0x604000039a90 id 0x01 handle 0x000f state config len 42"
21: B1 Line exceeds max length (118>80): "src/shared/bap.c:ep_status_config() codec 0x06 framing 0x00 phy 0x02 rtn 2 latency 10 pd 4000 - 40000 ppd 4000 - 40000"
27: B1 Line exceeds max length (90>80): "src/shared/bap.c:bap_stream_state_changed() stream 0x60c0000334c0 dir 0x01: idle -> config"
32: B1 Line exceeds max length (145>80): "profiles/audio/bap.c:ep_register() ep 0x60d000006910 lpac 0x608000017520 rpac 0x6080000183a0 path /org/bluez/hci0/dev_C9_C9_76_21_08_4F/pac_sink0"
33: B1 Line exceeds max length (128>80): "profiles/audio/media.c:media_endpoint_async_call() Calling SelectProperties: name = :1.604 path = /MediaEndpointLE/BAPSource/lc3"
35: B1 Line exceeds max length (92>80): "src/shared/bap.c:bap_stream_state_changed() stream 0x60c0000334c0 dir 0x01: config -> config"


---
Regards,
Linux Bluetooth


--===============6058703760615680461==--
