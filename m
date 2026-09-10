Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8F056C62C
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789068634; cv=none; b=KY+9LQL4VmpD8Tw0BX/oI15J97FkOgKbuoVBPfwE/Z8RE9sYdxalTKJtZJuDMSSAfFePliYfLNZbXb0kB3K7beld2hgTQEe5K9V/7QsZ0Ie1Ygw/46lrD/E2x4Rc3Ie5XXlGJVIs4mFngjXBZe8EG3B0rNX1lK1RSUzUaC6VwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789068634; c=relaxed/simple;
	bh=x3ujUAklRikurUwLOxjbugkXwQimyJ44xzyiXfy2/FQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uC9/G396WShge8PFqurHGKO+XHYPs0Jj7WNtiFgPKOWoA8XK792xyM5spK1X7dKKVzw6grC0vve5LW/9ll3JSJ6h5BntcFDhdqLSYxY0Lyc3mvHCE7L2q2b6/tn2iI4d+SMVaNqw8iAKZwyHb9JevLglmf96vPvv+yd/Ndr5bw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edIF+RtK; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edIF+RtK"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52d5bfa4bafso1982111cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 12:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789068629; x=1789673429; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zY5OIi8obd7Q3NFlv2jsemU7MYZxdfFJH5GMhKYaTqI=;
        b=edIF+RtKxrpXhrOBPB0C7poqN39f4Zn5x9PLrpXNxk19Wkq21+6KZJdz0YdPoxZes2
         v/4BzBuJLvCEvM+K7oktRNoH711FrdxXv2f2W0BUGoE3lho9mL8lO0/qtxUDrRQg3oBX
         nJDdSmnFk0++6CFob3rOD6NVGyKBPZZeQu9veljCS3XvUVh6Wg2P+2lzjUEYtedY82Sn
         vY7J8thTF4o8MvJKxoBTjTB2gyPlYXOmAE2xyTOTyiiK7iKCFikldeyx/HNkZeH3CIo6
         b5EK3AkGsN45B3dKY6rdpbvfD89cH/Sm30C8VWmX0WsqfXuISCzcwKS0jenWj8iYbK8Z
         4q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789068629; x=1789673429;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zY5OIi8obd7Q3NFlv2jsemU7MYZxdfFJH5GMhKYaTqI=;
        b=hRf+FsUXylCr+zQ+sHd6yPTHlWZ0hG8RofEVpRhasJRWvPtKdVbQHirobsvdTolMo9
         v5UF11QBkcyaPMIkhbz+wfJRj5431W89rsCx3Q50695/y4DDutyI+yTSQU7D5tAOousX
         k5w+jI+W9GKaJTAuRAeQ94hhV1F6HE+WNwwem3XDSOoS6AY36SsT8rf1jle4HuNRjJ5w
         RDSSAtvq6zmZkzhuyYBuA8zAmADwdFJ0RPhp3mGzajnEFfBRpiUzTMxZAAG4k5K83p2a
         l+ShC+8fb0sQs9Oy9otkPA6GcUeSUItY0pLWdvdO92WjuR4Np/oNOQ+lRvU70oSVmrwx
         oIYg==
X-Gm-Message-State: AFuF++myFDAL79BAOIqYi+slCjvRg4U5VzMtNWlQQBSRcHV7EsSxMMeU
	XhNClf5ddBuOCRj/MWUy1cDJy4kg1i90365kq4u86jbK24ZT4SAfy6++dpeRmw==
X-Gm-Gg: AYBFou2n83vmYzEDT99guoZmZ747JUIqn9Z+hwQqnp98nP/tXvKMFiO2DUPYpY0Do39
	0hiF79/TOf58grI92WuyRR1HCA9AtnVLPE1LvVEEZ9DtEn4kk1n4tQYJeo9dlyKIrU4q9M3sByN
	f0uhqQTyXIbxk0UdUj4cD4BUYJblononh50jAYQLOmK2GtlLwhY9rnSb393kk8Ule3+Wwy7lafn
	7K6n7GsLsVqVChCdY8I3koDQRGKS1UgSk7CuL8jYrqt0RKEcGDlY1rhXBArd2lDGF5/g5Jc05qq
	zUf23REjwR5/fMaMDjcr1EQ/qftkyYa1tWEG2HM4dLsAfz8EtE1RVNWXHR0URWpKkNzZDHSAntY
	EwDLVPQlAtwEf7HwddlMeKpsdIIBhTGCyC+2+qN+E8TH74nN7bcvqKhvTuA//I82qdeohtZBpdg
	WLJoIc7P3D8hlY4XlZo0L4bNhHeStiOpHvIhvmd52i48wcTjcusCZkeQl7g9yl0VhQhTG3C95j/
	EGBzMSDXctXSEcv
X-Received: by 2002:a05:622a:1b0e:b0:52f:b747:146 with SMTP id d75a77b69052e-530c8535adamr14942231cf.25.1789068627825;
        Thu, 10 Sep 2026 12:30:27 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.238.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca30855csm1188611cf.1.2026.09.10.12.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 12:30:27 -0700 (PDT)
Message-ID: <6aa30553.c355708a.30d4d2.9abf@mx.google.com>
Date: Thu, 10 Sep 2026 12:30:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3888736236891992985=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: test-runner: use virtio-fs by default, functional test speedup
In-Reply-To: <05bba57a2d407b44212415591ffd7f4dcce4098b.1789058875.git.pav@iki.fi>
References: <05bba57a2d407b44212415591ffd7f4dcce4098b.1789058875.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3888736236891992985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1162236/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.09 seconds
GitLint                       FAIL      0.64 seconds
BuildEll                      PASS      19.55 seconds
BluezMake                     PASS      378.20 seconds
MakeCheck                     PASS      14.21 seconds
MakeDistcheck                 PASS      139.98 seconds
CheckValgrind                 PASS      231.49 seconds
CheckSmatch                   PASS      291.19 seconds
bluezmakeextell               PASS      93.97 seconds
IncrementalBuild              PASS      375.56 seconds
ScanBuild                     PASS      1118.25 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/2] tools: test-runner: use virtiofsd for filesystem passthrough
WARNING:STATIC_CONST_CHAR_ARRAY: char * array declaration might be better as static const
#188: FILE: tools/test-runner.c:525:
+		const char *cmd[] = {

/github/workspace/src/patch/14805955.patch total: 0 errors, 1 warnings, 334 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14805955.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,2/2] tools: test-runner: use virtiofsd for filesystem passthrough

14: B3 Line contains hard tab characters (\t): "real	2m9,736s"
15: B3 Line contains hard tab characters (\t): "user	1m29,570s"
16: B3 Line contains hard tab characters (\t): "sys	0m32,715s"
20: B3 Line contains hard tab characters (\t): "real	1m35,703s"
21: B3 Line contains hard tab characters (\t): "user	0m28,938s"
22: B3 Line contains hard tab characters (\t): "sys	0m7,453s"


https://github.com/bluez/bluez/pull/2517

---
Regards,
Linux Bluetooth


--===============3888736236891992985==--
