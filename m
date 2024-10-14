Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41561157E82
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894308; cv=none; b=QAUBDCy1PAyLNOyEjRxXMhL8hnMcQi9GBBROJfdFeLQP8WMCwAaJ2RvLzU6U5onK8io/O6cBVwTJwNC04lAvRsPLWHsALFlcJg8YN1f7qh5ctAfclQOCR3LnreW4GbDn7VRInZZlg0K0zJQYADosmjjfOh1gbavV2J5cmNQHkgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894308; c=relaxed/simple;
	bh=mFUdrRZLqIfa3TppofV28O9BNfZVCfFdvWKPsRHinso=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WOLZ13eAy5MBzczhyDMyJWZmK09QdDc3JtbpmOWodDlkaKxtf5BEo8zOZ5/hB4HnUT1bd3seD6mGvOAuS3s/xcXXpZs3XEQKuETR5rNLHklyatBSRL7YYVWS1gOmsVOpe7ikTMbpDsIYZxl2JeavdHUCNAbDVHgy3GvsqbMWHTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h89N91M8; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h89N91M8"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4604b48293dso24962991cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 01:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728894306; x=1729499106; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LoJCDmDGOzS84dFeME168vfSVJ+yrRYzPSnphs2OWMY=;
        b=h89N91M8UiGIVVm5/wVZ6RHUotly3wC7srIqk6T87urAmGHFo8N8SJhd/+yNzsai2d
         0o3N9+aDlr3tzeUuS+ePb0sYk2nsXNUoKo+17rxrZhFFB7AH4R9AMDCRBLFvjMvz1tDm
         5sIQf+Qgkyq79HnbVGh99Ph+amscis452pdMArpe8Amf0q1CfwIA5GqyZw6NhO9AMpRG
         8+Ikz+PhljyQJSOOdfqnjZspZOydval0k1R1oFK7LsTlDoBlWYq7ZnVEXmhH11AQxnv3
         M2U2vlljzok7kPBhNePnxbqGUf7XvsSdbPS/I8C5Uf2N9LLt6MROUHkSQ7g4Bs+QtRdY
         5TOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728894306; x=1729499106;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoJCDmDGOzS84dFeME168vfSVJ+yrRYzPSnphs2OWMY=;
        b=r/90zMu6UT1mKRMKY29IvH6OwhhUbPG4IlQLF2VDKixFn89CtCeMFhyA1IwW9WRkwo
         DH8M97wnoqoBG7QgVmbIDlISRA8hnk2Y3CC01RESLIJ8vd10lhYHbR7/6Vxj576JaKL+
         CeqiD+fow4GNso+xGB4DaqGo9MwEiTxQ2V1ocBUk0ZRwTcycDPO76OZKPMkGuMfQLjRV
         n6Xl5RiRChFBXLnWBzx+AH6hay1nNqSsltjJw2GmOUC/F/8Po+8VNRaX+0UFBl6KIXGB
         q6XyWajZmjxq6bJbkSmluBXXjtIkyhTK+qXp1q53ytGK7rO/5nJNvSE/gokTB935taIs
         p8xg==
X-Gm-Message-State: AOJu0YzJHoWCKA7C2FHptlBB3Bqo3bqth8aQ7oV2NyZK48Vnx4OxcTN8
	69E/++gHJSfrQAsL/NXieCWXR5+SvKIImdXgaKXbI9UYxCsvz6/NOE/JzA==
X-Google-Smtp-Source: AGHT+IE+BWJ/jxIrIR9QjRgxxry8NXFNVUegePC80gKSYmVbwgluLdGCa0yfp77Nh7KhfcWHH9th2A==
X-Received: by 2002:a05:6214:2aa2:b0:6b5:1d2f:1d3 with SMTP id 6a1803df08f44-6cbe51208camr225505126d6.0.1728894305879;
        Mon, 14 Oct 2024 01:25:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85da27esm42608076d6.60.2024.10.14.01.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:25:05 -0700 (PDT)
Message-ID: <670cd561.0c0a0220.76a70.bcc4@mx.google.com>
Date: Mon, 14 Oct 2024 01:25:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1730672354861042100=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tot0roprog@gmail.com
Subject: RE: mesh: Fix segmentation behavior of Lower transport layer
In-Reply-To: <670caa89.a70a0220.5edfe.2cd5@mx.google.com>
References: <670caa89.a70a0220.5edfe.2cd5@mx.google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1730672354861042100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=898694

---Test result---

Test Summary:
CheckPatch                    FAIL      2.54 seconds
GitLint                       FAIL      1.68 seconds
BuildEll                      PASS      24.59 seconds
BluezMake                     PASS      1652.70 seconds
MakeCheck                     PASS      12.95 seconds
MakeDistcheck                 PASS      178.11 seconds
CheckValgrind                 PASS      252.05 seconds
CheckSmatch                   PASS      357.87 seconds
bluezmakeextell               PASS      120.03 seconds
IncrementalBuild              PASS      6218.53 seconds
ScanBuild                     PASS      1016.20 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,4/4] mesh: Add features of Segmented Control message
WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#749: FILE: unit/test-mesh-crypto.c:1090:
+			seg_max = SEG_MAX(false, keys->segmented, app_msg_len + 8);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#758: FILE: unit/test-mesh-crypto.c:1100:
+			seg_max = SEG_MAX(false, keys->segmented, app_msg_len + 4);

/github/workspace/src/src/13834162.patch total: 0 errors, 2 warnings, 602 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13834162.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/4] mesh: Implement lower transport layer for segmentation and reassembly

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (84>80): "[BlueZ,v2,1/4] mesh: Implement lower transport layer for segmentation and reassembly"


---
Regards,
Linux Bluetooth


--===============1730672354861042100==--
