Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E363B3C18
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692937; cv=none; b=euwnlfLt4124EdYTRbZaZJXAmQbIFMTWukUQCeHCMo8QeVVl8aOqUstAs+kJ/ixccNOJf0VQHPNuOX7y7RIGRXEXkOvQCOKdXHoNAdaOBp4OCdpC5eIoVPjfzxyn/pR6NKuefrVWf3kdHD33UYq2Q2yM55BW5uR9hrNpkQfkEeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692937; c=relaxed/simple;
	bh=+XXs75ommSNplCas7tOlPdS2jOSaky48IFCKa79llgw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bUgXG/NBGk2q16/EYoeeuR27o781ZZ8Qji1PDzwntoRVOwm2XHC9wvo9LVhxa1FRU1iQNvppA5MjiZytUec6CqBQqDPqwPiiJ8SIZww9H9DhaQgFiinJmhskh56ZJaIsn/c5xhY6OxJ1BFFH64vvKV+0t5UeVc58yzYtML2Kocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rGNuSaDV; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGNuSaDV"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34b14db40daso392922eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 07:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790692931; x=1791297731; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TggPBB6DEP+WVcep6p+5JBie4SQeZvU07J/i5CdT/NQ=;
        b=rGNuSaDVH/vP+GiQiMYmzJAwso0Pvy/5l2VNutpteRFYav7o9DBfuH2Frk8cmBUrUN
         CgiTUiOX0dAWrIaTY377w/uRld4D1Z7NTcFAhYv7Ux5Lo+FENhbSfiEEmYW3hEBn53Et
         jX/GMZwACqDdcWgJqCGhoB8SIktm+KZNAcIyazLElyq9WP2zTKwaFI2svzXD9N/LYWYs
         jRwlEnvZkkXibMxH5HK/y52JCFE8o8Ifb0ALN9Y6hE/RdZTAQYR9mWfwOstgXyD3/oyr
         ESzw0KnoCKL+yrQI+anAldSEyaJVOHmUGD7VQCOo9RLphTKtRlwBrlqPGhhY7bLZiw5k
         J5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790692931; x=1791297731;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TggPBB6DEP+WVcep6p+5JBie4SQeZvU07J/i5CdT/NQ=;
        b=PASTEOAUu4j+p6i0qr3+OCv7KQdMOxRuAmRgNOiLfjXWGMi1uWjBjYVYP+5Xh8vTpf
         vjBI7BpVyBAaSV9rkCkE64ursaRjuUkDbUrd9oOaFg53pQUJHlnF8O2BrEFwKQckWzrG
         uZg85VQBsTK2LftVhZHffN/K4nSTHFWhR9W0kWmnw2KzK2UTvDJnBikJt6ey6SysJ2bc
         OULs9SPc7F9gL3DdrlvxfE56vsc/dwQpakkvVxASccj1FGTf6I8onEBjYVgkTpWo7hjh
         l6Sgse5WyDvrqoNM6rei7wFUKnULtY6Am5YJhWPmYxTqL+jGlpDvv1LhxZ48HzHksnvg
         +5JQ==
X-Gm-Message-State: AFuF++mp62Xf6pNVP9IoihUe+kdDkThhFo0s6lgXEePUvwE5tdcJrgyV
	bihPnrV74UtKxN0up0vI2L3P2qszWTGuJNy4/k9mG4bzzrfCGDtK5Iap6/xTKQ==
X-Gm-Gg: AYBFou0cW2b+r3S59vAOBSybl2yr0gLYyIaMQTU0XsXyOB3cwKz8MmXsZrcRHBH71bq
	nNqsnIzqdJsf3DdIIZowz/zavtF4pOrnpJFqG6EOcvjuyky01+wydevh8GpB4mjSA9IBCZ2EMl6
	H+pwoqMIGa14nywGNUKoqlUFFYqfwM6xFhZV2Ff/+F6mm3V9R8LSipRhPHo4I1ZSU8rfbEZ04wS
	VyQY+nCOLCNhi2jl/TzkgKYpgGBLHmNQSkpPgX8uYYW4k0wilHjyyebQdt39e/0W8cJ0XZOnsWY
	njjb5gwTHd5xCr8avUNsqed9BGZD9uKntpVM5UDV6j1H94OpDahgCF/HRZOhlnxkkg+dYUyx1hZ
	U4PNJU6pj6HWPe/vX3t8KgJu7wv8aQeJEnW12cj25HJBGbTgZLygiMkdBy/KT96nSFTHpxocdHN
	zr4vmlwZumI4GSYeuyCUuVk3UWP9iWA7/4ZL7ZGf6WLjv13vvhoU67ovgXuFOub1bmi3IwkLAmR
	NCm
X-Received: by 2002:a05:7022:4582:b0:144:e259:b1f with SMTP id a92af1059eb24-14b2bb99e8fmr5252819c88.13.1790692930595;
        Tue, 29 Sep 2026 07:42:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.99.202])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14c634f07e9sm68523c88.6.2026.09.29.07.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 07:42:10 -0700 (PDT)
Message-ID: <6abbce42.48d69adf.32c74d.f956@mx.google.com>
Date: Tue, 29 Sep 2026 07:42:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3466790818953060598=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: mgmt/device: report link security level to D-Bus clients
In-Reply-To: <20260929101953.254969-2-frederic.danis@collabora.com>
References: <20260929101953.254969-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3466790818953060598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1175995/

---Test result---

Test Summary:
CheckPatch                    PASS      2.24 seconds
GitLint                       PASS      1.48 seconds
BuildEll                      PASS      15.89 seconds
BluezMake                     PASS      283.49 seconds
MakeCheck                     PASS      13.77 seconds
MakeDistcheck                 PASS      113.89 seconds
CheckValgrind                 PASS      181.53 seconds
CheckSmatch                   WARNING   218.18 seconds
bluezmakeextell               PASS      72.32 seconds
TestFunctional                PASS      900.54 seconds
IncrementalBuild              PASS      336.66 seconds
ScanBuild                     PASS      800.94 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2289:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2606

---
Regards,
Linux Bluetooth


--===============3466790818953060598==--
