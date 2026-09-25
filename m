Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804534D09FE
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350672; cv=none; b=GTwklWAdmFap7I3R/xWVikVM5/+K35HTHj96SP5AgLhJ+oCmWq2AY2NIM/UhZOdT5PT2F8dLRjc9DwPC2ZWQV4tk/eKAGv6bzgO0KolKJX4miz/Dd7IgozXRFudfVep5YtaiVzpjyJ0I3CA73FEo5FxrccXUR0h5QWfhSIjO94k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350672; c=relaxed/simple;
	bh=FReheuNW8IuNnfg1UCyHvO8qs+H+7u1gpZxLjGY5RKQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NgJg0DMmRAuSobNOpugWVkSjLSqHYCmnwzBQWSzGJCP3O3+lrnJNbc/RxtF4bP90nqW+fpyWZKkAyexUe0IJBr5C+wbPwUGXJnMYzZHBVWPtTpeunBRsKY38SSp/ON7xrdIqrFwuwueOeqL/EExNTqeXrJIKn+QHG3v7erQ7z2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kH/oT+/5; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH/oT+/5"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b1ae6f5fc7so740524eaf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 08:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790350669; x=1790955469; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dDzxe0JDLlPn5JAM9nQwQul5Vkq4XoYHrzaqPF/jgPw=;
        b=kH/oT+/5Owr0Ul46sL4wSmQhQcnvakyO2MLeJBFM8gq5mmK0xjYifBQcOpHMMjKeoo
         /VwKjMFJF4IB9TI8Z5imtDiweidvdyKdCsbm9+oYWaHEVaelGpLBlmBeCuB3mVixVjWy
         G8fpmryMzYVxydIoQAFjhnGrBZaIq0mMqXvJCtnaRexQGl0NIWXJKoeOHq7i4MMJwdSG
         JvLNV/ASZVL1kJAeLjkY1nleanAry8qRzaPOl+FblVlG4Im1F+2u9cUC4TFbbcaYc0Za
         vVmBIt/8rHdVpNW/rBX0ugWQeEavTcvYyqJLk6rBr+LGOpt5/Gas8YyIYyMcdidTAsZq
         0QfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790350669; x=1790955469;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dDzxe0JDLlPn5JAM9nQwQul5Vkq4XoYHrzaqPF/jgPw=;
        b=RZcRRSXLkGYnOw9nuk/DSedjDFd7wbR/l0eYK4Vfs8BQDF9T9dk6nQ2+uqxmIZsxEU
         Nm3OCyIcjelPv1H+9cJz7aKvyPyuPttiwX9iUNH4N4V4iPUECRS+Irk80JXJjtTiVD5D
         xV3+SUikENiL7xuuK3jeOY8OtRKVHQI6aw8y5n81rxqgA85YwTd0lpm0V3kxNPsbHezB
         VuMtQZ5hXFaCj6TawcQUdRCpiew2HwAuHzIESp0GU9lgEWX4D6zBT/SbG4d6UIsMonN8
         2QOod3R42LAu8vPuno+xaCnhc1pOHUtlnfpYAUk2zn3FIlC4O8JGHFPEpTyXBXdSPYAI
         lGrw==
X-Gm-Message-State: AFuF++nb7A6Vzy8LxioSrGdXHjYbQykS+L0qw0ndF0mAOl3sHjKK6Z/y
	WQ609Ip+oDgvj3smRYLE8zLzTXnn6n51ByFRVKx75Fprkl1lNUOQHRnkgl6+r84C
X-Gm-Gg: AYBFou2IoGkSzRRPC67Y86aOOUBjCBSKsP8rgT4b7iRGtk0dhEmW3KWjMf+x8Kkv6/1
	ipOR0rjhumkwp5iRxQrV+ubYjLaaft31Dq7mq8Pkpf89Q15NW0cHRhbI7NYQq+PzP3+m6oiLoiK
	Um4+waN/JUaY+7Y4HKDMN4lgTkiHpC9oJRn7joptxArPpxyC+AYsqkDq6OdZSlFwVjsAhHqKdWb
	N/INRcoxdx/0zzCTtDTyfBSenN5saH16S4FU80tWREEy7TdjnTsZFniRThDahdZpeEP0raK5nk0
	wYfq5lcBjU7syJ7A39tsrAZYZew7Xayv+WwxHUa38f2TZdEOzee35qjgL+C5s6PVt/lltn4gg0G
	lKAPOkUpE2xP4DVaBmrtJZf790jIQo4ORYbUdldP8KtiJ8wLcH1SzMpm7UEonWs7ALngyoizMQG
	Q4c+nS4+jm3V+RGiH4C5BHJESwVG476xbyaQ6ZxOomj1mibsdyO4/zqjgTx4fJPltI467T4CofU
	orjmWE=
X-Received: by 2002:a05:6820:1ca6:b0:6b6:f16d:d672 with SMTP id 006d021491bc7-6d43f2c5a5cmr5672372eaf.16.1790350669137;
        Fri, 25 Sep 2026 08:37:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.230.250.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d5e68338a6sm1839281eaf.10.2026.09.25.08.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:37:48 -0700 (PDT)
Message-ID: <6ab6954c.532183e6.7e439.23ec@mx.google.com>
Date: Fri, 25 Sep 2026 08:37:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1855432093885785918=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: hfp-hf: Enhance HFP Hands-Free profile support
In-Reply-To: <20260925132528.3361517-2-frederic.danis@collabora.com>
References: <20260925132528.3361517-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1855432093885785918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1173777/

---Test result---

Test Summary:
CheckPatch                    PASS      6.13 seconds
GitLint                       PASS      3.33 seconds
BuildEll                      PASS      15.61 seconds
BluezMake                     PASS      266.51 seconds
MakeCheck                     PASS      2.79 seconds
MakeDistcheck                 FAIL      35.64 seconds
CheckValgrind                 PASS      119.94 seconds
CheckSmatch                   PASS      196.93 seconds
bluezmakeextell               PASS      76.02 seconds
TestFunctional                PASS      879.40 seconds
IncrementalBuild              PASS      320.00 seconds
ScanBuild                     PASS      773.86 seconds

Details
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

../../profiles/audio/hfp-hf.c:47:10: fatal error: hfp-hf.h: No such file or directory
   47 | #include "hfp-hf.h"
      |          ^~~~~~~~~~
compilation terminated.
make[2]: *** [Makefile:9451: profiles/audio/bluetoothd-hfp-hf.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:4322: all] Error 2
make: *** [Makefile:11113: distcheck] Error 1


https://github.com/bluez/bluez/pull/2588

---
Regards,
Linux Bluetooth


--===============1855432093885785918==--
