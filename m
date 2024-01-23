Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6470F7F7C5
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027535; cv=none; b=Da7O5obLC60p8S76cjhdjSkxvgJKjcqqUuDJJYVP9FWhXQsbC6mu1JJyW9EOdaS8ixWg+p9NDW2PEiq6rPeYUdGQZgFnZ81kOY54dps2XFRQLH6MtU4IiUtrI1cVSu9RHLTYxiqAqwWdkafwzlqe72YbbLCrXppZ+BFSaJjEf2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027535; c=relaxed/simple;
	bh=Fip854BN503xv/+xhCkkQndn7FHJMCYeNfbnPEQxF7g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CC5cDVAlit5jreyDJ6+7UO9XZWgUo8PxcaiIzQ4f/FXytZTokf/LPavS7g2WSGYQp3jSRRU/KDoeo2UF5+Lw5qjcu/H9lqOvpuMiiRSVMCB1+aXJ7t3mFCXdWIOauYI1g87eM9GTtDAi2gcU+u30ta6RiXc4z7mDWu8NoWDFxx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jc1AWMUh; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jc1AWMUh"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6daa89a6452so3000637b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 08:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706027533; x=1706632333; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CjUwCfFXE9nh/l5hsh/jsY9UjGpv5n1h0qHq2LAmfw4=;
        b=Jc1AWMUhAB20NO7my7AlYUffEhd4ptzYogAVWlgcN8Vd75jIcA/ywINZYmWk+TBikq
         ft8Xk/FZMe8IPWBfxaYx5sG2JHe01Zb2CDFJUYNdsNkVZ3HS4fIE7iy0i/2zTri5Auvr
         fP6QMi8Fe+NMis1ozNCpUhvp2WYf4WK/uByRPTgyHVbM56ntRaY0jwjzM4sZswTmU4Xr
         O6xQY0geLFtaiR8glvZHFRLbmGShp1K+YuI77WgFvbDCeY7aGQMX7fTjHmycJ4hn3wkw
         XgV7AhgyOJ12V0ynapqCvWzCQjsWauxkQtapcm01kOVazvXX2ZPyLFkc/L6P0Bzm1RLW
         EnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706027533; x=1706632333;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjUwCfFXE9nh/l5hsh/jsY9UjGpv5n1h0qHq2LAmfw4=;
        b=a425GGsGJEYMYwsbsyDgRq+4hP5MzolBtMII2Gpry+uptI2a2leqMmMOEnwrGz0Uvc
         cBBtyQxlNEQYxLECOqdNrS/17UPZkW3ZXKl+12lVCjLgIiA6wAOBNkfCdSh0ZPOd26JJ
         0VJesS6XiiMVc1GKZYi3DcEXmj5YTW7BeLSQZGbnMx1Bwgel5SAHy5THNNJc4ytRNYj+
         pSYE1vmoICxAZzXevoO5n6bMBGuFlun4Ffo4vu3L70VuytnySHVkLoXXmDNpK7+yCpN+
         hjvkFD4N8CccGJzJkdQbezqt/b4yDtSiK+tlcFBnX+ol29ejtC6nleCCIKdxJj5mItl7
         VgNQ==
X-Gm-Message-State: AOJu0YyLHsRab6iyhaHBTiSPsTg18t5XdAMZKxD48dcBAkqndvkpKSXS
	gtXjusWA8+i+1gTt0i7v6VyR3pp35vis9qHCBCc6gXD5Xi9dUgRFPZ2cGgaK
X-Google-Smtp-Source: AGHT+IGGn9SdXWiqQ4+jiHiChkLaJoVT1cc5WztJwSK/RDv5OsXSQDjG8QuqRuApj2xZ40zewUjcFQ==
X-Received: by 2002:a05:6a00:124a:b0:6db:b294:3e16 with SMTP id u10-20020a056a00124a00b006dbb2943e16mr4253912pfi.40.1706027533558;
        Tue, 23 Jan 2024 08:32:13 -0800 (PST)
Received: from [172.17.0.2] ([52.238.29.138])
        by smtp.gmail.com with ESMTPSA id g11-20020aa7874b000000b006dbdbe7f71csm4713946pfo.98.2024.01.23.08.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:32:13 -0800 (PST)
Message-ID: <65afea0d.a70a0220.fcd73.eb72@mx.google.com>
Date: Tue, 23 Jan 2024 08:32:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0079045973240353740=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] isotest: Fix not handling 0 length packets
In-Reply-To: <20240123152850.2880226-1-luiz.dentz@gmail.com>
References: <20240123152850.2880226-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0079045973240353740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=819152

---Test result---

Test Summary:
CheckPatch                    FAIL      0.61 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      24.01 seconds
BluezMake                     PASS      720.96 seconds
MakeCheck                     PASS      11.97 seconds
MakeDistcheck                 PASS      166.30 seconds
CheckValgrind                 PASS      228.76 seconds
CheckSmatch                   PASS      344.76 seconds
bluezmakeextell               PASS      112.21 seconds
IncrementalBuild              PASS      690.32 seconds
ScanBuild                     PASS      955.84 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1] isotest: Fix not handling 0 length packets
WARNING:TYPO_SPELLING: 'sucess' may be misspelled - perhaps 'success'?
#92: 
means their status is not sucess.
                          ^^^^^^

/github/workspace/src/src/13527607.patch total: 0 errors, 1 warnings, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13527607.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0079045973240353740==--
