Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CC53A71A3
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696539; cv=none; b=QI8AFrs2XmwRu2Zsm3RTscj4IMiqxzMR4mCBNj8r8GywF9d5YDX/bHHqgTMh+HeI231Pw6MsCQqlcg6HIHpSsx5pNYMo3XgndasDk7eP4MljjX27oNrB7rtgBjIlR0otL8zElriFAafcoNvC9R9S/AZPrsuB0aZ4YucNrpTTrvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696539; c=relaxed/simple;
	bh=POnFIyOv2Sf46wmrr9yVmEneky8J3CYhMqn9inJPPcg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=R9E1atwv9Y19B1qbVU2b2G76AKHmokysBokMRaCqsTr/+su69DfS2BmQhZ0hX6brVz2y0LjSqgxeqeSxO+Y0YOW7odMYi+DamhyIbQOLWDodAVTRPVaAOWg+Vxp/SbDrlDgPBRq6321n07wzeuu+6fy/EEe0xhjwysvl6Ur5r68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGcD2uC8; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGcD2uC8"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e36bb16a92so2907511a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 11:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778696535; x=1779301335; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FHhcKSNr47V7UnMY/JvvgrE5sx2z4JYmkp+rCRISPnE=;
        b=RGcD2uC8WAagDwMn4o0X+Kq21PPtanr271ppIqD7mXIBK92WZQpn3OMF15ocUKsBfV
         s4h+c9BYTrqPv7f4KNYyClRyZZW7hzlCCS4phhwurQ4ILTOqosReXHLJjTGDaS5wvxxL
         HNLW1ZWWwpNFsahiWFf2nhWJ7O56Sr5cZjWbisrHguNp0jP/aVzQ1/op06IOFEYrG4S8
         g++VVOR6JNRHgLcplIPTpWI7llW+OfYzcXIsLHQSBTKuxk/1X6UFvc4zEf2SgJn1tdv4
         MVmTnXHrU13NMfqZsZ7mEeMxvD0XA02E52vzn2xdmhrcUTSDbb0mUhoWtrNSiFAIW9n7
         6m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778696535; x=1779301335;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHhcKSNr47V7UnMY/JvvgrE5sx2z4JYmkp+rCRISPnE=;
        b=p2hNETLkAVXI+xkmsKY47xDyf+oSvC9IJD6sTUrg8KwWc/bSIfzXcCQ0EJLugY8mfp
         0w3t2l8VbII56SMlVqkLEi7TzIFUqmg1RAZ5ToF6ePuE0fazzfOQrEBVGgQlpUyWWSLs
         cPzVHHrXB7EAxgT2LnfitHWOGo8s/+kLzC1/oZEVQwvt091s2TatBhjz1hTfeBGr9vKJ
         8NeZZC0u1F5DcFAoV9subLHE1gr7//DpX7hUs8X6IcS9uM6g9wyI+M4PAc90dxDQsm9R
         uWB0H6RgHOEUmMAPrEJslZ8BJbgjxB3F/8wkOd77XRoCQZU2gZ0TVk6YPSwJ2Sqh7pzp
         hKAQ==
X-Gm-Message-State: AOJu0YyhZQNnQ/qDbHLU7s4HEHqcvE3hCMo4xKRwzQAe3xoXeDIjWIeZ
	tXszzor0PK0kFzizxFpIW1mSir6TeBimpHbtbhWeh9P0+vWOXua6IdNXDd6Lpg==
X-Gm-Gg: Acq92OFr5HkOsbNAXusfJUoEPo1QJRSJy+iiJqPQJmXnLRZla7qu0GBCJoH2VWx4GMb
	COACKeIdGIX/Ihj5DK2H/ue37X5XhzghtjAGVfulMOl59hYHjGx/2RXPOrovWCCFGPsuvvmfRM7
	RxCLFlc/j+kq42idK1s4o0VhlzHa50KdMVsBWbUqYi7vHL8nju+FyE8+VoIUJxzD3o+ASZuH8WM
	EKyA+ocfuoqm0sP2V0mRLsG1vh2lE1HUx+UxiS3ZgBppxyAsEMvOIkI7lxKYVNqfkKBxpsN5HGf
	USyqyTcOQArEZcgUP/PCCb3abgmVm7XrLgglUAFYEjRmfC8CwesshjvEtrlx+82re1yDQG267V8
	+9Yl2r5BLCVJ/FmU+feLBQcHRr4Mncha1oAweFZ8i03H9e5FKeeBBZgZMGSCjM67kxgUHOi6kxB
	nVmS3y+wVYntKeqf9qZWBihCCJ7HTEfo4QhB8YukE=
X-Received: by 2002:a05:6830:6732:b0:7dc:cefa:1c37 with SMTP id 46e09a7af769-7e3dc91302bmr2288511a34.23.1778696534754;
        Wed, 13 May 2026 11:22:14 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.21.55])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e3f398e1d8sm142790a34.10.2026.05.13.11.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:22:14 -0700 (PDT)
Message-ID: <6a04c156.9ff26ae1.2de21d.028e@mx.google.com>
Date: Wed, 13 May 2026 11:22:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4348003103423718486=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raghavendra.rao@collabora.com
Subject: RE: shared/bap: set QoS state when CIS is lost
In-Reply-To: <20260513163435.11344-2-raghavendra.rao@collabora.com>
References: <20260513163435.11344-2-raghavendra.rao@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4348003103423718486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1094333

---Test result---

Test Summary:
CheckPatch                    FAIL      0.39 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      20.27 seconds
BluezMake                     PASS      610.55 seconds
MakeCheck                     PASS      12.68 seconds
MakeDistcheck                 PASS      234.89 seconds
CheckValgrind                 PASS      254.42 seconds
CheckSmatch                   WARNING   321.72 seconds
bluezmakeextell               PASS      164.59 seconds
IncrementalBuild              PASS      609.76 seconds
ScanBuild                     PASS      913.46 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,1/1] shared/bap: set QoS state when CIS is lost
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#74: 
This is used to pass PTS tests BAP/USR/SCC/BV-167-C and BAP/USR/SCC/BV-168-C.

/github/workspace/src/patch/14571723.patch total: 0 errors, 1 warnings, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14571723.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2124

---
Regards,
Linux Bluetooth


--===============4348003103423718486==--
