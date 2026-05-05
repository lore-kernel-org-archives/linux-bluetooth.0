Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B1330C60D
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972728; cv=none; b=UWtqL5bd7eTipwuVWzfezED9cC485sZvCIfEkxPF88HRlGVxBUEEKcsV+FVcdjDm8pRw4m8c57YMGbGv8kfS/Gzkpo3iOeLsl7nRpbFIyMwalGv3WaZbzsOGd89etEfNqh4bHYIlc/2934wNIq+IJUuX4DpmKM2duNCojpsdyLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972728; c=relaxed/simple;
	bh=ANFN0hzYQRLHw3g/pHAl4YJeO2fZhvOrYOe7/DRL3kI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=owE5Vh5FmtC4f7IHw46wRqkxi8lhoH3LuOdG7WhfI8LSGkAvKwRkWCvu4WNXJ+I7S6sbxzxTnY5gEdkGVawxmtjoe7gnSqdlEcsSvdMkVRq3T60uR0VdzhvQObpmbHTXMfkC0tgAxS0zr8QsO2PFg/34Ua2q0ck6yuGUARbE0Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtxT5/4h; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtxT5/4h"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-512f09ecc67so13483961cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2026 02:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777972725; x=1778577525; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+TXjypzpGG4GV5e6ID7XOeDLKjIKd2ZyvV3D0FUXci8=;
        b=MtxT5/4h6qE4995qgpR0H3oRgRwgoXk80o3Bu8PyshXboVFYhV9K4xHzNhZWg87BE5
         wxwhwg/9g+GzL8pdK60IGOR0p4gEmLyogjTlDLiEZBQCp0aTgp1Gg/udAyGvu7saL54W
         QHAXHD0CQ0qZ+GtrP1gXKrxcM7m3mH3vWbZ5LoHMyvoDVtmug8Lmi+v8TKO7wQgxgL8f
         SerZ5pTb44wNpAmrAWmEAe53H6zvyNoV6ep8diRfDSWMJ+/jzucFThaRcd3iAIJH3F4Q
         jwiHjQN65D8VR2jT0/D0EpjsRpcH4kGURTTbbrWxUoBnqNhK8IIJLwKyCWwUsYDK5KHM
         oaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777972725; x=1778577525;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TXjypzpGG4GV5e6ID7XOeDLKjIKd2ZyvV3D0FUXci8=;
        b=AQIP6jq6TldCeEnjFZCV9umkNfrRun37edbJBkhjTYWANkCDWQG/Iwt8lH9TEfJqHy
         4Pl7LJb8YJOTgQ3P5CHukBbNDGpYFUnkKdFZgURDK9t7ivPcZZJqT3t4WKqKDHIMRz3l
         CzJO3gBPSfMwkanObuCSQFF05ZVRDJPNlWLWmBD6ozTONzBqvONvvfbiacn/s879lbyD
         iE3wMH8OkyK7kb54tOLVKYxN8ZiJaTZNkt6Mxt5GNJnw2ZweCndnJGY/wC8j407fzK0c
         VNH6h6CM/O2Btqi5CSfTNyUEEg0iORQw+LCUm2n+lybmMh7GUkfpu+Py1IOWNA3c0Zex
         uVlw==
X-Gm-Message-State: AOJu0YxzgO+2pQ7LGTO2UpoDsgpPNcg8EzFBcSJ0Ux5hTsRgjXJgzhUa
	kgdGXID4Uk7L9SyhVcHyajiIAv79AcA/JzIf/Kl+4hcm84OONpuvrrONpF/ghA==
X-Gm-Gg: AeBDieupmT20Kht14oqVm1R/iNIdYjxGJNqpMCIvio6CgzaVmSqiInMuamB+16KrV46
	NQkNWq85J9TO3iT5RDCw1GWKuWgFa3TXyQ9t8pAjEniYbmsV2AYQLsBoCmyvexIftEyCqOylXdj
	ipitSC8Ru+Du2dMQS3to4KOxiQi0u23VFTJvK/L3wWMJsVHKXgCcOZVP+MVUiDDx4fevFwa6mH3
	9Tl5ESMyJaFFyEHhY1FxXHupv2sUriFQLbwlM/Qx+HAO2+kwMWhj5IIubqBaHRK+ScduIQpOAPR
	4tz1p8mvgEztUfGxuF5GqvXDaWdcc1OZ+Hwhoq3sIHEbAyeklj4CcakAc58cC6AHx69fKynkcr4
	M0gQvbr1WZtzJALjwmCf34kVgztMn353OgN7Hf55JlCXKK0gcm+ODGNWzI6v1tv0UTPUDB0O6Xm
	v+0ymJuaRfrBEqnz1GyQy78Qt+hSmAC0o1zpI6t/SNGcy2auAq7w==
X-Received: by 2002:a05:622a:228d:b0:50d:998a:2d with SMTP id d75a77b69052e-5104c144471mr188978251cf.50.1777972725339;
        Tue, 05 May 2026 02:18:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.23.163])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040b5b6c9sm119584991cf.21.2026.05.05.02.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 02:18:44 -0700 (PDT)
Message-ID: <69f9b5f4.050a0220.1d29d4.5d64@mx.google.com>
Date: Tue, 05 May 2026 02:18:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0866580005047849842=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,1/2] mpris-proxy: Fix possible crash
In-Reply-To: <20260505072958.2424004-1-hadess@hadess.net>
References: <20260505072958.2424004-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0866580005047849842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1089698

---Test result---

Test Summary:
CheckPatch                    FAIL      0.91 seconds
GitLint                       PASS      0.68 seconds
BuildEll                      PASS      20.33 seconds
BluezMake                     PASS      619.55 seconds
CheckSmatch                   PASS      324.51 seconds
bluezmakeextell               PASS      163.73 seconds
IncrementalBuild              PASS      622.47 seconds
ScanBuild                     PASS      924.11 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/2] mpris-proxy: Fix possible crash
ERROR:SPACING: spaces required around that '=' (ctx:VxW)
#89: FILE: tools/mpris-proxy.c:2824:
+		obex_path= g_dbus_proxy_get_path(session->obex);
 		         ^

/github/workspace/src/patch/14554528.patch total: 1 errors, 0 warnings, 13 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14554528.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2097

---
Regards,
Linux Bluetooth


--===============0866580005047849842==--
