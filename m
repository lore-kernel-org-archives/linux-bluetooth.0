Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731AD3B4E9A
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791625356; cv=none; b=C56mvKp06KF5a8msGXmpCnGGeorZP/zYTGyE08f/fKktlMr/ih09COJVVTipTVLAtWaaIlcpj947otgdRWrHhoBHD+T6FSqrB8rHqhgTY7YqMP6rvKVhuLJij1e1Gs1qV0aycoF97+GKAhyS1XIBP3wPhcnmb/gm8DrCLYhAoQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791625356; c=relaxed/simple;
	bh=/WM6fPxp9+8/6LlBukUKqwJGHU+yDchn9i3euFMxq84=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I6c3pVN8cBG4vIwbltVurfaKz/JSRkTnaCa1j5wX1ZTDIdKx5ES7P8Lnt/PrCv/mkvkpvBF/UkzaN3H+8akBA269Iq4OHkUfTIxwdMLx1P4nDLnmIiYvsIHOlp0c6wMEazCV9sDMinzdfjWHOkZZs4/DudS7AD9B17gVpd2qxjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuMcNexI; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuMcNexI"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-8256106635eso305269a34.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 02:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791625350; x=1792230150; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QP0jf5g46wmdN3Un4iBTm9Hs+/95uj3dAUGtWXiKLLE=;
        b=KuMcNexIQeZXp1+v7c0fUGzOvPBK9NGxo6c/r+hWfKCth3ecz19cESyMY782sn6whs
         eYg0shKoY6a0+4Kj3SvaTSWGo10GIUQaDzliQV2m5LdNXz6iEcDgyEl+BcbntrDBn/4i
         5Ym7yjEbd1MHpvDKX93YnnRchVizOt6Q4CT4usjwaogyJUrWh/65r4KmNc58ICGgydSf
         2tFWuJkvw3cZS4UjvgazgGGlodZTrjYb9kIzg1HrWV0q41ZHmCXscTQwcjE28LprAtat
         o9jogawgPGA/Swe/UebhM3DhzAyixIN7Waor5E1uIRYyf+bbDYrwDDyWqD9729LelXmR
         rBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791625350; x=1792230150;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QP0jf5g46wmdN3Un4iBTm9Hs+/95uj3dAUGtWXiKLLE=;
        b=cNxRw/Sa+6wHZY8RamUq/hA+1m8urjOfT/Hy2FglaSgkPd0kUKLOj2qiZBe2Nq7elS
         fu6rrKvIiSCtr/RE1q1+jSTBW9tVKu+AmiLVyWGBphC8mQIZrwk96kE4vh8Aixqs/3c5
         9CWASwV7VD8o71OhjwSxSkdKTRaqXcW/hTPzMzRutYzMlYtoQExpfFtyR0u6y59rl/LG
         sG2V/lSd+7hMYO/j+L9MDxK3k/SP7nF1ffXjFIfS00UfdOUng9rJxzkj+KeeFgrd/o2a
         y+b0d0GLMhXhTvEf7QYN1WDiEmux2ns7FhTq41hdFYzknxMpwkXk5L3q9oABcnSoS2i0
         +NNw==
X-Gm-Message-State: AFq9FYIl0cp1aoTQSrMlAU6O7yiuU5uvEzgPPyNzyx8YgVDO5T4reH7j
	tzglcbkTBJTvO3SEI1jMzMNEtHPH14T7uN+y3MNpflcfqSrSp654/sKb7OvKsw==
X-Gm-Gg: AYBFou3sLX8HA2JJUBr8tkIhMWdd/axIq9w9k0dHRqiGpgLsft6Db6usdGirNQhmavr
	Mp1vKoS6SUB2wRmwcIgxVKvxOJ3VRhGiWCOmdE+G4HP7tpWi/l2hK/n6dlSsK6mNNu9p1h16/KW
	tfVJbzMTPXBSHDOR0Utusu8Jk8dmpIp/MLsiTCKzcUfChDE7XqmryXf2V8o+92uFo9X44KsOnMx
	tkPOqDTIkulCg1MpMeoYCr2v34lMQ98CYWyGDTEoTTwq7EONRsNdz5iqyzIHTLMpvQI5pJDY+rZ
	TcTI2iq5u3gfxf7HsdhhXRddJNIgTLY3HtPMR4aHEEU6N8RgovdPMjNdAyvWxD4fY2Z+Z3AnZLy
	QBnRhc+nqTH7xilLkgdMvI9wAtNt46rM0fD+5XbMOFaqWE1QBuDKKo0jy0HXMRkyS35aOrIDu1D
	aR2R3k0BfsGYRUhs6n/vJ6pMHoXfZ1dYmAVZuXR4Q4m8Thdi7CIs58K4UFAuRhJ/QurIqUK+guz
	6UiBg==
X-Received: by 2002:a05:6830:6606:b0:81c:ab45:3040 with SMTP id 46e09a7af769-83090938b3amr3807250a34.4.1791625349956;
        Sat, 10 Oct 2026 02:42:29 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.110.183])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039076d67sm4570644a34.13.2026.10.10.02.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 02:42:29 -0700 (PDT)
Message-ID: <6aca0885.7096dace.34b501.f85f@mx.google.com>
Date: Sat, 10 Oct 2026 02:42:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5519289786770164603=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaroslav.voytovych@gmail.com
Subject: RE: [BlueZ] emulator: Free hooks in btdev_destroy
In-Reply-To: <20261010031846.2842837-1-yaroslav.voytovych@gmail.com>
References: <20261010031846.2842837-1-yaroslav.voytovych@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5519289786770164603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1182787/

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      12.95 seconds
BluezMake                     PASS      194.01 seconds
CheckSmatch                   WARNING   169.06 seconds
bluezmakeextell               PASS      58.40 seconds
TestFunctional                PASS      830.17 seconds
IncrementalBuild              PASS      202.99 seconds
ScanBuild                     PASS      572.28 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:479:29: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2654

---
Regards,
Linux Bluetooth


--===============5519289786770164603==--
