Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA5F2010F5
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689165; cv=none; b=rhPbL6RhrURgqDgaYighzSggXNnCdIX8D6XO0qM0ZIVGffje1c9OkMVO7bKhXG2JzK6mqn7ZjY4KTJFbpJPmc5w6qngkDjhj1hIOMJvK2x0To65++Si6Gqexjjj+1bXSNcyjhhHFU96MUppec0tNHLYqH6TEKjwmFeoIjIa77cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689165; c=relaxed/simple;
	bh=RPZxm/mCMl01VI2Ndqk0da9Tm3e3V1co8j/3UGiD198=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZB3qDtClc5gAJpmFaCPFBZFnoN6NjQ9T/F9sg6cekfJbVQ7g8GFoTXUp00qhcDcfWlLKB7ECFi1cXLGEHJxWneZ3aW0TO6R3XwFlhNOIvVU+EnWoRdYeX4uF0yzM1Yq1SsWpIfUDJl1YPuAlDWj+zZvEWALVTM6MCGEwuRigQQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwSZzu5j; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwSZzu5j"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21654fdd5daso102567705ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Feb 2025 09:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738689163; x=1739293963; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jXEFQBhxZzNdZgksohQpBthonoEuFpjgOZpuHGF73hI=;
        b=KwSZzu5jYJ9UjKR2aZr9vzN+VJwn2bO9FRwcYgPWiA3Ykzl01tjv5Lxij3Vov2sAtI
         989yr1AwYl2j3WDfES3sbP1mdcSVrHBg2XUBpB9TG1Si0tVZiRTtklq9ElJS07H04b9S
         CU1+BscM7juwJGHWpV7Yp9WwFc164IeN0Pvgo78+mOc17w4O1i4mMLYGGd8hyLhuF4Ij
         G364z7HmFw1O+/Rhm/PMwaQssZ5w+sx8xohZCCG8ZDQ2qiN2Bwv3AqA7bLa/V4rFjYxm
         xSrCKC0J5oQNvsnk2cGL/HRxjdlQBLvGDnrS0+eC/vttkcgyJhmMRBJxsNv6fsAU1kTs
         TqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738689163; x=1739293963;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXEFQBhxZzNdZgksohQpBthonoEuFpjgOZpuHGF73hI=;
        b=wik8Nki1L2hNHorCTGYEhrJfwP309qxQ4ahKMoj+ffQZyJWPIxS1Q2nviUQQ4EX3fC
         V929dzHTiALsvrDMJPXUHfGvzeFD2Zw5QXkI9URGQcqmfFuQQYFkbSHu9kRG634n9zHY
         CMgqDkhJGP3qkqZQ12FqhbZtnLierduAk/fJAxaXYMhI/h/hQHuJQNJK0CfySEyvon6V
         XPTl3u7VxAlDt+41v+3f6pcWd72hGt5ibbF45Uqo+BF2Fld6+t4SG6UYbTxs5C71sihQ
         8jtFURL4AOrvwlVyzLmnsHQVShAkBBS63QrbZVCKRZkR7W4vmTuls+qNQf8NIvERIhFF
         FzRw==
X-Gm-Message-State: AOJu0YzwnFyLSmuVp1NvnzXHJ5nJQ23/1ipqd+J1CvLa6v3mMzSjXi2E
	Oh+aCWptb8NQGqTvETE1LWVRji5tVavK2arWkjN1Adbfq8v9esBASOiokA==
X-Gm-Gg: ASbGnctBE7XDnWyehYYaLhqKuaV/hWZNVnxSYISWZxQl7+mBgZZnYzXidooUKqwviLP
	dbI5Ne8yOb4t/DV2jLsDIa5CrTS2xcnwNn2FAsxQgvFoSwZGSfdxTZX4F9Ymoj7yk5IDXdsl91k
	jh1ruAOzwcExU782psbDqkm3U7ixmGiS+mAR6bIhXVlpCfE5zel0WE6U/wHL6ZusSr6FYoG7jh2
	pa+fTGU1DcW04Qye6oQvjupWJvzNBhgP5BwclmYKwv/R00e91U9n8wuppv0fUWA8bJ0Ej7shCw5
	VgiCRIB75fen8EB+8GhK
X-Google-Smtp-Source: AGHT+IGHVNFH08XhBHgWDR3AT5v+m7CaUbyoSv3F2vrU4mMey35IlyAr5ygdbErFLMqyhqU6BG1e4w==
X-Received: by 2002:a05:6a21:8dc8:b0:1ea:ddd1:2fa7 with SMTP id adf61e73a8af0-1ed7a6b8105mr44031604637.28.1738689162919;
        Tue, 04 Feb 2025 09:12:42 -0800 (PST)
Received: from [172.17.0.2] ([20.172.29.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec096c62bsm10302881a12.67.2025.02.04.09.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:12:42 -0800 (PST)
Message-ID: <67a24a8a.630a0220.2d21e.0217@mx.google.com>
Date: Tue, 04 Feb 2025 09:12:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1475445842988977623=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] mpris-proxy: Fix missing line returns
In-Reply-To: <20250204155025.96612-1-frederic.danis@collabora.com>
References: <20250204155025.96612-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1475445842988977623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=930487

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.30 seconds
BluezMake                     PASS      1451.24 seconds
MakeCheck                     PASS      13.42 seconds
MakeDistcheck                 PASS      157.84 seconds
CheckValgrind                 PASS      213.62 seconds
CheckSmatch                   PASS      269.15 seconds
bluezmakeextell               PASS      97.76 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      851.32 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1475445842988977623==--
