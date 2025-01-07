Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0AB56446
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 21:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736286441; cv=none; b=ZCM4xZJ1EFCBz1z+cIcsulL9CT5Ph/s9FY+wHFPt0JN8hFDIkVBYqjOitDIspRMrfqpZWk6ijfoa5oSjLE4lI7OfNCAkSnu0HAclkagSdEnuellaTEyJrrS3hhUrj+Stedq+GAhzy70oE7fc6YIOkLnRmO4+e9rUzDxSMN5iYIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736286441; c=relaxed/simple;
	bh=gkqErUalNVq9Qvf9GRIzjH74eJGEHdP2MwDOTWEEyws=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hts/ePKPOzvO5Lb+4hk+g3Ci2QmzIfQddSHdcmpgLsG/oR6q4h5EODor/tAKBjn0vAiymbB+CAJWevxY/5eeTN/277xD9aY8Ybm1mgN93HJ1T/AMa1+dtJe4FLlr0AIt38Dntil38Sw5dakiZFkdAdqWw5LPZv/wBqK3rO3Kvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmRtVLxM; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmRtVLxM"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b9bc648736so1307143785a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2025 13:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736286438; x=1736891238; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H871/VuEXmrhKrGbV/dBuVmjI9Z8YMhDT7p8UT6cJ5I=;
        b=VmRtVLxMMO1oFhhrt10bSavxbgzEBmBgCRBwapJ6qBmgvoMv8+oOwQev/MPN6u+Yrs
         dQo5x191RwjGLtP01dbQgg9AmDlyJIR8u528s2Ky0S20orQ/Ym+TxY42/NAXV2aO+9X9
         nYqxNTS/KS0pFnfcpvlEXEN/3VRQwVridLpVnrRBfsxr8MnduBCPCl7hSBlAon9etom4
         q5tmFP7vMTV1M5arueEP9FbJcze6e+CyS1dRoNjw2t1Us25ZM78XEqncSP+gGYyxaorc
         Lq0DbUCk5XVSAkaAoQ2s3ULfIeSuaUI0HBONIOxqx6x59Z4UwCNsgDls3olfP/vu2glv
         v7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736286438; x=1736891238;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H871/VuEXmrhKrGbV/dBuVmjI9Z8YMhDT7p8UT6cJ5I=;
        b=FJs3pbsQB13XpfUCUcqD+fdEbr9o++QYd7E7Vj8GbmVtygPuQcPQH42o/I5+asL6gn
         i7AEk76jOAXUQvMV/y/+Yoa7RuzaPPdd69zBmKFfJhoZfPpVq9zZ8PYc9nzQpTSl0ZEA
         QciDGe9QFsO777PUzvnS83Mqj3TzRJaBzvucpJIyBbQgo5XpmP5vbKCNlgeHYhZHUrFQ
         7SspxxmoNgyOHIu3yevh5nqQ9tpe8ae9kv5eW9SYMzQc2r5UaZh8B0PgL+TiLOglvYsQ
         F30Oi0ExncjbrAXpGBEAp9EPAmuW06eHNdouHOhEYTVu/+VsREf3jHD8TK2mv4Wf3p3I
         gdFA==
X-Gm-Message-State: AOJu0YzWgMCWgA9W64UphUBbET+A2Mm4aqoYLcRyR3RQPKjP3myV3sol
	92IfXGqJabKih1WgbpYFlT5P+Ph5MbjeqWA7SMoRC+ozygdEOApUAHBvdA==
X-Gm-Gg: ASbGncuVhJiz+AFNxcLBvPGZCPNYRQyl/SEwb8+ddS/EJ6VGmuNUqdAk/0VxwCAOJRD
	UyBNWmPsrY3BjoeIXbPgoNl7ZAPoDp/+e3jZ8tJRHnMM7Et0+VugFlwPGlf3q+XsjlMtK1F+Z4T
	3nPSIy24X8R+oiQi7g2NXLV25ENGXZ8Y94z7hwQYA5/y45Vr5awLhhQGBcpguWIuNWU8YUr0KRW
	xRA6g1LiGE0U46oF2xldzNgA+UbW+NujZ2XzcsxjUDNjrNeLPQReIzb4/hwzw==
X-Google-Smtp-Source: AGHT+IF18wsPnRUbVWa5fFRF/6hdH8G3VMicn3Q7b3zOCXExstC9Ov8IcGtmdwcBRCi34mokkUSu7g==
X-Received: by 2002:a05:620a:1a86:b0:7ac:b1fb:27d3 with SMTP id af79cd13be357-7bcd9759e97mr61765785a.40.1736286437713;
        Tue, 07 Jan 2025 13:47:17 -0800 (PST)
Received: from [172.17.0.2] ([20.84.127.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bb9085c7dbsm98823785a.13.2025.01.07.13.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 13:47:17 -0800 (PST)
Message-ID: <677da0e5.050a0220.239d6d.5ead@mx.google.com>
Date: Tue, 07 Jan 2025 13:47:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2071751281886959990=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] input: Switch back to kernel hidp if uhid cannot be initialized
In-Reply-To: <20250107203056.1470303-1-luiz.dentz@gmail.com>
References: <20250107203056.1470303-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2071751281886959990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=923121

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.21 seconds
BuildEll                      PASS      27.15 seconds
BluezMake                     PASS      1979.49 seconds
MakeCheck                     PASS      14.47 seconds
MakeDistcheck                 PASS      219.98 seconds
CheckValgrind                 PASS      311.97 seconds
CheckSmatch                   PASS      329.32 seconds
bluezmakeextell               PASS      127.94 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      1088.64 seconds

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


--===============2071751281886959990==--
