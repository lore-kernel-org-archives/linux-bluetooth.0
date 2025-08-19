Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8041F27E1C5
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615547; cv=none; b=AzkwBS7A6C3GC7w818vuaLdoxJwrt4ayWqXREE4Z95JpOysSqSBcFu47anWs5zQ9NpxU58LyaMqsUhy2f4o2PFRcmE4TQTu3400zRQxmxTdqtXssi/xAaawK2Hu/Ha1UmATzy7qco575tlTpz45IdQZ39Ex93VHfXcoBBuW3bpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615547; c=relaxed/simple;
	bh=gEFfOftECrMWjNq2/ZYFxFfxDSCB1pVrlgUDxa/yU6c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RdVI9dCe273+3YSAFY/CMeYjcAzWWrc0zRTclDUbf9c/GccJh/7vfgihITqpbc3ntgW/U481Hrag1MTgP6N+qG9h+tgyp9ND0/4h2ABIVJ/BdnI4xnTByVluzRb3e5mIomT28PHGDDfXZAxvxV30IurTBZMGmpKxR2GTcyiciBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQSLozaP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQSLozaP"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2430c3684d1so47307515ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 07:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755615545; x=1756220345; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrsKO0uYmxPMJ4tFfIAqEYljIVi65eZpUAVN4NIFVwE=;
        b=gQSLozaPkSnliiOo2gioQqTuXmawWCRWuYefaHUpC6pClBHHw0ahUfiGVlS+EOx9Po
         yFOx3arhwoqj3xjx2rQpY4WVU3P/pLGMv4s2+2HWqGz5WUXqj1Mb74sLd/xv00GuJf3q
         FB5/57vb7A8eyEPCTI3Rh+YyRotQMcUOUtv6sXRtjlajeDC1XySxfddyG3lyqd9Vtieq
         8IVmFkRRlTsdV7XlhBUkEVTXypac1XV1GRMaGPLnu8NtB8A8Q+6Kb378lq1DUlG8Vwl0
         DvTM8b/pEuzFtD6Gpg49uKdVaHlDNmMFJ1A4nh++O+tiUAq40TYe01jbhvbuDYe6TH/n
         oaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615545; x=1756220345;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrsKO0uYmxPMJ4tFfIAqEYljIVi65eZpUAVN4NIFVwE=;
        b=QHlFpBMlcNRY/mp/ZFnphVIJapAsSZsiwuKzaXFp461y0Mx22CkCVIdzZHvRVol3w4
         Sc7XSUtzxtj28ZAoupkUyxo4VCuhmVx6CRsV8cNw75D8RH43MJS+qf/xzFKBIUv7Gaxs
         YVG2X5WyZcsj+/c9H7Yb5Rp/LpsJEl7fwFGxUWX6TTt9HOFMZvUAv0gvbZiFVxX7Omk4
         BBqCp819+rtFqxnKPhwbldtq8p2qbCElaIymz8FgqQOsyxgdJXLJTLZClMJBnKvMZ8lW
         w5czWMhXWgLYyoDOGEKuHi1HpkweuLC85AEqRVl16q2FkiEi+tTeYx7Ut7iAdigw9T1y
         pomA==
X-Gm-Message-State: AOJu0Yypo1Qtxch0TkPJAV1D/jE8k9vN2iLDf/apVJu5ywfYdI4rzIDJ
	R5ual9CIGxlO0QVJgN/Xm8Wnt1dzjt2sTQpGk2wNj3E99il8gG8UhIauIk/wvg==
X-Gm-Gg: ASbGncsggbnbfrFfe4XGJwm75ZxqAkXTmHPDTFGd9k+NEAyftRNKOcSIlx3hrrC7sJH
	xzDxd3NRDucuuanZm+snOLwKkqmfVMxpRpDFuh/YDUXRia58QiU5Y5pPHEgPIsecjTM52ldNrvc
	rxBfMyIGdTiGUshLN8Ua+Vwo4LWaWx4PGxbASk8M43Vh30aOICYqcf8eNIHuj19rkB6kokfiu8A
	IRg/fryMTEZxc9hLDgArSov/71CbbqpsdnkwXlbEW07o6CIA4ZYVrci5vKYmjp5sByX31g8BtOW
	Lulhxv0gAHHTOgSVJy+FAk8D8EUe8nXhhKJLrcXepD2mc13wgqy+qk6rismoW3drWpvNBE6Jmri
	TlPIU7b5+Mrvn2k/78f7pQL7uIFQOTA==
X-Google-Smtp-Source: AGHT+IGAyNm7XcCcT6kNgfShEABb6Zw//1+/yNvCtqdxCWNc7MyCXevAYVM7FxUiIEiC4yH0KBsfHA==
X-Received: by 2002:a17:902:e5cb:b0:240:3f43:260 with SMTP id d9443c01a7336-245e09cfaefmr39369025ad.17.1755615545343;
        Tue, 19 Aug 2025 07:59:05 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.211.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb02787sm111596605ad.47.2025.08.19.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 07:59:04 -0700 (PDT)
Message-ID: <68a49138.170a0220.2e383f.b9f5@mx.google.com>
Date: Tue, 19 Aug 2025 07:59:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3343825818953959357=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,RESEND,1/4] shared/hfp: Add HF SLC connection function
In-Reply-To: <20250819133321.382279-1-frederic.danis@collabora.com>
References: <20250819133321.382279-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3343825818953959357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=993065

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.38 seconds
BuildEll                      PASS      19.81 seconds
BluezMake                     PASS      2533.26 seconds
MakeCheck                     PASS      20.39 seconds
MakeDistcheck                 PASS      183.20 seconds
CheckValgrind                 PASS      233.69 seconds
CheckSmatch                   PASS      303.84 seconds
bluezmakeextell               PASS      127.02 seconds
IncrementalBuild              PENDING   0.39 seconds
ScanBuild                     PASS      904.37 seconds

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


--===============3343825818953959357==--
