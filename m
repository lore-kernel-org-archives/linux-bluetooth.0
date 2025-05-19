Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6DC27470
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688477; cv=none; b=TVFmcCpYrMmNG9ARLXRG46VLujeJpsx/SnrBWNQE8A9qvuJ6Vylp7gufR20oaJ6H1DZlZPIud+zrXM0VXiBDoSbMuEAZ8MjZi30NIV/VH7MKpLAwv0No1r3mTDZ9QDwsF2Zgvaua01WXkhZ3eCapiRgDusb7k6UTu5yo1A2gTvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688477; c=relaxed/simple;
	bh=kCBu5rCpc8ot9D6VibOBFXu1DnkerevwOceFoN197l4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gcr+HlW/HxZdQBWuR4bMi0dBBcwHEres214euCQJZlbUaTIdnsMWcbZTXy6lzhgTulqYadtKfnQLbSPESYTkCRqhH1jIG2rwVz1fQZQ/tFQ3WJ6w3wK26/LWP5WaTBXjYzEmYnYA87nMlRk7t9/LAXbkTZ9LMO4ICpeIBy0Ym9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJugIgYt; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJugIgYt"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e7b4ba530feso4078346276.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 14:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747688474; x=1748293274; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=coqYE7yvVEeweFU/rmTyoihFiJJaTNPPa4EONtNmc2Y=;
        b=GJugIgYtyNLCWX3dYScvuesvJ2BoiWbUTCZ4gNu5VaqJceVCxTlndcdCO2G1KVu6y1
         N3w/OISEoZZS314YMhwKXMmqgPuEwxLzefHpR+e4a63EobCneAxDRsyUDiQvVulVvbFW
         cfEVCqJDsEptDaCWX6Wdp72wLtnkZry4trWj9sqxcTt3KKCWwmBgvZGGXg9VChOvdRSe
         m0mfG69CjkJJvJV406U5Ctp2nEwiHHRFHei0phTEiXq8mRmCCQy+kz04Ndsgq08dZQHS
         EES3a83aOsBrdTJWzBPsQNSUiGdCoBicSf0PnFZzqSHWA7G5XBcUrYHyRysnOYc0F8Rw
         HA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747688474; x=1748293274;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=coqYE7yvVEeweFU/rmTyoihFiJJaTNPPa4EONtNmc2Y=;
        b=wBnaeZLaJVb4AvmdbeCfvRNl5k/FiAd7ouInfkBckzN+oTa2qO5joBFlP+OpsRJ/02
         DFfKkE6mI5LP1EDk9an6UeiUSZJ1bLvDviwrl/sxVPCFiUBX0vS67XKxm5SdB0FDU3sT
         /1nuew3Z5c9nXWfyoJ9AWYseGTRrK2cTSiWfkGwWgyVjmR6AoHCGip2kHd8ARjpQo2fM
         xxJzfNdGpSko4N1IK68HsgtAYfYeNtm04JR2RkG1pzzLvs3NDIIS8c0KN4bYCbG3rNoX
         3RDE13062m2p0hVTKxbXK9dIXx06GHyh27gIIeYIM5sFbhluSMwJy7lJ6hLETurb9575
         wi7Q==
X-Gm-Message-State: AOJu0YzX3uCCL8KuXU+Kk3TnLk3jTaxXsrXNS5KMIdvBj54v6GWR9oL0
	CngmTwQpZG2M2wmaF7Ln9WFz/TJ946F1jL2kKoSa6mBevileWJhrVp59ETXz2A==
X-Gm-Gg: ASbGncvT2mx2OcJS1Z1FOpFjB8AK6Pt3H5Z/3p0s8Xri9KckpbJZeoGxBSv+NnfuoT0
	LogjCxJj8CJOR53h4YtJadUaW1PInrBjApXiXOZep6YnI7nnJFcFYuF4n5Pnfv4hXtWuv4v0O5d
	v30Lb9yRw1WeUw2irT6XmcQMbJou6r3HWTTh2jpf6j8LrtO0cHZy1Qz0ZYc0a6gbsWEF7xeqwAD
	mlhpiEcAdNaoR5m5Qc1+HS4rVhQfBXuvi/tjyb2apAEJ91PTTtN2IwGtxl1nX0L21hpgZtoPnpG
	Qru6k+aCRdvR0/1XaC0t92vgGrySU2qoXjJfYFub17kQEZypTrqIBhx/9C16
X-Google-Smtp-Source: AGHT+IGm/qd7uas5tdnXlWWbbybpByOp9qmV/hR9ynK/+XkBQzzfv/u8k2Ao7/mkIdqjArkYn3y4Gw==
X-Received: by 2002:a05:6902:2310:b0:e7b:51e6:c701 with SMTP id 3f1490d57ef6-e7b6d398d03mr16539570276.7.1747688474110;
        Mon, 19 May 2025 14:01:14 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.172.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd467d814bsm634050285a.28.2025.05.19.14.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 14:01:13 -0700 (PDT)
Message-ID: <682b9c19.050a0220.1be455.a526@mx.google.com>
Date: Mon, 19 May 2025 14:01:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4038732939997391933=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] doc: Convert mgmt-api.txt to mgmt.rst
In-Reply-To: <20250519193349.2536890-1-luiz.dentz@gmail.com>
References: <20250519193349.2536890-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4038732939997391933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=964317

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.25 seconds
BluezMake                     PASS      2754.27 seconds
MakeCheck                     PASS      20.26 seconds
MakeDistcheck                 PASS      197.69 seconds
CheckValgrind                 PASS      273.71 seconds
CheckSmatch                   PASS      301.23 seconds
bluezmakeextell               PASS      127.21 seconds
IncrementalBuild              PENDING   0.22 seconds
ScanBuild                     PASS      899.29 seconds

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


--===============4038732939997391933==--
