Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F521B9F6
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777106726; cv=none; b=T2n4b4KTaoABG7men3SwlRWOqplQv0E71GmmCrZ14vOGqKVxPIhK+h64PpH97AKF9BA4FbAU4Hnws1KpvWxMPNYks7on5ZqarWYZDtv0ZZL80SKF6AWCoEOwZWt+KBUiORcGFpWBYzvUBFe/VTNTxJcP36XDVHnNMFGaxpgv6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777106726; c=relaxed/simple;
	bh=0Lu3DfYjYFfAdkR7dCRpNZvs/ajF6Fu82zkoPazmB3w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PPWOsW/Cz0oHhTZGEvzvkt/Rz8d3iPTDhTZpbQqleaeYcSHAHA+PGkDpeBzDpglzNFpdvEYuSCnYet1ENCcztKpFTDmPTK9I3MnEr7OAF8lNe230Xdjh882gRlMpVTsnGejJsrfWMTR//uJ5LRTFkSPbS/cV3LAnqidd+6H2AYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jANsMfIR; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jANsMfIR"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a151012558so93498666d6.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 01:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777106724; x=1777711524; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BhSsxLJtjJjI8M3yKX085ePfX+QL9P3vI4mgWmOdUEY=;
        b=jANsMfIRKM1EVlfyj3DB0PTH2zWXXbCVgVghCg16UGHqaLUEI3wPtA3xXn51/Rdu3M
         hzgSYLwmIG2w9afwihvD29wcZ95s9aXynaM+fpb5PsdTu+zXsNrqP//8PL6fLj9pbz5s
         dxp5i/pYxYBsr1TY6o6fLk6sKm5/uq9SADDVbBwfsp8SUOsysJ4IaEtksidG+je10+91
         C6+QdXLChINMyUfHAGl1aUIQc+Kd2BPa1zCdLaszWasZc42qbCmQmp651b+QcQHuEx8t
         /F6JGsx8xvl4R3V4eiENb6yrH5YukS0JZ3qgr2/FCBBC1IjVvP1AIuPRMuMbnxY5JaVx
         y45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777106724; x=1777711524;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhSsxLJtjJjI8M3yKX085ePfX+QL9P3vI4mgWmOdUEY=;
        b=s1jqCqAjtzAk4e2ylOSzXkSaD44EWj7eUZHJWy6LxOVJrA2ybxFat7wSQelx/7sa2B
         B0vmCBvFbBcm9WyhNIkN2C34zzS2LFeRsFRNpO3YXeDz7o9HvQ1G2sSBzUXJ9d7VZNdc
         tJ6VhQKnSwcn5zU2KPkhV+klr4/fEoBQZ15yNBVDuqOEKn8RWgQ6EEd+YjkltVZWBA3A
         wJRKBneZBYwZTFZSJbMjLK45MMvYdK30NrS6asCfC5b1lse2uasNOT1y0zVwAuWagQwu
         nWSmearGyRWBVuo8m1YXzLD4lr2Yklrn7uppFCmNLQsc4D6xyDbPLB5OP7GHKNw3Jnce
         M59w==
X-Gm-Message-State: AOJu0YzKF4Tu0QBMsRDzSoOuc5+rXetTNTN1HRcKhnBNhpFa4PHTTdpU
	6k6Os9dCCyepd3l8uI0Yg6aN4rAEGHDs1lMpu513wRgeilbqWt0TACO7JP1hjg==
X-Gm-Gg: AeBDievmDSEOaAatiCQlvMGISCLx8KCt8LLWLGq0wBejwzK5EPfs70dHAaJSeY3MVPd
	g6U4j9SSoSqnB5F1Lz4NWUDjA5GcmOM+LDcYrqpwEggY0j13v9mDHvr1wn2GJE2yGi8U/lpJDo9
	uo/qOWBXhLPDccCgtTeviGkD6kNsNIxOg2pm5hr13q/cDQ3r2KzmzSMkTHUQi7EAJt0FJW8c5QP
	qGOPKRkrn2LxNfCvpcU3bYDi46UXBWblnL22wPFHoCu+KDtEolZMBgJwBjRYujSg7lTds6iKnXN
	ZGE1Anae8XBi0aaFbke+Dkhv7XpaUPB9btYqxidnIkHyILGlfEPYj2c9BLYv+9TznzfIxlch0ci
	U/VLiSlvGh0FZGyz5Rvzz5o9+kX4jupkjEqY51HWWHVJKp40cqFUOyx2y4J6kITGV0nXQ+VvWRw
	IQVj1yO6YbMaW0e0Jvyj3mG2IdaXkNHoLM71sORfOxLw==
X-Received: by 2002:a05:6214:459c:b0:8ac:74d7:dd17 with SMTP id 6a1803df08f44-8b02817761bmr517317096d6.50.1777106723869;
        Sat, 25 Apr 2026 01:45:23 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.134.210])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5c26csm216650576d6.31.2026.04.25.01.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 01:45:23 -0700 (PDT)
Message-ID: <69ec7f23.050a0220.1fbced.e88a@mx.google.com>
Date: Sat, 25 Apr 2026 01:45:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1987302437734662720=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: Add RAS Packet format and Notification support
In-Reply-To: <20260425070620.3381591-2-prathm@qti.qualcomm.com>
References: <20260425070620.3381591-2-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1987302437734662720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1085439

---Test result---

Test Summary:
CheckPatch                    PASS      1.21 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      20.36 seconds
BluezMake                     PASS      647.51 seconds
MakeCheck                     PASS      0.96 seconds
MakeDistcheck                 PASS      245.02 seconds
CheckValgrind                 PASS      220.81 seconds
CheckSmatch                   PASS      349.48 seconds
bluezmakeextell               PASS      181.31 seconds
IncrementalBuild              PASS      651.68 seconds
ScanBuild                     PASS      1031.34 seconds



https://github.com/bluez/bluez/pull/2072

---
Regards,
Linux Bluetooth


--===============1987302437734662720==--
