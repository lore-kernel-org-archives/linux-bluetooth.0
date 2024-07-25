Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04326281
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911317; cv=none; b=KOe4Ys2KnFROykF3is6HjKxywPCTwC4JutHV1jDCv97Je6PQ8x7P1/xdYWfzu0WCzhOW322lPxquee4j+ZCuIlFLkpU2vxYwR50k2yiO9Bgij5K5ZPd/Utt0IjSWJ4xrWM2POry9Sfc7iNlufobQDjZmjr0Zs1qarGYneZlIApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911317; c=relaxed/simple;
	bh=62/dZ057ty04qVXk/+wqqJe5kwjK+3gPCDFAA+grAbk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BP4ghAlaNuQFsa3N9DKv3rQxNKqAkMmIXFW06KajA81IYxVmEMN6q2ltqTUnBsuYfEwL24nXSwUouIbRmm5RE41I+S78DI+PDawnGmUXC6uLtHROKlus9ZIJvXxAQwG55f0WSd9D4NhscomOXftfI+MwxDkHorAVe3XFvwMjf6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMquUgts; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMquUgts"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1d984ed52so28310385a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 05:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721911315; x=1722516115; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f9hI1oqTJv5ZHwP/wo2FTifjoX1Xz5kaGDi8eBZDbkQ=;
        b=QMquUgts72Rz4FgQJjzzmYc+O7db1PV2kKbpSF8qzYJ3JYzJUWxUKkbLEp2Af6K7jX
         JzgLgfc3W/FrxcsgtI+vHS/OIjQVsHi79iiDrD/e2+IQa61cIXM/NHV16l697EKAc60R
         XF7uJIxcw9B6HR+sL1qjQvJvViYZo934hXd/MdhNy25ZCImRey5XCxks1nFU0BUpryQt
         ahYD0VmA3j79opHWXsrqlMp3D3jWNta63mJOIhOp1bfRubttGQvbKf12iJc2A8mYf4Bl
         45zGIlLcCaSHpjt/P+9cVWIbzRLh7h1M9154P9mGmT55mKQjAznBhfudtMkmx6gRhbW9
         ChwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721911315; x=1722516115;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9hI1oqTJv5ZHwP/wo2FTifjoX1Xz5kaGDi8eBZDbkQ=;
        b=FYmPoSZK9019WLFz8vnje4HskQjMGkphjV5zwHFr9lMmySKnZOpANj2xqZ8kLhFESy
         OsgJGH09/Swk62LkahV9hJcxlnWZmYooqTgGLQ8XLHHoL/iedja6PzJ2CPTgQMDY7i1X
         OGb0qm/NmidPJIRzlixNELCFhYH8zWIe09EBjZp6RBhbmjlQSjCOiD7LQcLshsD39I4y
         1kRzhH1t1IMZm7R9qRL6xi5HyM9LA4Q2wgmkF5g4mnG9CWQ7FAeax2f++H1ya5tJvYp2
         G+tNx4C4X/5CUnv7fZKYRNPJ/xXXP2eZ3Q8eEyLtxc8XkqeFNpzvLBJkVLdWqZ/osq+9
         5R/A==
X-Gm-Message-State: AOJu0YxpwDbTnkWn+B/C/H3BtKNjJaeNlkXTDyYB24H0RaO/HjQbwSpo
	gq5Fzkve/ijAOBpdihirsgkdQF3LiGgVKEF7vRDDTJiWGxJGaFRS3HUakQ==
X-Google-Smtp-Source: AGHT+IGOeTg1YA4jXIjkCMdqSodNUnUWlJdv8NJfqVUwOG0vz6ekjAtE8lSgI48JhXxu3OsdzQEIeg==
X-Received: by 2002:a05:620a:404b:b0:79d:5399:baf5 with SMTP id af79cd13be357-7a1d7e49247mr216937085a.15.1721911314550;
        Thu, 25 Jul 2024 05:41:54 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.119.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7398229sm78993385a.4.2024.07.25.05.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:41:54 -0700 (PDT)
Message-ID: <66a24812.050a0220.5cb2.1e27@mx.google.com>
Date: Thu, 25 Jul 2024 05:41:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1892902862100222659=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v6] obex: Move size emit signal to plugins instead of obex.c
In-Reply-To: <20240725105226.3121-1-quic_amisjain@quicinc.com>
References: <20240725105226.3121-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1892902862100222659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=873803

---Test result---

Test Summary:
CheckPatch                    FAIL      0.67 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      24.97 seconds
BluezMake                     PASS      1767.28 seconds
MakeCheck                     PASS      13.40 seconds
MakeDistcheck                 PASS      180.62 seconds
CheckValgrind                 PASS      254.28 seconds
CheckSmatch                   PASS      358.12 seconds
bluezmakeextell               PASS      120.75 seconds
IncrementalBuild              PASS      1532.05 seconds
ScanBuild                     PASS      1058.75 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v6] obex: Move size emit signal to plugins instead of obex.c
ERROR:SPACING: spaces required around that '==' (ctx:VxV)
#120: FILE: obexd/plugins/ftp.c:178:
+	if (ret==0 && obex_get_size(os) != OBJECT_SIZE_DELETE &&
 	       ^

ERROR:SPACING: spaces required around that '==' (ctx:VxV)
#136: FILE: obexd/plugins/opp.c:90:
+	if (err==0 && obex_get_size(os) != OBJECT_SIZE_DELETE &&
 	       ^

/github/workspace/src/src/13741794.patch total: 2 errors, 0 warnings, 31 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13741794.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1892902862100222659==--
