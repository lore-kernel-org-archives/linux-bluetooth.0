Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525EC155CB0
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722268188; cv=none; b=RvYZ4ULKvYUs/TmaYky93OYAJcenUTww3gyAjnifpWhN8j4mlu2hvFyO5GunApPLa17iqGWv0GlcK7mPhTtOeDko8ARhFo2rAIv4jczXmprsNrxSKnDcWJGhuj8Of1t8i9z12bUfaj6mFQmowc5/Rm4PRkwMDTO1WAfxzIK5ZbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722268188; c=relaxed/simple;
	bh=/MxvJRIOTpaisqQ5VS8y812OOricyEl4+mPRJINBr/w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DyBfqltgQV/UpwJJhR6/L8YW4rRXsoPpSDEq+0qRAMiQIVU85k37uAIjfajpKhpczfcsheob7G/mRuztm0Qfd8v9rbPFnzTMPEnGhS66wMoCq5rDuX0yb054HPjeO4HzOScM7TY3UI8PJeWqNXGpAudj+5BASVKnnd+nwZxPj+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QC13Pu16; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QC13Pu16"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e026a2238d8so2100262276.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722268186; x=1722872986; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j+vh/dL45prkfTXERsvtl6OfPXG5uLbs8o0SZu1Z3Ks=;
        b=QC13Pu16QJ0+HqMpA/a5SuOcPz5mJ6d7U6/eu/tr9jcM+HH7gE+cON/1UYy+FvPfjb
         4wpFji9M6JurtFcSRMYIy1qwU0eGT4met0ZxcW8LRfYJi0jAIS6hXlzXRjjZbZeS0NLq
         evbTjs3hOg6CzrmLMGJeu5kLNZoRo8A9ySnVl5eIpzViHq7PwKK7wwJ6SQdpNrSHrAvt
         qvTBSfOHkDJfe69DJyyy0zK7i1R8R43IDJv63yJg+ru7hCJFYYp+OzBueZgAcDDcG99u
         dSxUgPWQgZUx0NZAgZkaLQgLvqX/EI2MAH9wKTSEOzN5bs+uLkfjo86ApB1ZDxkoH91I
         II6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722268186; x=1722872986;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+vh/dL45prkfTXERsvtl6OfPXG5uLbs8o0SZu1Z3Ks=;
        b=LcG84wrGUlvCkzbNB3PufyZ9hXi+4RGW+t2cKZgx0JUvDWbf2x/GyApDkkO/iSMYnK
         L83SuCIft0HA9TU2HwT9NdCGB/t1Cm3L2tiTS+penWUqN2rkz/xtgWk+zRwsobMdKWcM
         9fweL7yoaf7mx4FvbvSxDS0FlfzhfVyXkabOpaLDDoIEN20dmpp9m1u/NDzsdo9p7nhC
         R7XsE5qT85vvGdlJ+5LDx8I1v+zQGMXSRYTybe2Z+Xfi6Syp0ybPLOVFU4SYiDsw2XYd
         SCBsbdsiA/Pdn6o97zt9mIAjgOgmufL69plq5fYRzy+eWLCkfd/+nE7mF6ayR8zheun1
         +kXA==
X-Gm-Message-State: AOJu0YybWMvS0m0DkckJdLSbVD+zGA4ncQH9SfpPiBI69SH4Ux3fPXZD
	C5SSBsJLwYV76NrkO2Zp9J1Sx/dtHQZ7bA0Llx9VGhkWaXUiZxEt22UwnA==
X-Google-Smtp-Source: AGHT+IFp1tXDwV6p50GdVds9gsDkokwfWAWsFTsmd/uea5Xn5PLCuwPqr4S6ZPD3BOE2d2taLFmgwg==
X-Received: by 2002:a05:6902:1b01:b0:e08:62e5:8d6a with SMTP id 3f1490d57ef6-e0b546349f8mr7214881276.52.1722268186199;
        Mon, 29 Jul 2024 08:49:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.206.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa94e63sm53522486d6.76.2024.07.29.08.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:49:45 -0700 (PDT)
Message-ID: <66a7ba19.050a0220.3b7982.f482@mx.google.com>
Date: Mon, 29 Jul 2024 08:49:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1624479231672856467=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] client/player: Fix not setting config target_latency with edpoint.config
In-Reply-To: <20240729135705.172810-1-luiz.dentz@gmail.com>
References: <20240729135705.172810-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1624479231672856467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=874593

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       FAIL      0.57 seconds
BuildEll                      PASS      26.23 seconds
BluezMake                     PASS      2017.64 seconds
MakeCheck                     PASS      12.88 seconds
MakeDistcheck                 PASS      181.94 seconds
CheckValgrind                 PASS      257.16 seconds
CheckSmatch                   PASS      386.98 seconds
bluezmakeextell               PASS      125.74 seconds
IncrementalBuild              PASS      1613.76 seconds
ScanBuild                     PASS      1045.75 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1] client/player: Fix not setting config target_latency with edpoint.config

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (83>80): "[BlueZ,v1] client/player: Fix not setting config target_latency with edpoint.config"


---
Regards,
Linux Bluetooth


--===============1624479231672856467==--
