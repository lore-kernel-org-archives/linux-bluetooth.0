Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650374;
	b=dCBSU+Cs8qmCOQieYw6LhlF09W+Zw16uGGoj6DshvvYJCWhsEdtZ+q0TpvxjpUALys2W
	 zYZoeSAfGGDgBrcd5UAkf8HhRqyFMn+sPyxirb8fN6Hz/QL/KTe+9FwjHb0/yzyFaWdg7
	 1SIzl1Jwu9CqfsAaRATRubhbibkm24CjCAn+6zm6+2J9z0CwJe+b/flnsCrvhS7Tt+e74
	 rTm9k1lOvrbH2shCONLrYJvy1C/b8vo9DJLKU9t439n6jGn56MQ+0PPFDzpDLnadTo2wj
	 MhyAOv2eFNAGrIe9MqGZtP7j5NhZ0cIQE8dBUErjZ2aZhqAIWQIRa09OA/lkD/Bfibg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=cLmpze0m03HgCRqnjozNq52QkDIGHME8Cl19PLVTZC0=;
	b=vCvwuyUCxth1+RT+p5u1c4h7f4Y3baLcx7wVO/80x/UH8/sfL7r9iY76XHLIv30afQUb
	 eq9wEhd4O3Qf8JQ0juNQ2jGCjEJAzvlvomXZ8P6ml/sBKNF1Y3tyWceWonJc/eI+b1vUB
	 tniOdqpyR9DMl5L54W98lWTFL90bb8wRlbWBxGuHOh8SNHk9TURuJ7A9+RC2uYW7JFBxF
	 DN7XSGquHkHxSNcgjnjnfOUxoDi5mDpJeTSNlP8Y4C7cwC3QfqE6g7qG0oezWU6WQSzAL
	 WfgSz7pawkUAwxy0fPZf1h0MOUvNbuRC5hb55lJ286uFbj6yGMZC+Lzn41K+FFeaLrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DveYQZI0;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DF0606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 23:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2DF0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DveYQZI0
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-86288992de5so4749409a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 15:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795650373; x=1796255173; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cLmpze0m03HgCRqnjozNq52QkDIGHME8Cl19PLVTZC0=;
        b=DveYQZI00lUolluKynLBlMlItWBYc3vDw0iG24a2f8Ykgx7ulNKSUjnj2iYbL2O5H+
         OcxszWg3MF7R/KXv7akvhwGsv4A5CFqkUMN2z4nxZNio+metvLledN/Jp5p6TjzWMXqt
         l9xbt003yabE8BqW1igtor4t/dE4OfXt4rcB5xhVLeMDBYQs7UyoeGcFtoTL7cTaL2pn
         Aif28Z6sNOgaGSIMtUcgJ3q0Di+eF/neGxGkgkKt3HP+JMmuR/StOgol8s3cR7NfwLn7
         6gIoLvUvCwtuqR2kSnQIcQkeKH8ZcfURLGMmyIWlxh0XPHLStRI6qNqQ2F2o7+GwctKE
         Vq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795650373; x=1796255173;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cLmpze0m03HgCRqnjozNq52QkDIGHME8Cl19PLVTZC0=;
        b=NpIlO2CLk9VYKlyxVv6wpxAnoUzrLtERP8AhKFRIRQlSUQzr5RGoFY5EQ+6MagDBlq
         xa40iSgntwjuJmL0jHcwQg9at7Rt5cz+hP2jspUnW5dXfrpV830u+YHY128bf7fUwBXL
         RQQn99KcPL6ypjmL8+MbNyy2GiUcFoLol950BIz020gqXdZUvC063pSDlbDwbJmuBdjS
         7c5hfcwbiiHJlbCDu1mn6VHszq5adTFmE5zUfOZ76ehU57fI22lyxopWQPYqJTh6cK1p
         4fnjgEMBV6/uxbllZOphZ8zOFBf8wisf70BFqu8ZOvR0A4Kp9qcV363+jPJHTQUj5M/O
         5pxg==
X-Gm-Message-State: APuU4Z8J/fjgHW+l1rwGoW91PQ3cEiV11S/BmMMMQuJUARKgK26N1ceo
	7Ky7f8YSzqxBkROnOeO3Bz4Sm7rrlquN5SYFk/2o01b+ehYKmHIDSoOx5D4iWw==
X-Gm-Gg: AZFdTZfLjHa/kSHHLCFW+Bu2N3p1wqn9l7Nohj8kOciotsHmdERSUBEpR9hVa1RkCz/
	LPafwGvkVi96wnRnTec6WK8zmy0LslhB+odvUE0Q+BuXG4Chc7t5OM/6h9lzTz8mA54A8RxWPyC
	2Kk/SGEqTfHoGZn8GJnihhgXK+CjlSBE35V1xwv13/WCoBZ9tDiCK5BtCL2HD3Th9n+INeYHmnH
	SQ5zZKamQEhH0yJTHZ/R494w7Vhfyt8Ytn/6CEvuf6YOSjxnFzsZ47hQDCYtfq5PI76Tlqg6K2F
	BKC/mMsH+K9Pj9bHFg0gtbtGdEJ8f1KyDAdJAe+h7Nf9tFx/E1RyMrbL+pCWFommk2xgLjIGi5c
	DjzB6gXU8KPEE/9wdsDd5/RGSNxM/XkIQjJ9OH+z6h8kXnfziBA2GoKYzQX1dYfXR3Gd0eCiYOP
	rCrI8nbgTMgsPxp0MXCkrhSlsllldugVijqt9CWYHYzdl3dTNIRiheC41UtdlpSeuCNq+TVuxa/
	3DJWyk+5Zf1ExJldUfUf5wBl3t1eQd5nEHZ0yV6ofHCvIEfkSqEnJahmu0qL0xy
X-Received: by 2002:a05:6830:6413:b0:862:c617:3f42 with SMTP id 46e09a7af769-86315633593mr15760468a34.9.1795650372883;
        Wed, 25 Nov 2026 15:46:12 -0800 (PST)
Received: from [172.17.0.2] ([64.236.140.195])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dd6d8sm13742914a34.10.2026.11.25.15.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:46:12 -0800 (PST)
Message-ID: <6b077344.d47d8cbc.4c082.ff2f@mx.google.com>
Date: Wed, 25 Nov 2026 15:46:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5748571963522009958=="
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
Subject: RE: Add tests for security of deferred setup
In-Reply-To: <20261125211200.1955466-2-luiz.dentz@gmail.com>
References: <20261125211200.1955466-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5748571963522009958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222577/

---Test result---

Test Summary:
CheckPatch                    PASS      3.05 seconds
GitLint                       FAIL      1.80 seconds
BuildEll                      PASS      20.15 seconds
BluezMake                     PASS      293.41 seconds
CheckSmatch                   WARNING   303.74 seconds
bluezmakeextell               PASS      96.59 seconds
TestFunctional                PASS      1181.74 seconds
IncrementalBuild              PASS      336.92 seconds
ScanBuild                     PASS      1080.72 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v4,6/6] l2cap-tester: Add tests for partially accepting Ext-Flowctl requests

1: T1 Title exceeds max length (83>80): "[BlueZ,v4,6/6] l2cap-tester: Add tests for partially accepting Ext-Flowctl requests"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:713:28: warning: Variable length array is used.emulator/bthost.c:714:32: warning: Variable length array is used.emulator/bthost.c:967:28: warning: Variable length array is used.emulator/bthost.c:1001:28: warning: Variable length array is used.emulator/bthost.c:1002:32: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2928

---
Regards,
Linux Bluetooth


--===============5748571963522009958==--
