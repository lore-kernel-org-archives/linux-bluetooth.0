Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB8405C5E
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779017598; cv=none; b=O6SppULNVfQw3DzsrvxaQ9/22CMtssk/4mIkE8iU4bljxWOcDZ1blAy3F3Mi4LWaiNiRw8XzWuraAmwg7QiqGHy9iNQ7RdXqXa/2jYAnFpP/Da4RjjiTjqWgpFi6918L0pSZTdNPUgP95k+8Bxi++WLckDVfL9Zb5pHtmJetmMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779017598; c=relaxed/simple;
	bh=eMaBDzW1XMX3G3VR8cDw0Z5PNRG1aJgIGcACZlLSpe4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AR3F2e420VECBLua9P0/7CgxGO3PtpOaBitk35lRVY6gzmBJfi2x2ihotuTx/PREcLV1FJY1x3jSNyk4uZlqKOXFwtd+toUWjuKnBQIEx2M4YQ+lcvMcSWZcE/shpIsFGFu5ni7Vpsd2qTDtSXCamF6OvffNC+TWUinD3x8wZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qEhHMJAt; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEhHMJAt"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50d6ab4476eso18149201cf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 04:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779017596; x=1779622396; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yAB8eLw44hjbZJkaPN3twZwAVwmuPCsWufXRd9DbgUg=;
        b=qEhHMJAtkC7diPxChGgw51Tjwk2jjUC7FTLukkLOUq8cxg3rRItGVgG0hdMvMvH0dn
         UrqWFTcOUEDQXDdqhM0KQOHlUBXtU8YyccY8MlQ8sekAAHKatuyqzdlY8ZapaNXvUMR/
         DhYzk7CKsHzqipjnASqcbIPYayeKt65gRsgyU9ZPHJi11PDBAeH2YX4zKOzyy1URLTBi
         ZnKDAmNuV64oektOpdfmKZPPcPdqE+TWv/TmCuB8U21TeUFGB4rvgOIfUyUySPhi+stX
         ZNuNpLYteiKlvDwNw3D9mY+ZxqPz0KZ+qJ4Erf5aCnlybAzqSE766KeS/yOcreW+K+vI
         yjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779017596; x=1779622396;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAB8eLw44hjbZJkaPN3twZwAVwmuPCsWufXRd9DbgUg=;
        b=K4eXMU+6zAMl4rsCayy+f+qAEiYDSghO++wSccsQzyxKSLjV+5/+1RlMJIdQJ/m26i
         3Ucv9KOjFYl3Cfsu0RWwktSaIAiOmpo3w5SNnPHPSCeq2BU9IPNIyc7CuouFP6clfmPi
         Ur75PrWUvvKDmOKDXmjvQa7us9KbKEVTsnC3xQh4Q+sM3YylQEU2xrhvsBWZXa4O/5SJ
         z5dfuRIMpF/9HOgAjLs2TrW7c63vB8oGf+inlVjsSb/0OnL9I8cmemmJrhCYNLfgvhtd
         owS5vWrtBNxhNlpgYB2mRxkePATL24kwcKIqyBO3X68V8Hmp3xbBN898ckgfusgO15n8
         NOrA==
X-Gm-Message-State: AOJu0YzxROSAzhCVjXWlyoHzmtHc9phnAMj8iHaXgoYnTFcY/J1EvEZp
	KfjObcLMHT1vPeUv/vuWrxDhmFoowVSVCaJu0DjDKq4N5X+4NIQAZvyDZXNKqw==
X-Gm-Gg: Acq92OFXS+kO50g0Us1yuJB3HmPowKzEFbImZZhWZU7pSpTmDDkMA8vr5apH5WJvQGh
	X0r06mOM/9sCqFxyisINWgzQ5uwh9dX+JbmBYrVDXyHidYdmSnfJX8X9tVrpbGzivaZDYBCVBlp
	/uqDeWD+liVLNRgGnFL3P7i27dCi6BYzbDwEMAko1GxUp3gAxNGPlRrT1MkujRmysGSPqyl8gfz
	hmnSKoJcSNe1q9kGkBOM37SE1CX005N4FzGcvDBNsNbxclDhAHd1/Wx3LRUc0J6a+p16BJYl+Rf
	lazc0F3wFvNEcqh8FuF8zQilzD596Dqt8t/rKMFXt+oDwNQ3FYanRlC2Y6sbBmBQ9LUy+EbxugB
	ok+r1W1lxhpee2drsqsu454Yiu32+c/aKA1zNfdrbtYnrRhSyNBpeAE5mS6MFv1JXwb8Yc+vfkH
	T5Ymet3pINakpW/oYanNveBJYRgghGYzcZkSDy7NjI
X-Received: by 2002:a05:622a:2606:b0:50d:e1c8:5ed with SMTP id d75a77b69052e-5165a23c962mr153818091cf.52.1779017596228;
        Sun, 17 May 2026 04:33:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.213.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456888f6sm106093631cf.3.2026.05.17.04.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 04:33:15 -0700 (PDT)
Message-ID: <6a09a77b.3966e9af.21d33f.4914@mx.google.com>
Date: Sun, 17 May 2026 04:33:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5298712542569909655=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/3] shared/rap: fix use of uninitialized value
In-Reply-To: <e7e72c0208f579fd6bb63b76f9d2a1ea3cabd2fc.1779013529.git.pav@iki.fi>
References: <e7e72c0208f579fd6bb63b76f9d2a1ea3cabd2fc.1779013529.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5298712542569909655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1096012

---Test result---

Test Summary:
CheckPatch                    FAIL      1.44 seconds
GitLint                       FAIL      1.04 seconds
BuildEll                      PASS      20.18 seconds
BluezMake                     PASS      606.71 seconds
MakeCheck                     PASS      1.05 seconds
MakeDistcheck                 FAIL      219.28 seconds
CheckValgrind                 PASS      203.90 seconds
CheckSmatch                   PASS      326.52 seconds
bluezmakeextell               PASS      166.47 seconds
IncrementalBuild              PASS      628.84 seconds
ScanBuild                     PASS      974.54 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,3/3] main.conf: fix unintentionally set value
ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'Commit 31e4fb1498f4 ("monitor: Add decoding support for HIDS 1.1 flags and attributes")'
#88: 
Commit 31e4fb1498f ("monitor: Add decoding support for HIDS 1.1 flags
and attributes") unintentionally set a non-default value in main.conf.

/github/workspace/src/patch/14577223.patch total: 1 errors, 0 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14577223.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,2/3] sdp: Fix integer overflow in sdp_extract_seqtype

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
5: B1 Line exceeds max length (171>80): "Link: https://lore.kernel.org/linux-bluetooth/ygH6bncNsvf-0Hco92Ae11Lw8-jOfekFO6O3bUvFK8w0DTueny_rwJIF6ffZg2G_XCB4v8h8xRIcAL2b_KwaweNcGa231ZQDHCMpzyvR5i8=@fluentlogic.org/"
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[4]: *** [Makefile:10239: test-suite.log] Error 1
make[3]: *** [Makefile:10347: check-TESTS] Error 2
make[2]: *** [Makefile:10818: check-am] Error 2
make[1]: *** [Makefile:10820: check] Error 2
make: *** [Makefile:10741: distcheck] Error 1


https://github.com/bluez/bluez/pull/2130

---
Regards,
Linux Bluetooth


--===============5298712542569909655==--
