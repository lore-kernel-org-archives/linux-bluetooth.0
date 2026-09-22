Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAF94FB9B1
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060303; cv=none; b=OFuFUjwJtKSAZnxP4nTLDicN8/6qcot9gogCiPjox7FSZf8n1kz1TOOi7c+/pd1xqztsodCEBVLYWmoVSyWs83Kdkal7FNbTRgBAoup7eD+81lqt4I3EvkKgLROXxtAhA8ePDkV0pNQY1AM9ZDLMfRaGCqoxfPA9+xTO87Ju2rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060303; c=relaxed/simple;
	bh=pjgrmjOjRxUOtSHWFatxOZQ0HiAtRkI0xtK0soSERzg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OE937jlOOEsNsPJEaDMJCbcM6xwHkZdbdSdrhSMBgTwe5yY9UnfcaQipVBLCZ9LwrgYSO+GAXd0i9qM43/GBFeoEtT5mhDl8SKmIoi+9EQ09LF2o5p6oLjNQAsLyk6ZuxTSy5akR2auRlt0j4y76blUZox7EN0DxRjAkbn+/xQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AW0OFsgm; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AW0OFsgm"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fb334e72so34528645ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 23:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790060295; x=1790665095; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gnqO3rG5ydRdHYEG5fsb77D+Kxqz7sMzgxWqa8fWixA=;
        b=AW0OFsgmZc8oo1oroNqgkwGo4sUjltd/1zsBgGO3EZQ6vRUn/tnekz7smY5K531DRq
         D7ktgj0o6Et9peEr1we2nZGCcKePl/JyEYezKA88mFa+iolWaVd5Be3dkcixm2nWgW5y
         sq1tWS7j5OoIIgLbE440E1PZn35pRhn8eYL/PhnxwQhcAtg5FNg2nNHCmivDSxjcpadF
         LjGtkjfqJCS907ddGKwF8PdBwPbNeGpgraLzF6ae34hTBq8NpeNOsLbQuIu2bFKP6rqQ
         IMA/HBt2u9eJzOOVcaJf0E0DzgCglVI6ocJkxJbUmGg3eJg4RvN4JAgp9BWU76gY+OYY
         ZWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790060295; x=1790665095;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gnqO3rG5ydRdHYEG5fsb77D+Kxqz7sMzgxWqa8fWixA=;
        b=e+2Ig+AisG+xzlwycYeKZ3Xq3jZ1bta3ZO1pdInVL77ZAXs31pnEmgfeaUQ/ASJkeW
         uzeAGgcs+JBnhC6odZZveSv515YPuU2iRT5KBRzv/dNebZ5uKbsx1dzg1QMq0ZMzgtyx
         pNVXdd+dxDK8zvZaS3r3ilkCAaBOlBc6lySdxTMZVuxwrYdE8jPCv1BYWdO4of2VaQMj
         dKKdKSN4gcdPziL+Jt2wYBY3lyEvW+Jme59JPyoo89vyFsWiUt50CVqfymolWofugJiy
         9Tc0bWo5oKgLU6YodGEX3mcUubn5Q6dWxZQXAhcq/Ov9mm+QFG4YiSLrk1RwQZ+8CHe9
         TcaA==
X-Gm-Message-State: AFuF++mXxf933jupU6U67hiDga1aI4jKaMTYVjUJ3Pl5H9iC7IvjsjJJ
	BHbonuhtJ5detE0KfNFD0hJI6ZnWQu5E8UXrmLriOTt5EHQqZLBkUJRcGDgLdQ==
X-Gm-Gg: AYBFou1z2fMfMAKGd5ZXog+i2WvWKK65Ryq9MnuZIeC8y5fy3Br13/dmITiHbJPHOik
	CxwF0UPrI6rw9KG1jpfZgOFeHNmO0PmvQHGGUiTtBPHA/kGH2KY3CBePVBMRFdCK1Q6oUnMU4Sy
	WvEPi7T0EUYsTggnOE6ev3cffi81yegAB1H+wnrPVX6uU+cOsPJ1LJeOTf8a0jDozWXT0lJKegC
	Y3rUCYmi10oxCG/lC1ZJ7mcXfJ5bzgu3QuZrIktFJqu5FsGoyfLlFtlbaG2kXBUwbPrUOM0cofz
	zsk+UlOnW9BQwomB6mINv4E9J3VzuhGPN4GL0ES6QA5GYclPwmltcvVOSf7dU6aXmijBF1wHI2m
	ksx/yAKs2L8ftXijkevXJTZHgpZWGu39+OCOXmZwQ8uaUVLFG0f/qTFFdOekRHb+vD9mmnomD8T
	4b5xmr2eMUsVlnc41FrAEi0ge9WTJjJM8OzYDzA9JX9jJXRVONxW8hmj1Ra97SFTfhICvlyplCN
	NVANw==
X-Received: by 2002:a17:902:d2ce:b0:2dd:c100:7cbf with SMTP id d9443c01a7336-2df60b691d2mr2552295ad.59.1790060294917;
        Mon, 21 Sep 2026 23:58:14 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.244.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e6134164csm2569596eec.31.2026.09.21.23.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 23:58:14 -0700 (PDT)
Message-ID: <6ab22706.c21e2895.25a7ee.b8cd@mx.google.com>
Date: Mon, 21 Sep 2026 23:58:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0004209382021164731=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 294305068@qq.com
Subject: RE: [BlueZ] device: Fix NULL pointer dereference in dev_property_get_uuids
In-Reply-To: <tencent_27EA4A683B87E3DCF400C26D990DD9364507@qq.com>
References: <tencent_27EA4A683B87E3DCF400C26D990DD9364507@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0004209382021164731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1170934/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.35 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      16.37 seconds
BluezMake                     PASS      272.05 seconds
CheckSmatch                   PASS      199.12 seconds
bluezmakeextell               PASS      75.39 seconds
TestFunctional                PASS      872.86 seconds
IncrementalBuild              PASS      265.89 seconds
ScanBuild                     PASS      787.21 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] device: Fix NULL pointer dereference in dev_property_get_uuids
WARNING:LINE_SPACING: Missing a blank line after declarations
#112: FILE: src/device.c:1460:
+		const char *uuid = l->data;
+		if (uuid != NULL) {

/home/runner/work/bluez/bluez/src/patch/14837278.patch total: 0 errors, 1 warnings, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14837278.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2564

---
Regards,
Linux Bluetooth


--===============0004209382021164731==--
