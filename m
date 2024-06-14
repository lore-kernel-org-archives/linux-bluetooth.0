Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DB716C842
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379716; cv=none; b=I5jv2o4tu+48xyYahmPksFhELafJwskf9FVHmQbfOWviJ7H4JrXNpjMZ/QQVZUZ4RoelCZkJOQhBqcKiFR6YGaCchKqKNl9p9tQgBbYqVd1qiCbwxOgh6HZU0XSinhujRT5vC/Tb3o18/k/MZ4DWqMcdpuxtj/FXDZ2GA6AmnYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379716; c=relaxed/simple;
	bh=KL9uMRUi7EPOnVJh+JJOE3jdocZbfUINclNsMByMfSE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Xwnbs2g4ORdivqVJxsCUQKLNFFZU8nOP4tR9S+v/k4NDVOtjI6Kt91kvTQHE/bkRmy0t6zrzLh4H9o1HQTH76TWPvoAZp3lUuWt6+Xsl/wFWToUYxV+RM6VFDlfoNMFlvCIpFTUlWE1GNZXrEpMUVS+fQO9DYP3WYTbImVIXvGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geFhZH0P; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geFhZH0P"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f6f1677b26so17249895ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 08:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718379714; x=1718984514; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ah5XSRtZe+3N06HzCNRbap2nTstvHbW636xoApXCyl0=;
        b=geFhZH0PcjZb0lk90X2nL+lgJk0NSGWnt5jutOCgMV3pseDVBrPoWioFINVMhF2pwX
         fHqn3EMc/H7/Pzrza+KFBED1+/LoS8KEULbsFYfwBHgBvqq+CtmrzdRj/JZMiEm2oIYD
         2lKr3J4Tm0Vter3mVa48YkG0ochI8wqVOQMg6zK3pfYbGj40Grp3tLj4XTyPUSeB5721
         WTC/WfVc9wF4zSSnCxzeLTh5dryMjU0W2pjlK+Ky/IxYWuzjr/rIaCOdeXNZxP6xHHDW
         vxuFOLrSGWjQrYPhvN96WGvWQiL0NXXNG7oUT2zsgG/hYk1Y4MGLFggxMXjdXstMXL3h
         k+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718379714; x=1718984514;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ah5XSRtZe+3N06HzCNRbap2nTstvHbW636xoApXCyl0=;
        b=SnbWQLN+8Gtk6qqzUIo7SZO0cL+rrn2puyBs7EBpR+nqB0v/hdbSYYY98OCl7Unmsk
         CpB/lKCX9KBpt0Gl+oVFTlmqr1mP6dUv2CtRB744yipHR8wnu1u0KMMal19EAgXcbbug
         iSfNCjZX4VDyu/7+rg7zvCRLhOjCnB9/0NlICjfHZXHbvijjUY/2a3yv1oHfGB2DrCoP
         a4fFJWpicYm6ZzYjRbVyFaw7czoFWjUqQCfwU/nFYQ8do+7wmBfoQFbA7SWY/w1qmGIm
         2efkUUI8OiVz+WdMcnZOCSl4BVxpgpx5GbM2QP4zi0itnINKxWg4UFUb/LSABR/VP9yX
         u1eA==
X-Gm-Message-State: AOJu0YzqzRcs9HPxm9tbUyEnpyP/mKpPP1KN9NMQ6KKyWT+Vjiw7AFoX
	vxV3P+MOcLd3l376vepAeALDPgoE4NpcloYkpWFcptYA85xLfIyR7V4yGA==
X-Google-Smtp-Source: AGHT+IFBAxBiIL7C/Tb3zTCSGM/RzhXJaMpPjV6IAa+QdTsjkBZZvBJY7p3GGrZ6zRcIuDwjOMmnHg==
X-Received: by 2002:a17:902:e74c:b0:1f6:fa4a:5083 with SMTP id d9443c01a7336-1f84df9c96emr94572575ad.2.1718379714204;
        Fri, 14 Jun 2024 08:41:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.36.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f85bf28552sm28963425ad.132.2024.06.14.08.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 08:41:53 -0700 (PDT)
Message-ID: <666c64c1.170a0220.878fc.9036@mx.google.com>
Date: Fri, 14 Jun 2024 08:41:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2005290633758387903=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ,v2] shared/util: Update SDO defined UUIDs
In-Reply-To: <20240614134228.1299692-1-arkadiusz.bokowy@gmail.com>
References: <20240614134228.1299692-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2005290633758387903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=862092

---Test result---

Test Summary:
CheckPatch                    FAIL      0.65 seconds
GitLint                       FAIL      0.51 seconds
BuildEll                      PASS      24.63 seconds
BluezMake                     PASS      1702.92 seconds
MakeCheck                     PASS      13.70 seconds
MakeDistcheck                 PASS      177.66 seconds
CheckValgrind                 PASS      252.83 seconds
CheckSmatch                   PASS      356.91 seconds
bluezmakeextell               PASS      123.30 seconds
IncrementalBuild              PASS      1522.39 seconds
ScanBuild                     PASS      1011.83 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2] shared/util: Update SDO defined UUIDs
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#95: 
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Assigned_Numbers/out/en/Assigned_Numbers.pdf

/github/workspace/src/src/13698723.patch total: 0 errors, 1 warnings, 26 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13698723.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2] shared/util: Update SDO defined UUIDs

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (114>80): "https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Assigned_Numbers/out/en/Assigned_Numbers.pdf"


---
Regards,
Linux Bluetooth


--===============2005290633758387903==--
