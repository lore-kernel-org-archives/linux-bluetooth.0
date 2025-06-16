Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3552C136347
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750102322; cv=none; b=hgGGeyS0x5ydakimTX2EeLW9lrsFc7q0GFiSuE2fvkK64SO72Uziz6nDjQLKZ9qBAeuDMa50aisXTeUIiXDOI4rkeIgmYRw/9v/cO4NDabQlgZgd1qtXe/PCwLZhGGudT37cVHLfM949p7Y58EqAm6Meii2dBbkHhc1oBXqGEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750102322; c=relaxed/simple;
	bh=J7aIeBQ0+TZx+QKdifeV4VqeYag7vBmJUXhNHer+Ab4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dCvndAqj9z9oUR5WivLb7S5l3HKIcyouaPG71Vb25tiicobH+50dN/hx84CdvSGuO0QnkjdiFb4Mc6BUiznaRK+T+VKH6WCSi2i5R/jZd76yZVrmlnWdLR6NKhUZw+GCyTgJfzsuzhl1mhjB4mB++N7POrCfaHvNydtOfxxemYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+YppFKV; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+YppFKV"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d20f79a00dso709643285a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 12:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750102320; x=1750707120; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pkzGAXRrrY4WVFLuHJ3YPk9V+yVYMlcMTew/28//9xw=;
        b=T+YppFKVlMpGBTukdtzxkANqjIhAoyOZ7uzdyaSPedzdGgTef8N6RX53+8YUlIBLJO
         TeZ58DzBlQP5rYif30R/6ZvGH6+5PTecvSk825hhYcpmzhaGxlGu79KG0Cmnf0itWMi9
         fJE1JOf8kuGDeKkzhad0SbYy/0e6oUulFQY5F2Bs59IUxZ6QOlRUDT5KI0uj54WxsX/h
         aDGKBpr83x42/C7Ym5XQiERoLhPpQk0DEWCkPwXBxZOrYUS8XjI7UgZL2WAjKoqEmuw1
         Fc0nKaoKkzOAGa0O9xAmri4Tt8NZhRyD0f/bXCiNSj96Ni9QcnNFMXMA2SBzDzRO9ii7
         43nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750102320; x=1750707120;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkzGAXRrrY4WVFLuHJ3YPk9V+yVYMlcMTew/28//9xw=;
        b=ilpe2LZrrmzoXb33IjkS4e2rxAuZ6LPItzKep6UCdLWwZzo6wEuD44xL1uPjzRrX3D
         SCvlOpBkEqUPgpga24/qmRbZG5sdXU7Or4RLR8FcdEKI9fhWBdABXcFZMpb6Lge1B8Ug
         y6mfQYnf3Dh6sRxLvWxnAtrHzlyKh5DwPYi0HeOmHnvJmDwiymShCCf4W5UmQ++mbpuo
         4E+Zm9Ea74Y5CnUFpIbvq3oanY8l8bvtKqliLzk+wF1sdNhU7JVpkiM+Hhhe1dzrwfi0
         MAyY2x8k9PzAOZG/aeSuby70gIwQPxE1UMpo5HcifLybSXU4ClmZQYDtoB6Hbsib+a6V
         6qIA==
X-Gm-Message-State: AOJu0YyH+z+w/sxVbAyP9J/4RcBliJjuWkyW60Jyvs0GYJsguQDh7JYZ
	VhSmM3JsT/fT7pUBMBkAF4p2hiA5O+pob7GUfoNRITadbv8yaz9lED3R8V5PIthI
X-Gm-Gg: ASbGncuo1ZA0p4gzA5S1FvrU3GGuOOlXPiLV3LLgLKVk6qG1Z7KN/V5VHFp3Q58K3/T
	asuPUY7tmwqzx6qBB0T1jlfyIU/PEmI90ghfIdlOlfL/v3Q06UMQFbTAzaEOCEJitPuC94Fzzfg
	moIf7ciuZnTdqVp4OwFaLRX24vmDBgNJ2pFcr59Bg3xP8O/eTxUfTci9qFBT/n0slBh4MrNi/RV
	Z87r2SutVbAFvuSnRAVebUjoza8nD+Fqq8x3mWe2JGQTZjanzo2XxwMXv6noq31A/rs08kRk9Vv
	iOqNhLB/e5EOdsONhI/iCg+G5A6xzq6lXRJIF8yLGD/G8JiVl1uHDw50ti/OG1mOLxop
X-Google-Smtp-Source: AGHT+IG4hN5iLhrIMDZK/VVxaWU9XK+Cqb7yTFQcsJapQQNFJ2nWJsWVRpp+CP92QkwDeJh1AprGpA==
X-Received: by 2002:a05:620a:3728:b0:7c5:a2f8:e6e4 with SMTP id af79cd13be357-7d3c6cd9f30mr1452995485a.29.1750102319833;
        Mon, 16 Jun 2025 12:31:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.242.107.38])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8eac7e3sm562511285a.63.2025.06.16.12.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 12:31:59 -0700 (PDT)
Message-ID: <6850712f.050a0220.3c0cd0.6523@mx.google.com>
Date: Mon, 16 Jun 2025 12:31:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5203499168091421106=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] iso-tester: Fix crashing while attemping to access isodata
In-Reply-To: <20250616175511.2608985-1-luiz.dentz@gmail.com>
References: <20250616175511.2608985-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5203499168091421106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=972634

---Test result---

Test Summary:
CheckPatch                    PENDING   0.19 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.42 seconds
BluezMake                     PASS      2687.36 seconds
MakeCheck                     PASS      20.25 seconds
MakeDistcheck                 PASS      199.47 seconds
CheckValgrind                 PASS      274.74 seconds
CheckSmatch                   PASS      305.47 seconds
bluezmakeextell               PASS      128.43 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      913.67 seconds

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


--===============5203499168091421106==--
