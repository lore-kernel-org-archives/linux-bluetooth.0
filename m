Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F22F376BE2
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787344707; cv=none; b=uk2khfL6MeSMYXrmIDP2uE5Nv1fz0SVj88eVVi0CtER1Dk73nw7Rm98LDlYN/OOP7hSMAGoNnl72kLZ+dXjmjhzPjR2OP4VYHhLQZZ6vxdOornMuXDiG5ymxANA0xVunGKuwc/dONrtWqRhpu/4uL2N8EM6VOoIB8uC2R6T56ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787344707; c=relaxed/simple;
	bh=72yV9eJSo6YB6O5wUANaQKOGILNv4jXIw00NH50B36o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=b8b5nM/e2VORxkJZCn8/csvJX7m3gtkOyQjmo4SKCD6DIiSUnM/QIDFER7jKdbrJubaFqaiwufQ9waQL8iyWtnUruYEZKfPMR53xl68XQChfNkDtadbgmkfldbvgqB4y97ay4A0w9GWWjcTR7n6zTfgfuPuFw0TSMYmZKhov98o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtOMrqA6; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtOMrqA6"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8efb708b1a0so10101836d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 13:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787344704; x=1787949504; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cx1st758MsltA9+BIBacTNUAtm1EeobghQ99m4Wr/2o=;
        b=MtOMrqA6c076UfvxmXw1AZsScbXq67ABr+4wRGELmcRVuKFHKhuxl42P+jFg92tJ4h
         rr7Q0cj0rxuKSrCfLMOZjTswQWedApMV2bd7dtcoqaZWuQofLbBQJsI1WYW0dV6db4qE
         4vRSYGXGNpK9yl8PVglCt5U/3P30HjCHUCNAJlU2/C4qHcltKgxnHxkMhoZeI3x8MJft
         GaJVP3o4CLT/mDlDZSyKtjrmhTQbE6jKR2oEjBttYdDSeQzNJ2exD4hxB8ax8rn+Rx+H
         08AWANr6b+Blt6QpNVeaL5zGogsN3tiYIeiSnhi1F6m+RfkBt9iVr4DcFOc2FhH011FQ
         NWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787344704; x=1787949504;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Cx1st758MsltA9+BIBacTNUAtm1EeobghQ99m4Wr/2o=;
        b=hnp5qHFesSClOjgxeifR/yGX3ff0/GLNU9o8/r+OrKgxzZUmSd0jVLp/9hoHsCxwrd
         Rsa355pVkfTxEfU6jvNq6EGEGgeS+n4+iBaDE64h8xuUbhmRCovBr1FWthNhS7fgARgh
         UHGT2kuDnlOveR0/D+Dp6iuytNaPdKbMZuv3/i2UVk3Zh5t3rL8LVXroeI8vvSH1tHhO
         8i+3J7TcLPhtzMmsI+yY5wfPl1/TpNJMHN+FYXiNGV3q0prrP+igeGLiSk9u8ES7XxVH
         HMcdhVNlmaT69DlGovSfEze3N4XNnRGUdIfWFvb/4gYaqGXcCCzANDlwzjykXrog14ex
         uzFg==
X-Gm-Message-State: AFuF++kMchchtz1wn4qW+aWHIimQYC3gXwrIoyk9N1CUKTWxa4RvTMRM
	c/iYbGYDC2w+QfKIQsv3tpg7e7zsNcemmgPID9/clek6rOSPOGyW15sNded3TMVp
X-Gm-Gg: AR+sD11jpMH8UoUZ/49XLzVseAqJpOpSeuQ0P/s8BbKPKwbitBwsKN+/KM2ik+aj53t
	EvY6f/BmHRn0uN75kmsSOtY1rteG2GZfrFATT4OKE2vMl/SwX3BKVLXnQOBbEhx9TwVDiQhWbYo
	BJNGqiTkArKeWtmjZ8OKzSSk5h0XR/ljTm0i9/BXUCxnoP84xlapTPSzfef8/awl86yvLYtMC+0
	T92GKa/smXQ3NNBNFZkeKHKk7226gE6q79CBP8BzUV3vKzJT0+r0ArkC/Q4b8DvykeZOucmIlF+
	T6tvW52CAVo6r09jvwBeXcpMTeaPygEgxl+Zp7s1imPpbpeRJXXBY4e2nag1zs1QTfkLIpDG7yv
	+BLqrNwnqUefqUpULPTW1yb2J0aTFX6CiQ2nCAiULZ7a0tu4orkOJJ3p0Jt308mPsZRMT+RUKLA
	d7gy1mihSdn61Hr1mv1V1nVbQWaugTfc2Uok7A57zp4WeEbTj7wUQTVe9OEUOk/MML/to2
X-Received: by 2002:ad4:5f0b:0:b0:8f0:47b2:5736 with SMTP id 6a1803df08f44-90c809954camr86981506d6.13.1787344704181;
        Fri, 21 Aug 2026 13:38:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.182.195])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2b1f39sm70601146d6.41.2026.08.21.13.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 13:38:23 -0700 (PDT)
Message-ID: <6a88b73f.b9bfd787.e23ba.bdbc@mx.google.com>
Date: Fri, 21 Aug 2026 13:38:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0883824946446212773=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, george.kiagiadakis@collabora.com
Subject: RE: player: Fix crash and related defects around the pending request
In-Reply-To: <20260821193449.1336263-2-george.kiagiadakis@collabora.com>
References: <20260821193449.1336263-2-george.kiagiadakis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0883824946446212773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1149990

---Test result---

Test Summary:
CheckPatch                    FAIL      2.91 seconds
GitLint                       FAIL      1.60 seconds
BuildEll                      PASS      20.28 seconds
BluezMake                     PASS      549.74 seconds
MakeCheck                     PASS      19.22 seconds
MakeDistcheck                 PASS      154.17 seconds
CheckValgrind                 PASS      224.64 seconds
CheckSmatch                   PASS      297.60 seconds
bluezmakeextell               PASS      96.20 seconds
IncrementalBuild              PASS      586.08 seconds
ScanBuild                     PASS      892.57 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/5] player: Fix crash on MediaItem1.Play() without a browsing scope
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#112: 
Assisted-by: Claude:claude-opus-5 valgrind

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-5 valgrind'
#112: 
Assisted-by: Claude:claude-opus-5 valgrind

/github/workspace/src/patch/14762403.patch total: 1 errors, 1 warnings, 246 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14762403.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,2/5] player: Answer pending request when the player is destroyed
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#84: 
Assisted-by: Claude:claude-opus-5 valgrind

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-5 valgrind'
#84: 
Assisted-by: Claude:claude-opus-5 valgrind

/github/workspace/src/patch/14762405.patch total: 1 errors, 1 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14762405.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,3/5] player: Fix NumberOfItems never being updated on SetBrowsedPlayer
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#103: 
Assisted-by: Claude:claude-opus-5 valgrind

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-5 valgrind'
#103: 
Assisted-by: Claude:claude-opus-5 valgrind

/github/workspace/src/patch/14762404.patch total: 1 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14762404.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,4/5] player: Report EBUSY from a busy Search()
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#81: 
Assisted-by: Claude:claude-opus-5 valgrind

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-5 valgrind'
#81: 
Assisted-by: Claude:claude-opus-5 valgrind

/github/workspace/src/patch/14762406.patch total: 1 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14762406.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,5/5] unit/test-media-player: Add media player tests
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#101: 
Assisted-by: Claude:claude-opus-5 valgrind

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-5 valgrind'
#101: 
Assisted-by: Claude:claude-opus-5 valgrind

/github/workspace/src/patch/14762407.patch total: 1 errors, 1 warnings, 864 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14762407.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/5] player: Fix crash on MediaItem1.Play() without a browsing scope

5: B3 Line contains hard tab characters (\t): "	struct media_folder *folder = mp->scope;"
6: B3 Line contains hard tab characters (\t): "	..."
7: B3 Line contains hard tab characters (\t): "	if (folder->msg)"
[BlueZ,3/5] player: Fix NumberOfItems never being updated on SetBrowsedPlayer

6: B3 Line contains hard tab characters (\t): "	if (folder == NULL || folder->msg == NULL)"
7: B3 Line contains hard tab characters (\t): "		return;"


https://github.com/bluez/bluez/pull/2430

---
Regards,
Linux Bluetooth


--===============0883824946446212773==--
