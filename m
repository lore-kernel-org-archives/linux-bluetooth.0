Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA9A47A872
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792150523; cv=none; b=kaGP0y21vklPwX6o36tYEm7coI6Lp1+9AyoW9SZu0wDMvt99uhW6lsTs6ozK61WP3nbuQJqHdNFXpky5+KUe+3U6nss/RHjsEN8y2DL6ZokYyJI8Pflb6ZF5NPORqSK2eVBJPJVOomRPjO6sXsSHOh6iVZ0NsvXvCaOpMJlugsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792150523; c=relaxed/simple;
	bh=n8/A+OK36nHeF741zjc08pPuCVQ4RUH9mzkh5SeyS6o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mIs8DG60VXgSqo3hon5mShDVWbk/E599b2AQuYpNbglB/P43t7RjVx8YhS/FH6pvZAKag3qx5++rcptVreIJ60T5On7IlHNy9duD8HeDHePMambtDd3prVje95ZzM7Bx2Rpyz2SAf2DV2bzUv2EGBUEiW1fMFYoChC1e1cOjbiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiFaLmGt; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiFaLmGt"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7fccba9c675so1275754a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 04:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792150520; x=1792755320; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7TQRio0hQsYBdwR7pbehvumKluM/hf96Grp82iIAU7M=;
        b=QiFaLmGtc8b8Hc23bKNa5hWtz46jSp3O3U6H25vbmfy/F7TsuDbDtsAfW6ZPWkEPVf
         lRPC6CnpwyMhBIdarh0ei7MmdYIsH22+sANhhjk0QUtws0syJso2F8dJR4RorSU4+zIo
         SSIAS2ZsXDyDJQFqcPIFAsBYAUyoOrOQWipGU9i7oFNfTW7uzgxeuNtz5MKGlrATg2RA
         41QNL12UvUGIBqpNDO+wOJaVinZYV9ryIotzcE0ke/3J5LwWowAgcwWKz4UsddPWw+cF
         IOQWCdU07zaGcEXLhelSWnI/x1PUmcJXyT5F3mO1VW1nHmILd238rjfuBQbZyra47EAh
         4+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792150520; x=1792755320;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7TQRio0hQsYBdwR7pbehvumKluM/hf96Grp82iIAU7M=;
        b=Yzzxiy6ekMdDivg1DcjfvrrNG+4Hu8+sPs3O1nGEP+GnpJbgo5GVtXDUU/nZaTnUMo
         FCW22wa0tuva44sEdgGR5j6XYET7vq49UFMKg7JOb7O7Uuhoko7xVyYq+vPvcgTdf4p9
         p0eJVvG56ap2xo4HcsyIM/SO2rIIzxxG2dlPqCWjIHhQn+nb1HOL16Y+wxlAnVeS/zhk
         D+QVvucMfBSA/Zd6R6jY5w3dXB3aOM20b/HbIxScHTXtDk/4tGe6MhZdiPMVHwKBWpde
         egp8ipITx5gh1jkS7sowGImI5inelY6r0SB7MfxRFc2eTEAvDmuhACCk2GXHyks0jVha
         pQJw==
X-Gm-Message-State: AFq9FYLBqDXacq4QRxgWKBHMxIlWZ2EKZ2+a74RDb4sawj6GUzwoX/P/
	UDhOGuQEO8Cua0+G7ktIjff7p1wa1W7HL07zUWei23CDdkyQCx7b/0gOkD6+8w==
X-Gm-Gg: AYBFou2PgzGMDY++Stku8qHWtS6YenXhuchgLZ7j7D98rrN3ciysYXmOkGdCzIKFznG
	/spIgfX+b676Ka2hedKnZaKZqoibjDhnGSja/SyCQs9wh0E50222SlqVK8UKHcOfliF2yuAnVTY
	UV5+ZEMps0cL4rKWFMccemnkG0xVCe3ZcKY+xX818eXT1ZR3lcVmn/DL4KpBKddDh0ptLuHoldg
	1OBK0xt6kEWKyCZXY8yiDOyFv9E/lc+Wt/f3ADsp0J2QJvXLvphQ+f56Jfm3Ck5ZEnS8+LsuXt9
	tmI1Ql+mZoEnQ0D9hor0HF/LJhO2C4hJe0MYfrMojq0MhaqhiAzGGgmUK+4YGScWoLmUY0RT6a/
	bFf5CkXeogqbXRK44GQtC9eDyy8+jSj9MpBG9zWHz5KnG/aMmxDyEE+NBO2enEMaoOmizT/BaMx
	tQVerwS1fOHb9TSFEheoR2kSzdn1nvRwRQbXQ/hBRfhr3ekCk1gMZXDcgNGw+dCy8lbIOI3oLIp
	cTyow==
X-Received: by 2002:a05:6830:a20b:20b0:7f9:555:1def with SMTP id 46e09a7af769-841fb4282e8mr1372996a34.11.1792150520164;
        Fri, 16 Oct 2026 04:35:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.22.181])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a111dda4sm1584497a34.1.2026.10.16.04.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 04:35:19 -0700 (PDT)
Message-ID: <6ad20bf7.95c05185.34e739.2d17@mx.google.com>
Date: Fri, 16 Oct 2026 04:35:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6105247993044900752=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: [v2] avdtp: Fix use-after-free in connection_lost
In-Reply-To: <20261016071408.2961576-1-jinwang.li@oss.qualcomm.com>
References: <20261016071408.2961576-1-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6105247993044900752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1187029/

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      20.00 seconds
BluezMake                     PASS      297.54 seconds
MakeCheck                     PASS      3.51 seconds
MakeDistcheck                 PASS      149.89 seconds
CheckValgrind                 PASS      154.87 seconds
CheckSmatch                   PASS      299.49 seconds
bluezmakeextell               PASS      96.41 seconds
TestFunctional                PASS      1125.89 seconds
IncrementalBuild              PASS      303.29 seconds
ScanBuild                     PASS      1186.10 seconds



https://github.com/bluez/bluez/pull/2685

---
Regards,
Linux Bluetooth


--===============6105247993044900752==--
