Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A70E38654F
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791456073; cv=none; b=fNa8Zeug7imNNZc2QqWfwfT9n3nD07EJaOw90OcPH0HGDnQuMM5MBSkvH6uy8DnvA2PTq9/Mvxthry9YmjbM3msDsf6u73wCabyB1CKudL77+DLh6PWH+kV1+bc4GJ83BkJvPXYVcXXa1zXOVKRFe8GVFyQM4Fl2VLyvHiZUFIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791456073; c=relaxed/simple;
	bh=FjVsbhof2JOqF+i1SwqjBq+++B+GYxXe6ebFYeOmzDI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EvMCVaQwb4WmDx1rH7NyrgAv6YenL+FSFuMKSRzqQEbg/xJW6GbEfWHMmKaeTMJ/vBWbTZxgNs/wUuvzWBAqtnEl21hLnXXCFpbTxzPmIkifuz9QHPfluNjr8TUg4FWC6lAaPnBaz9VbClcG115zFMJhOkTgVrw1XaNxyQQteFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSbxV2BL; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSbxV2BL"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8266c388b67so2668647a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 03:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456071; x=1792060871; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iHVUwjsPT1GAcodOqosXrhSQ7MLLpKneN4Zn2JnVAZc=;
        b=iSbxV2BLzDuO1uzaArMo5xR6N7YlfkIKNmD6g65DhRAI7cL323xTHdHOcURqUXfJy3
         Sfw1Rbyi/t/rya8sbb5FP8EIr6mokAyhZ+kc5w+3G2Yq72xa6e1GXt6l352BM8i7HRmx
         SMrvu9yenAVGzgWLotUO3Oye3UaxBbNdoOAhIlT+qPMyTISNWHbmnOJbgQ0NsiSr3Eit
         qRighmriT6rHQ3faAkt/46+zj8fnFqq0iLUQRGHlSCI4iGiWPHxlHzZFywfiBpgkW80o
         aaLP5CTfDd5tt0SBsbAJTvx6I9NBJiWkoaFeU5zSNFfjEWrNHmnJMPHKEXg4Qhzlbhp6
         40zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456071; x=1792060871;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iHVUwjsPT1GAcodOqosXrhSQ7MLLpKneN4Zn2JnVAZc=;
        b=rGwtZkImC3YCdlVqrsa/DL5qeAkccoBK+41eL4u3YthQYDNTQfnfMca4RC5WmknFHA
         pWzowARxTMuPoxxcBmatjiLrShQP7I5smOxMuhZR3L+tX0uSM/0GRbJBhLubQqfMaJlD
         0l2C374YoWbZ20yRYWq0UWVsN6kaICnOeyezZIfezudTmbagqJHXiqgr7Km5usm0vnZG
         357FJwQ+A85R1AYFBE41VEe1KNevSCrk8Kekr9nJ35XDpoFPZRufrbkzUt5anTwAA3r7
         GVZ0bRqmXcbUGraC6PMXSk654eMVg+mi54t4XpWmplDkxcEbMXOHGfKSlM8Y9nYblR+P
         wgbg==
X-Gm-Message-State: AFuF++kMi+4ZmpT5DE+7hRvoKy033dlDFVBSGgdgVntzqY4bZ5PNkuPW
	mBp9EkLtErq1Qe7zpbjXgd6cy/6b7878aDICktat9/sVGRNf5sDTXi0Orq7TUQ==
X-Gm-Gg: AYBFou3ZVAkj/bl1uti2K3fSidl6IC/w7CcXY7lAaZI3IZTjRu1QZwgThCwTQ/rCVzr
	+US8J6pc0a9Tl4M1llXvB5hSUdKIkykLNfOwca/cxPGh0quJxD4zXKaGi+rBZveXPcctoW8LdWH
	Eq8kGqjY9AA4ielm4F2oXDoCWZfc+KrDCBm0xOgzUXfrvw9NASdulpVb7UC12Ji5kg+dUiqo2Dq
	Ea6jvlIfh7MunEcoptDCoN8WS0Khx0KbNvdmwMy8Et8C3NVYdTSYujF/OSb5cS82Chre8uuN3tj
	ffgcvDqWofZB6zl1vDmjSXE6HeZ8VCKsummbH9NsKQt6HkKg9Q/8wNFmimvV1MP1nB+4HZ/ozUa
	ypkBCqNzZ0k7kIoZWLzjuZ55wdPybBubVNj7kk52H5HrWhJ/TkfJSM/de2XplLNgGXGV/QiFyEP
	ih+HpbZ25+95BqtJQSxzzhfdjzMDzXFFFjhm/nHyFyK9lzMUikZaJ503fEtkniTAiMtcWgpnzzB
	zM=
X-Received: by 2002:a05:6830:6f4a:b0:817:d181:3fa0 with SMTP id 46e09a7af769-82ad01b1007mr5933733a34.13.1791456071045;
        Thu, 08 Oct 2026 03:41:11 -0700 (PDT)
Received: from [172.17.0.2] ([172.171.7.0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adbdf42a1sm5779245a34.9.2026.10.08.03.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:41:10 -0700 (PDT)
Message-ID: <6ac77346.21d6536f.3d68b1.a5f0@mx.google.com>
Date: Thu, 08 Oct 2026 03:41:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8586764869734064183=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaroslav.voytovych@gmail.com
Subject: RE: [BlueZ,1/2] shared/mgmt: Fix notify leak in mgmt_unregister()
In-Reply-To: <20261008034102.707451-1-yaroslav.voytovych@gmail.com>
References: <20261008034102.707451-1-yaroslav.voytovych@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8586764869734064183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181228/

---Test result---

Test Summary:
CheckPatch                    PASS      1.10 seconds
GitLint                       PASS      0.60 seconds
BuildEll                      PASS      20.38 seconds
BluezMake                     PASS      393.18 seconds
MakeCheck                     PASS      14.47 seconds
MakeDistcheck                 PASS      143.40 seconds
CheckValgrind                 PASS      235.53 seconds
CheckSmatch                   PASS      295.17 seconds
bluezmakeextell               PASS      95.34 seconds
TestFunctional                PASS      1142.46 seconds
IncrementalBuild              PASS      400.96 seconds
ScanBuild                     PASS      1150.52 seconds



https://github.com/bluez/bluez/pull/2634

---
Regards,
Linux Bluetooth


--===============8586764869734064183==--
