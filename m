Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1113BE621
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454514; cv=none; b=A2ac3OzPds5RgNpiTg3/u4UcS18UKV+Cq/td+P2CzRJGLad5MkneXYcgoC9dmEzfIpDeglYPz3fUQRgs0MhCMneiXOgEqs13MzYBWW6W4vgqrjaVQYuowQ8PMHRnSkZ1Phf3rioLeOnb1JDUUefGISYjBIgdXmZOzhVR+J+CpQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454514; c=relaxed/simple;
	bh=MPMKIvmQpI9I15hjBX+iy5Ghvp/7y+cB+lW5sps7o6w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QU3q9XhFfLNwqALYmaIRnU5anDPAayimLZM0/+2JWwx9mu30mRBMwLH9A8M697IqJUN2davV8EieO0fUSpCLXQ5BGuOoOa3Z5WoUiBuUKFJ6z9iHeh75eZpJLC6kQVzpjLrvkwd7s1rPWYYf+aaKhloD7iskMnQhuojUfVs2QQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwsRU0hc; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwsRU0hc"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50fb8e9a4edso94070031cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 02:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777454512; x=1778059312; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8DfAOExauDFsCZM1N7RoDqq2XLySnu6cRPg2LakZ/gU=;
        b=kwsRU0hcwbeATdxlc5nObZLRReK7B4fN4BnjPbIjgeU3gYj64FgQHv6P6bcL0s5DXv
         u3harRYUxFWerlL00HZXBIAbTLrXFMZD/il4q5OZzdugh/Ix3FQsXYDp07XlqtSZaNuM
         AWOZvKhD7RM1H2060uSu9erGfY4/bWqHeXfzouGXM2qzgfiYeRtAuIgdiK7S0nw+fQB3
         V1wKPmRai6Ufoij49p8r1ODGazCxABj6mKQu3zTqks8X1XfqJk23UlFehFcEQKkDH0Eu
         YaIk8tsNTrGZN22LKAN93srBVEHQ2INsPqe9ZJBL6+TWlMSvvB7UJo/VmYAOrhuETz76
         RTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777454512; x=1778059312;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DfAOExauDFsCZM1N7RoDqq2XLySnu6cRPg2LakZ/gU=;
        b=bW9U5MZw1vcjkJvTh/sh7OWIiv8iQ+vk3QvN8e9BdXNaBfYJ3e5L/+zeSzVIu+GaJ+
         ZHW1RBXEq1mTALv3KpU6Hmn1CHd10mOhMSM2F4/aBgoXZZOdvBZpeqB0zeY0HvVRcozS
         91FAbJc/r60uE3JZV8tqRoA6hJrjzsmOAY+Ll5isqzqMxavM5PHnvM8Zc8kvJdbIdaWo
         oH3P2mB6wUWXXfuzmYJIOlxnxQQFmIWx5tnDFNWMhxWRNV7DMRuqsYnWUluxJR2mk0Mk
         s5EwRbax9IZcinRk98zZpaXn28XBj2na/PNICXg4BXtO0C9h9i4t7V5kBdlN1bBiYfYC
         oyXw==
X-Gm-Message-State: AOJu0YzTozgAid5l/QCktFxmePe2hZbNq1UrbKtu7T3zRZlmGHOyHi60
	qWQMw1QDGnR0udgHuuDReXwAJpjxx987TeJ/jzd2tSA8uV8/eW0Fv+ddp/xBFQ==
X-Gm-Gg: AeBDiese2JU4hq1a8fmDnQqOTLqmofvW6JEoWXi1IaV2sHtVxO4nYWQSH4AqHSlVWLO
	3S0p3kYyXyp0QbUNVujSJhoGRK/VDJW2qsJDWmXjhd5XLYNyYFIDXkWTRyixy+y70XIs8yIwt0T
	6lGeAHplUtP0tDb0MKc42jbCxZ773zEEmWXoFPj7wmU4YKGzi2+Ubh49Hc1rVjtDuxS5KFBwIiy
	tRc3gywvtQIri70OSUTBo5hkqCpcwK2M9d2+r/UrRD1DGlQsbk7bfbFFGiJVkcRk934KLHBSrzp
	+XoVvDVy3byZd2krSxSJN7HwL669D99ty6SCfluGNV+KrAS9YuUR+7hZCtuRDuwNZvxMKA35OH7
	Fxa6vwgRA3jq4xLN95DMYs/a/LGj2/RlaoB8M8oHBMpKfER2B1fKnUZIi100ui4ddINDZnFmLXB
	R/wrkX6+c3UvlHZOn5uvIKRy7kbC92kTHuq5JLeAdXlPZmnYlddsXX
X-Received: by 2002:a05:622a:608f:b0:50f:bc91:709 with SMTP id d75a77b69052e-51018a4804emr43846651cf.39.1777454512236;
        Wed, 29 Apr 2026 02:21:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.246.217])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5101ae3c0b9sm13904201cf.19.2026.04.29.02.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 02:21:51 -0700 (PDT)
Message-ID: <69f1cdaf.050a0220.1cb51f.425c@mx.google.com>
Date: Wed, 29 Apr 2026 02:21:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5256557493227407727=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raghavendra.rao@collabora.com
Subject: RE: client: Add public broadcast advertising support
In-Reply-To: <20260429074605.11774-2-raghavendra.rao@collabora.com>
References: <20260429074605.11774-2-raghavendra.rao@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5256557493227407727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1087302

---Test result---

Test Summary:
CheckPatch                    FAIL      1.13 seconds
GitLint                       PASS      0.69 seconds
BuildEll                      PASS      20.11 seconds
BluezMake                     PASS      648.01 seconds
CheckSmatch                   PASS      348.14 seconds
bluezmakeextell               PASS      181.33 seconds
IncrementalBuild              PASS      635.58 seconds
ScanBuild                     PASS      1013.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v5,1/2] client: add public-broadcast advertising command
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#198: FILE: client/main.c:2923:
+static const char *public_broadcast_arguments[] = {

/github/workspace/src/patch/14546142.patch total: 0 errors, 1 warnings, 137 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14546142.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2083

---
Regards,
Linux Bluetooth


--===============5256557493227407727==--
