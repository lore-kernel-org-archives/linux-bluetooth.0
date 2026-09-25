Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0F94CC62D
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350430; cv=none; b=lDUa+yJcV2l2oZHm8tUUMlc4gcuLbRUbtM3c+i9tSW4BfMEYPq5EeWhQ6BdbN35aNUvaQLvroykgrz5ZCC18B0NCVWAXoh6LRiw4D/viNxRwpkv6lg7zMhiKopfAOMANc4v5rrl4pXRNfObVLY/7/BVw9USLC8qdEZWVSKx26cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350430; c=relaxed/simple;
	bh=9wydZtFpgR3Nf614xgoyNXz/ihwezJ+ERveQQHLiYTs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=smAbWp4N/zjUdf4IzFXt/Zj40xoCI7xunnAex7eNBvFz1PHWo5hEGqTsoS/aS0WU92QDr/xHI0cVXtMYi6hUHuzwBcPdklz3pixUOOoGdzUOiaDuDfY72e7e3xPskc55YIyXpB7IADD9Ean6XoGLsTE/ptVh654UUhYzyA7yg5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8hjsrjo; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8hjsrjo"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-469fdb78b1cso655910fac.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 08:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790350427; x=1790955227; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=87DBF5Y8WIsYR+DRFrwlKaKSi0BoGrdlL2dUJZe1lZk=;
        b=e8hjsrjoZBXR/Jv1WOm56rzbwM30+bivS0dazuPdg5SpL2xKjY9ahEQuOKV8GCMrX5
         d1miT8GwQfSkLccUxKLWJrGq+9mhm79ivfoMhb/8dMH6OjJtFmBv2b60qpvywdcGrx9A
         oUg9y4B2XQYMwgAXYObtoK51WvIQ0rNefYJ9BlWVPAF91tAu+17Q/oDu+YwVpedwgIHW
         G0QMSDKinoO+g+3o6GB/6gyKD8FMS9C8v0/P+4WeUpRcQj4yZpfqwT/u4bFUADhQ15QC
         Uua3rjGiBqwAGwcwkYbI/sXlpqGKYwDXK7eJOueX8awSWz8VZ1+x/UQ/umzb5dGDFqdw
         gX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790350427; x=1790955227;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=87DBF5Y8WIsYR+DRFrwlKaKSi0BoGrdlL2dUJZe1lZk=;
        b=aU5cErVfHsJIb3KWoYtVGAt6o66Q6iT68JF0uGWCVVIVZkipRZRPsPdt/4MfZjJNNO
         UpAWSueBwA+EgfehkpxmGfZ56DcZEkcnRSlfJjp/revl8w00Ys42RjU22z4Vm5kaXa0l
         5JYu/ze09fx1v06ptloNnjRijwxUxA66ThsdR6yeWqcwlHLSonE9zsSqvkCTuSsAcPWM
         vQDva8dBSR8HQyWYXGaaB92/72D7y/Z7nWU16R0eLH/3RFhaxt1iblbPQvAVb44UbE1p
         DsO2LSiB0bUknyf9WhfKpWh35TuytuQ41bVVQXM/JkriOq0D4tI/0o1vngn2zOgFoCz2
         LLDQ==
X-Gm-Message-State: AFuF++ny90EjvDksVvEEdJtYWvLdxes/g0OvY1wQ9Er7fTVndSR8L9c3
	6FFk0djGU1XisjnDnVLEtv+iPm8NcrnAwaOyjgiSm0l/aXU8HNT9gqDzdrv/5ola
X-Gm-Gg: AYBFou2jsiWg0emOxMf7IaTqv7WejTk7nX0ryUd8ojIhaVsY0PmwSnhJFypf/ffGhpd
	Zilo+BHv9KAHcfM3ALK3O/akZ9VFOnGE0CxHiW4On5/qOT7tWCVqopBdn1yQQ8Vkm5y/SUrUm/r
	/XTOK1tbQlihmqlB+bIKwacZ7UfMccgFCH6kW0oCHGgfCFY9/KRblwcFVXkmjZMjgGXTb1H+clk
	H4gvjPKdg7uo6Kk4KejvVMr/6WGKKCy/dRiRWEoL2gGYvD4oPoBbHoRRoGpBy9J2lL6GvTT6Yfn
	Siw6jVpNcABDfKWlUhVc4LxPhC3z17hgPufC4vBZCaclTHuOKZ/rVIxCLhuhexsTEwK4Q6RfjqI
	RUT177BOj/mAbuGlurGnaRh5RyZb0fF+utzPlAPX7l6IAaOUK3yTOqQUoJKM0DX2XOPiUNmHNk7
	K/t/iVnERYpsJ2USo362DVixLdcTvqZM7ussFFKNagF4MeSfcXTnUWzHXZwX+6N8hT19+GNMkWX
	PnB+jE=
X-Received: by 2002:a05:6871:3313:b0:45e:e061:162b with SMTP id 586e51a60fabf-491e539d70amr6415596fac.18.1790350427148;
        Fri, 25 Sep 2026 08:33:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.230.152])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4933511a1a6sm2063897fac.3.2026.09.25.08.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:33:46 -0700 (PDT)
Message-ID: <6ab6945a.0c3a67b7.7d3a8.3104@mx.google.com>
Date: Fri, 25 Sep 2026 08:33:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3553104044833386428=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/2] doc/qualification: Add MCP/MCS PICS files
In-Reply-To: <20260925124942.3347628-1-frederic.danis@collabora.com>
References: <20260925124942.3347628-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3553104044833386428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1173751/

---Test result---

Test Summary:
CheckPatch                    PASS      1.16 seconds
GitLint                       PASS      0.55 seconds
BuildEll                      PASS      13.67 seconds
BluezMake                     PASS      234.66 seconds
MakeCheck                     PASS      13.01 seconds
MakeDistcheck                 PASS      103.99 seconds
CheckValgrind                 PASS      163.30 seconds
CheckSmatch                   PASS      168.78 seconds
bluezmakeextell               PASS      63.92 seconds
TestFunctional                PASS      802.36 seconds
IncrementalBuild              PASS      234.61 seconds
ScanBuild                     PASS      640.48 seconds



https://github.com/bluez/bluez/pull/2587

---
Regards,
Linux Bluetooth


--===============3553104044833386428==--
