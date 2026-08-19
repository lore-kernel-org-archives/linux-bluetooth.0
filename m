Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F29033C19E
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 23:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787182652; cv=none; b=IS/qZmMUu72jRkK/6/vFDhFYREvgnjMNiWPDHDhCw4HyfBoWSxf5vzEwAbXTQU0Mtkx6J6gEht8p5vdfrEw76I6T+A8nDxlW4Q5izy4tUoryubg1CGcZc1rUf1AbXjtqJNB+EQ5/a3GTGznZcy4xtuwSukmfLffEktQx0gccEy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787182652; c=relaxed/simple;
	bh=nzyn3eYDB0QvyVZHLO8kSwUt8c8HeG2SqsFAX9akcWw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MgumgPEKe+vDF3TKE61GC03Dwd4jYT5kYqVlEXUn63Xu0GUwbAvBUbBFy/x6KZkJYWxWoPBAtpeMD+PXL1sPEqeX6skm/xqVB5wpfAPrOgttJAT2RBRwDcYzkB3LNwPStTWdfiYFiz847kNlXQ4Zl7zjbg0qAi1w2PznoibdvK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tEw1fQqz; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEw1fQqz"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c2cce930cso15524341cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 16:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787182649; x=1787787449; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wckzqrWLeJ0m5frwnO3ppAOPrIvZtupBFjeEBkAUpS4=;
        b=tEw1fQqzuk5OiFgRjl9twexbvB8BIQDZNS25g3kzvh2UetVtkAMUN+pDhUGSHESgY1
         C+1gXiocqR3F/K6ASCVbMofSRGpZSMWElf1WYUIyneO0HeljrQOxLFCT/JkUqkS1J9C9
         do35hkbiNHm8Jf7ajclk6EQLFPZKa+jxAp6A7iZkOCwfgbbVgi3AGK7Vkp16jYm3zsdY
         SGaG7JbVN3GFDIQ/qHHWHEcp4u7eyL4/gjGZTTU0WXLOjBfOSldi3GzSZMOVjYZXUcm0
         Cf9bY3vVOnGzvDuTzXi4howjhgQcdlrM2+kHvFQOTI6zNQqvhuvi38426Er2jmtszc2l
         G5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787182649; x=1787787449;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wckzqrWLeJ0m5frwnO3ppAOPrIvZtupBFjeEBkAUpS4=;
        b=I0BLK3SAZzrkpE9wZLjMraVqFMahucWMUHb1oPw1nwzM9yCOF5EjaeGAGNxCsjMIBy
         jOdn+JR8huT+HV1LlTfazTSsx5FbT5z84FX3IPKCthlJyxk+j8PTwRLuIPY7tptkkHlM
         M1Y4FOLvQ1IsEFRSDgR190mpMt6AXOLir/f9H/IaQiZgqBi38P6c2jHJ7fUEir8z7XHr
         AcsslfiasHzAGwprfm3x15nvfmrUQ6/WvEqAP5fZcvDaputC/dAl+8y+EIYLRdqTk+VS
         Ot4r7XsT9DwtB0tllaZEOohSINMmY+RU0VcSPXKLwY7024UqPbYIbh6YfCJtALZB7JI3
         ZzQg==
X-Gm-Message-State: AOJu0Yxa16ltuTQMDcXP1+/cbCuFz0PSABwAR7GdjymXK8LG/Tu93NkB
	kJ4DEGOCRmq9MTDL3yh9o3nQe5ZTX/YJfNebGrioTr95iAb+47dkbgmOoRt/KQ==
X-Gm-Gg: AR+sD13JfRgFkhyYxyqLgQHyKgqCLkxhIhutffSsGa1NkV5zkCxDPcAG7pKuhYMlHV6
	cwjcZ8ZU8/B/XD/M6j7HDELORvsD9neR13Y8cqsYDw/5WtjUSxWaMhpKnkPat2EpVmyxrQHX3oC
	HQVrYSjIzqPXOpURlLGVRown40+6XCZavPESIl0X1NhprZ34EhCwxs8zArLBOjyBqGTNEYikFbl
	73jkYsnN4R8/XNDDGWj3DKHXHK8HIX6Cf2kvSRHS0pe6YWvVWlW6VO4dO0tosZIFgpse28l2tSF
	16BFQRXDIwH9MmcrpCCGX88JoyNIPHol54H6udp5/nnPOhCIvs4IPnzgMVR8pWVyoZOuNvVIwIy
	coaUHtAPR05hpqD3aYecdN6DRRxrwSsdrZW0ChYmXUN+05JaDlsGxoNkQHJR9TkWWPiNyP4BfXQ
	3M3axIMyxs8nGra5uMqcI/B2VqJqMuVVhbQnQOypRm8RIjtZQnNDrDPLRF77HGfmjPRZw=
X-Received: by 2002:a05:622a:1ccf:b0:51a:88f8:bef2 with SMTP id d75a77b69052e-52dd5c74b48mr86545301cf.28.1787182649347;
        Wed, 19 Aug 2026 16:37:29 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.181.211])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5eec1f31sm25543706d6.13.2026.08.19.16.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 16:37:28 -0700 (PDT)
Message-ID: <6a863e38.649d2b0f.33797f.1010@mx.google.com>
Date: Wed, 19 Aug 2026 16:37:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7541291774817614621=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, m.kurz@irregular.at
Subject: RE: Add component batteries and Fast Pair Message Stream
In-Reply-To: <20260819223144.82045-2-m.kurz@irregular.at>
References: <20260819223144.82045-2-m.kurz@irregular.at>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7541291774817614621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1148725

---Test result---

Test Summary:
CheckPatch                    FAIL      2.89 seconds
GitLint                       PASS      1.31 seconds
BuildEll                      PASS      20.10 seconds
BluezMake                     PASS      554.31 seconds
MakeCheck                     PASS      19.07 seconds
MakeDistcheck                 PASS      153.38 seconds
CheckValgrind                 PASS      222.00 seconds
CheckSmatch                   PASS      296.51 seconds
bluezmakeextell               PASS      95.54 seconds
IncrementalBuild              PASS      589.67 seconds
ScanBuild                     PASS      877.69 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/4] battery: Add component battery objects
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#112: 
Assisted-by: Codex:gpt-5.6-sol

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Codex:gpt-5.6-sol'
#112: 
Assisted-by: Codex:gpt-5.6-sol

/github/workspace/src/patch/14758177.patch total: 1 errors, 1 warnings, 575 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14758177.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,2/4] doc: Document component battery objects
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#105: 
Assisted-by: Codex:gpt-5.6-sol

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Codex:gpt-5.6-sol'
#105: 
Assisted-by: Codex:gpt-5.6-sol

/github/workspace/src/patch/14758178.patch total: 1 errors, 1 warnings, 70 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14758178.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,3/4] fastpair: Add Message Stream battery profile
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#116: 
Assisted-by: Codex:gpt-5.6-sol

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Codex:gpt-5.6-sol'
#116: 
Assisted-by: Codex:gpt-5.6-sol

/github/workspace/src/patch/14758179.patch total: 1 errors, 1 warnings, 1139 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14758179.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,4/4] test: Add Fast Pair Message Stream tool
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#109: 
Assisted-by: Codex:gpt-5.6-sol

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Codex:gpt-5.6-sol'
#109: 
Assisted-by: Codex:gpt-5.6-sol

ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
#130: FILE: test/test-fastpair

/github/workspace/src/patch/14758180.patch total: 2 errors, 1 warnings, 569 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14758180.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2416

---
Regards,
Linux Bluetooth


--===============7541291774817614621==--
