Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742D1255236
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390849; cv=none; b=UP5cPeHTvoXCsMKhHn87YmdyJK/K9hR0IBml+DH4ASjKi1tSfV/9EIEEPSmJXpJbgo+Ovw4iLFUR7XWWqL+akFHAYP2YRKRUOGwiwmwfaElcf5MtUBPwjJD2HVvlUHNOoQIKKSde+PYK/boxDc3yi8FyrNQoMrJ8f1KBtSyMhOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390849; c=relaxed/simple;
	bh=/QTz6pSE6jL68mvaVvwpL+a25gc5Ve6h32DVhfuc4+4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SLBo6k57atz2PdWV8gqrOTfJstC0n+4tBB49NL6EvG4wUxLdjdgQaVCp3oAvWtBYu2gt6GU7ZgNJKiiwAK561v2q+dvndfkhBpFiE6be7a47xQyexlntutT+G4IxFkBTkxe8Uw7mfvPD32JZ0/FqOpuAdO195MVgNURt5aKUXS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuVM7pxE; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuVM7pxE"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff80290debso6764262a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 06:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742390847; x=1742995647; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c5X1KllYT9PyX4XRhtMKJqJilAJhynUr8fR4/5m9BqM=;
        b=XuVM7pxE2hxuwuycc9Aqq8c5503m02o1SgP9QZ/LRD5s/nlq5P1CtC/JWshxLlRfXT
         3AEqhkyUR06lqDwkKMNK7JKH59ufdhAgUk3BWNvgc5UsvauvXx7UmWBVXgxU0AqmpGj2
         h72MCe5KHFNLsvz2U9GXdTVYkE5Ivo/eLoHJwGaIljTSiJUsfufdowy7LZcBWNKd0SXW
         aBgE5HR0YA+uzkQxZRHy6NX+OP7+v29mgfe559USzOMGtWN473THT+D9ajpB81e2CBk6
         NW2eUNoeHXhVOkUkm2QePwtQ17fClFLnjZw99KVK2d5H60AlzvRrYk11jv2ES/YPkppY
         tKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742390847; x=1742995647;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5X1KllYT9PyX4XRhtMKJqJilAJhynUr8fR4/5m9BqM=;
        b=If+0XH8d7Ijwn4HZlk1UL419747ordD9lh5P34DvHLb3dkDYLLYGq+eXsPT8d0BoFj
         p/ppEdyrDeZ9qogo0CUvR7OAx5FC7sRO8NwHQtWQWTF74ltNoPGNp0t9/CV5e4w8OlES
         4FPTeuNmHbl6n9NI1ze76D5/L3nJiPwCwQppAD9kAmjmOVHXRJL7fKF9eL6bnS3zk44U
         SYRq1L+jl6Xv/J/szeADQ+rIHER5O8oFbmI5zmPTIpCLMsj60e0BsgBtDwHzNPE6tbz9
         RDuahXDUEztBb8JDe7lCZSonIn4+jOkMYbjAWujlKAaV2In+xT8TLSg8EVlooNtgj1CK
         nrFw==
X-Gm-Message-State: AOJu0Yy7XHlXuWmKb0Cfw1VbN5YRal1V2L9FZjN/w3y5ZGTmOTwSdllS
	FttUok9HfoEBLZ85MbR0bg3DCv0MNAiq3Z2m2JcUBwteIuckK01khKWJqA==
X-Gm-Gg: ASbGncteGqokvr10T2CrNGaVoXUd5Ri+W5fdvgla5MPpM0p6f4xSICOoHQ4r7X2BmaJ
	KxXFGaptLooEmmxphtohVYtWCwbK/9n8fI7H0xQkZ1bgwrZbOP2QCn1GsbHQ8tWcSU+b5d1GDZU
	Uh0hYuAHbixgRf0m35C+ABjD6KARSC3kngu/L+g7WqxLE2LWOxjYl/w3JZvQYTDc/kMfJErFz4c
	9T7Kk1TmcLnvF/xxLeOv5tiG9Vzpr0GyKg3W2UIK524+YAAdKp8AXOyM2nlVRnme1kTNQEd1tsE
	vlvY3tAHuapL4CLI018ccqiT++ucikTidbl3hOFoXXGw35jMH7Q=
X-Google-Smtp-Source: AGHT+IEBAtDgI4HElSXPLUeq/jPNG2NgtMiLyunAyQcWMzt2BQfkUuJ2EACXe3mfr9GIKZQCI2owLw==
X-Received: by 2002:a17:90b:2ed0:b0:2ee:ad18:b309 with SMTP id 98e67ed59e1d1-301bde513d5mr4659241a91.3.1742390847343;
        Wed, 19 Mar 2025 06:27:27 -0700 (PDT)
Received: from [172.17.0.2] ([52.155.59.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf5ceec3sm1523572a91.43.2025.03.19.06.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 06:27:26 -0700 (PDT)
Message-ID: <67dac63e.170a0220.2bd33a.55b3@mx.google.com>
Date: Wed, 19 Mar 2025 06:27:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3902511534526158516=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] profiles/avrcp: Fix AVRCP PDU parameters length don't match
In-Reply-To: <20250319121112.166754-1-frederic.danis@collabora.com>
References: <20250319121112.166754-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3902511534526158516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=945567

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.55 seconds
BluezMake                     PASS      1505.41 seconds
MakeCheck                     PASS      13.47 seconds
MakeDistcheck                 PASS      157.51 seconds
CheckValgrind                 PASS      214.91 seconds
CheckSmatch                   PASS      286.33 seconds
bluezmakeextell               PASS      99.30 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      877.76 seconds

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


--===============3902511534526158516==--
