Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1120929CA
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925492; cv=none; b=O9zUvoOk6n4Vrrr9GcYMLuQX6Vwv81b9xXCJpFxciStMaLqzVqD8xRZ3XjAHZFstzsZYWrbYfwbJIQY+Cz7pmAnlrvV/Up/UmdwG4pqpA9x67cSFO60awrQ7L+BPR4pUbab3YiHa+HW3qz4G+C7djQ5krbKxCl9qYpBwv6DA/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925492; c=relaxed/simple;
	bh=y552LFR/4YCsRkoKHcha871nkuzF7MA7mnN/p7/XV0Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GpSsuY9iVsCvr1cISG54SFUcVGhNp65NcULBZfsLAbhY2XmVo+WzECP5xu09Ge0Wn3N0+he9vtdGFRdukihTM2lOSgsfBSHkfeaked5vWYZBxLrOUmE7etq3+rvPBxq6uDgDM7XCIMdVwtMZBo85KH0Otp+nRw1kcOXy3JV0VcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFsjNl3m; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFsjNl3m"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c5acb785f2so23646476d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 10:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728925490; x=1729530290; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=daxSFc25ocBUjXSM2MhJFM6WTIubAnJ4U3RHP3zNeO4=;
        b=aFsjNl3me9S+t4d2hJTR45GT2MJBoCydfIz84fFDeztbLv2FpAMlZL3yH6Qqnk+kdA
         z/u+Jk06pTEJmcL/6vnud2rIsMIb4xlqbgBpMY8OeaIvofMo1y2wPYFUxnk5Wn8gWvjG
         RAyRjZK89AtO0Bxz6F8x0xeIEZzmVTFp+DnESwoiSIxOpC6qZoAcOlH1Z07YWL3AUbvF
         t6n7zAb5ir0My3t6rL4rY8MXbMZTr0TkjwsbWYH5T0cLhUWM7C7W7sLWwTmX9eUav2Nc
         cs5UlgUi7feXXUnIB8sEylTYzXWbwh9Y4gWDW7Qsv0y7TFGngQs184OKLBVhDpp3LWAc
         zwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728925490; x=1729530290;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=daxSFc25ocBUjXSM2MhJFM6WTIubAnJ4U3RHP3zNeO4=;
        b=qMUj6S8AAP+FOTXL5zbP5KQRB68mrfIm/4yiz/0Iv+NRz2mGouV4J3f2vAe9ol+e+X
         Y1aaaFP33NyOEpI3qnJ9EiPqELKMYzhdkiWgoGWBOXXFUd0MHtD0oSaMh6MP9djR0mw4
         SfKimtKi9r22mQTfRAKUPkjPv/ntS8KbOBsW9Um+hHuhc+RztfjNzDWIINOMWZs/ZIfp
         PJpKRvDm8cWba8tNWJcxOdiwxP3+6C0i68nHzdL3eGnyHohGKILPF345A4fPQ+mVxApc
         oFrdHma61ETIiH6OKSE4MT42eZSRTLyDn+gV816VVNkOOUdvvUa79uav+ElhGsFPe6mP
         uuuQ==
X-Gm-Message-State: AOJu0YylS4zgF441K2tkE9T9L8TIjsWepqYmwwZ33BEuneyNH2yQIeRs
	alzOTKb67B8B5/S8Z6VSql6cFi9XzfYgLUdM/1zNcyICwOGOUphcvpmk3A==
X-Google-Smtp-Source: AGHT+IECxYKB1vm/NVAj++mPRJEi7WhZUkOw3jXIBalvyI0iL1ZqGe0h9OUAUUJx8JNZzhsfJ/S3pg==
X-Received: by 2002:a05:6214:3387:b0:6cb:ecb3:4d3b with SMTP id 6a1803df08f44-6cbf00ab35amr178361106d6.42.1728925489392;
        Mon, 14 Oct 2024 10:04:49 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.98.109])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe860b783sm47468676d6.83.2024.10.14.10.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 10:04:49 -0700 (PDT)
Message-ID: <670d4f31.050a0220.1235a2.f41f@mx.google.com>
Date: Mon, 14 Oct 2024 10:04:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2315809337760350201=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] tools/obexctl: Add support to connect using PSM port
In-Reply-To: <20241014152205.66120-1-frederic.danis@collabora.com>
References: <20241014152205.66120-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2315809337760350201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=898969

---Test result---

Test Summary:
CheckPatch                    FAIL      0.59 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      24.80 seconds
BluezMake                     PASS      1657.83 seconds
MakeCheck                     PASS      13.30 seconds
MakeDistcheck                 PASS      179.85 seconds
CheckValgrind                 PASS      252.27 seconds
CheckSmatch                   PASS      358.62 seconds
bluezmakeextell               PASS      121.47 seconds
IncrementalBuild              PASS      1445.71 seconds
ScanBuild                     PASS      1016.21 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] tools/obexctl: Add support to connect using PSM port
WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#97: FILE: tools/obexctl.c:150:
+						DBUS_TYPE_UINT16, &args->channel);

/github/workspace/src/src/13835246.patch total: 0 errors, 1 warnings, 43 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13835246.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2315809337760350201==--
