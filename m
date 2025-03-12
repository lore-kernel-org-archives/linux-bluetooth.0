Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4619D087
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763927; cv=none; b=l8hzgvx08YAZW8tJq26k9gZ7XjwJl5nGwEYL9nrASaAB8uBMwEhqEBxMZai3RFr2mrtr4HtmXIcy8L9ULv4uf5NQj9eq64R62w5JBQlvlLuoJzCe40kDJyru9sFmt5i+61lODIhzRBu7Wc2cAr7ETLPje4HiWL6nrhIOhOsepsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763927; c=relaxed/simple;
	bh=19ZqL74Y7Odx/E+4803rRcCOqmOFIb2XkLq2BJHD/Fw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TdP05GKDDQDVO17Q4tKeQll0xIDjaZjbJYHEt6OQTdUv/b4p6aMLf4XIwJT9G/wUPt6c47CrzyfFaS9enKIs/sK0QziBj5HMLirazfp3R5L7iZok1O4f6NdNIx5VxQnyLPG2rTqmhHuRKZGGcjfa7jI3fpKTVd/dYcrekLvaIrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjxMrtuy; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjxMrtuy"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c55500d08cso209850885a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 00:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741763925; x=1742368725; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TRiccjL3C5DBVOpebPwtjekOdyQg9dAvSH087KO8hJs=;
        b=WjxMrtuyYaSbT6eB+HWye32CCkvNUXMp/cmZC/yf3HtINpxX1B5xeTruTy/A1eosGg
         lGhc758VD7m3EbQh07MtoPBwOM1IOzOlc59xSreJcS/+RKwc4cSHHTpjRHy7hM5bftLD
         yX1di4krIalMWpRf5cUHAxm+mLByxCUhPuqNBbrEUHLuziD5u+pHkfkuf6Ot/+hqrpN5
         hNa9UBjRpt8Z+rnMip0qUbHlYNmsUnVHGAq42vvG22rspWjrpiz5Dq2n5w6V4l7+bXwa
         V1fAIQ+nGdoTSzIrbR0MVrmhTIG3A4KxzErqIqwistII5o/va1d3FospdPAnByAI91h3
         RxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741763925; x=1742368725;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRiccjL3C5DBVOpebPwtjekOdyQg9dAvSH087KO8hJs=;
        b=o/vBnd4RwOyR1L6lt1hQeZBqYP2VnkFpY7laxEjjfsbVfAtm2S9hjnLPJCgyEQRK1Y
         DkwtBT64VtqZhE55BJeg5fgYr+ZPSZnW+gAWNCC8+TYh7p9fn9I2/2DnHtTlI7ZldZQB
         kEvOGqc/hW3NYftemDi6xX7184BKTC6bAgPKfFoq8u/vDfS9s0Em90oIn4+Qjf1C2rX0
         D2lYjfkm4mtX2QClCwiMjmggLJ9IRJmc+aa625HLP80DZ5m59QwU+r8mLS4U1hXdvxfR
         PcFCcMOsUp4j73tRItHxR4Rf2kYhqyr2r+sPjDRJvLy1ksNH0mEYFP6Q2ms1v7hXjiPo
         GGEg==
X-Gm-Message-State: AOJu0YwCKsvVt9BKxmRDP9iV44ZvrtAc4aNO8a8OGm9H3edeZIDWEqh+
	bzoRItBwnpn/cDunn4ebBk9YrdZLnEZoc13mQoLcJmUZ+oztZ5erxv6Oyw==
X-Gm-Gg: ASbGnctVyIxr3AkgC/KKWPBLYnE6JnUQBeqJYP7VGiuwQqlvy+SOETaGGWs/MbLT+Wx
	W1BbUZR1FK1ARk+Z2xSMb48ceeGLVmiTd4aebQNnIm/1+2JTech6OE+frg9UcR9LYZWxe9OpJ7e
	tjniQrDxAiWDCmx4NwxYzJEQ222cmiW0IxMApbhoDH6vgx+lwtSm1ei7Ojerhkqegk0WdOwLCy+
	PZTHGGrzmuMRW1woE6aZJX7Nx5SdJNeWN0pS/JZ73/uY+EiB4YT/4ItkK1Sl+1IQB0mQDfZPkfF
	LksncbFKR4cjh5V6j2PkGDy8Fl2BmfZnAoN7Ewhwkt+Rmu8Fo9Bj
X-Google-Smtp-Source: AGHT+IFoC1WzL94GAbhYOldID3lkqIF9gBLGs0zlKMZFDnPWamaqua9erjJj6BEzbtwQekTj0qoH3g==
X-Received: by 2002:a05:620a:8706:b0:7c5:4be5:b0b9 with SMTP id af79cd13be357-7c55e89a129mr906703185a.28.1741763924778;
        Wed, 12 Mar 2025 00:18:44 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.159.77])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c56a6a8120sm54859985a.39.2025.03.12.00.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 00:18:44 -0700 (PDT)
Message-ID: <67d13554.050a0220.19a589.0ef3@mx.google.com>
Date: Wed, 12 Mar 2025 00:18:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7235632933172374192=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kx960506@163.com
Subject: RE: [BlueZ] share/hci: Fix data type in bt_hci_send_data
In-Reply-To: <20250312061128.1084-1-kx960506@163.com>
References: <20250312061128.1084-1-kx960506@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7235632933172374192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=942953

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.46 seconds
BluezMake                     PASS      1582.06 seconds
MakeCheck                     PASS      12.73 seconds
MakeDistcheck                 PASS      158.51 seconds
CheckValgrind                 PASS      213.13 seconds
CheckSmatch                   PASS      284.56 seconds
bluezmakeextell               PASS      97.98 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      869.32 seconds

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


--===============7235632933172374192==--
