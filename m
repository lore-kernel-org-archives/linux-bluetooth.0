Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C660F3AA1BD
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353947; cv=pass; b=f8PoH4ZEgbz18gmLxGokTgWybPscXTyxkTds0H/tBjCh5pOM60BDnySv2f2M2zJnM1Y/X8VdqBbfEqeqaFceO7WTEK+vy1zii2aI8F1sOOFueneW9bjKyavHnlY3I/8x2ug4Toyjf2NbJ+iRh7De0IsK7NtqlJCQ5WM/4O8vFN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353947; c=relaxed/simple;
	bh=ZyR0lqxkf1kyx7I42Zbnlve3v0pv3rdi3lt2378dXMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqIDB0sLde0dZMQU7WMbhRHnsUfPhCEP/2MelqsODC2ZXF0DC/lDuxxEqfOCZA6aKjl3JFDN8U+v3mffS4gMsV1MaUs2UQrMm1o+v1va8iU0tpiuypu68We/sF20zR/JMgED4f5+QhVonRMWVHazu41LDabMAlNTEUOyNAC6l+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRvJOGH6; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRvJOGH6"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6501d242e2fso7840092d50.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 08:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776353945; cv=none;
        d=google.com; s=arc-20240605;
        b=ixxG01ejfpXs0aKT4xBMe9rzde2G+qJRodRjGvFzwvZmZ7p0a2a9F0QPFwElmKO9e2
         CXZ5ZwJ3Je9xgUkA8PiHeQqajpib/XnLdBIPBJz9lVdJO4SJ48zxBuN6KDa2BnFb2p6c
         jB6gnuldqdSPJk50+uFyyWlQi4/u2zprlVJqoGznVhKr37cU/HpE9W8K+p7AUs7QIMIo
         AACKot4EGQCd/vT7cx/1c4DC22Zxyzy0fX6nbUMP9iL3KW8+HMUTf4mrbfZRRSxv/Qdy
         NlUpIS24QTEuGq4LlXWmUrNVSXJx39a4j6HiHD49yBBA3knAVnrkGHKUzCemoY3OOcNO
         w4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xJAAji2KCYwAwJwLO+0iuEn2n6211EDndqAmwrM7tSE=;
        fh=23bX5btpwSN9kAMUf2KTA8giB20uqrBfGQFeJrgCqUk=;
        b=X4LtxuXhrquA1IRFQYRnUyThlnCBnRbkSpyJhjEZwtnWgYZDUNO5ME8q6K4x496dO0
         9/6I7tEi2xbeKhzYlhAhL/Y5LJ++3qh7yCNpMSCCoMp5GIOSj7uXANY/Jmwd9DhfGcvm
         frt0l11siK00jqFI7WZXjabIP9j6LFTwTMiXhPbKY1/4+BGUi3PR7uQgmD6ub9g4XzOW
         33Mc9tJqPEd8kcNqCu8KYjYlFuaee4ZahuFHsauUhIvH75d15CyTsjlNCqUzvww/ZJxI
         nV2ziZal36wh5CG2WKiWuY2KOB5papeE5EOc6H5y55N95GM4fRH18IV2MJROoeMC2fWp
         wmQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776353945; x=1776958745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJAAji2KCYwAwJwLO+0iuEn2n6211EDndqAmwrM7tSE=;
        b=WRvJOGH64xw7k1gUZE2JULep1DBcxTRBNfc75Lht+5znzD8iJHpY/k9bDUJ8MTl0ED
         MUL6gvv9bmOgBjFSbhrYlCtU2s0vbaVU0pwIdvQ5DPvA9BCdMzSlw6HMAFHxc/YY3J1h
         mQgHP3rPZMj9Gmplv4Tk7EwyV24OvIRNDq80qEVp9Pvi/6jIhBTJiXWkDNBNcgYlsK20
         gklJdZ9K+jDZ5CB0dVJtTUH/dQBL3pKs+9dmB7Mqvpxe/zcCv4x0geh7WKx+zz4OJVOM
         pXOLu6vRC5UVKXSYgGkVQsIsxsO7q5yXrcaa2ADX/AIdtkxybBUCwjsejRBZYXOw1npa
         jodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776353945; x=1776958745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xJAAji2KCYwAwJwLO+0iuEn2n6211EDndqAmwrM7tSE=;
        b=oFXZXZ3ZBnhxWNA24ZoEY1279EYkIoUTdcx0/7a1ZY0Q6w/e9EQPUGelmSeZc/8FWG
         nsrYMVa6dKjvfaWyUh6kYTt9xpA22PP1LYZRmPadTB4S8zV+TuXYIKeS1/Sg+xauc27D
         Vaize+1u4YFqcJOSD2UxVhx/5WWtS5+6Ae2E6mlaCVlmc3gqrk7d+eTtYFmKJxNjk3So
         nIj3MRX/uo5j0yv2tj/cCeWxC8Qqqv7T1aSwPpOcdSqMsDTCZsQPUWE+RThz/wq5InlF
         E2iUraH5uJVoafw/xdvKJO5M2YKLsmUaRLXKjvSeupDNOKCIQ3HjwbPjkf5f9rht1bIs
         3dHw==
X-Forwarded-Encrypted: i=1; AFNElJ+WaGoySjnv0NnlWHsAyIqozO81w+kkbuv0DI+o0glpXb1Zec/MkKUHcpyFtVw4VCC7/kHjH3mtnFDmolNSyUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4HvJ0LVgR4zKo879vGgJIiiM0OsxO8LMWFnSdgvgIBnWBIwDj
	RsnyD0h9yQVKdVKBHwKk+tmIARVmtjiPGOWEFYrWzZAywm2S1CK/hueIunhLKa0Omb0omc/UEPQ
	whz6HBe2nLagd9I54nQHvQ0l6xI8mxms=
X-Gm-Gg: AeBDievgH3r2IoD6fXKMT1lZWd+xyAKD/EJ46GtuUhL/sEf39PKJs6v/z8dHc8TYkoL
	ufGTDIT8yvara7ALinLKvWyxnTd9YvUQs12SV9rFMvGwsmqYMjIc5KRjxG8v7I2hFbjrz02EbOf
	fd75mOHePdWZjCotrNiCZ2Zdrnkz3rABVkbGbBj+Zn+zQ+Lzbtr6tLaccsibq5Aku3ifGCHiugs
	o6SamM8yrHO1CTmJqDe1p6utJwBkmteELOvEfWE2/Ues5BUCVw/onxeRCHUPNZjsV9+mLpfAXJH
	o/lHc7ArXtELGk+GHrKvepBsylDdWnaDZTJ70BTJge8lCbnWa7rSDUQSU0p8bkCKRysPk8YxyLw
	7/XiO
X-Received: by 2002:a53:d018:0:b0:653:3d0:f2b2 with SMTP id
 956f58d0204a3-65303d11d0cmr1347707d50.20.1776353944719; Thu, 16 Apr 2026
 08:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416152803.54396-1-venkat88@linux.ibm.com>
In-Reply-To: <20260416152803.54396-1-venkat88@linux.ibm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 16 Apr 2026 11:38:53 -0400
X-Gm-Features: AQROBzCH7mNsAX5YIem25l7xMp6ZbupifopJsJTNfvZAA5qQjFdCknQRQncW8w8
Message-ID: <CABBYNZKAKr_d62HKi0qPXAUjvG3fq9eAVuSyb+LsXtc5RtGCjg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btintel_pcie: Add ACPI dependency
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: marcel@holtmann.org, chandrashekar.devegowda@intel.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, christophe.leroy@csgroup.eu, maddy@linux.ibm.com, 
	riteshh@linux.ibm.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Venkat,

On Thu, Apr 16, 2026 at 11:28=E2=80=AFAM Venkat Rao Bagalkote
<venkat88@linux.ibm.com> wrote:
>
> The btintel_pcie driver uses ACPI functions (acpi_has_method,
> ACPI_HANDLE, acpi_evaluate_dsm) in btintel_pcie_acpi_reset_method()
> but can be built without CONFIG_ACPI, leading to build failures
> discovered by IBM CI:
>
> drivers/bluetooth/btintel_pcie.c:2309:14: error: implicit declaration
> of function 'acpi_has_method' [-Werror=3Dimplicit-function-declaration]
>  2309 |         if (!acpi_has_method(handle, "_PRR")) {
>       |              ^~~~~~~~~~~~~~~
>
> Add ACPI dependency to the Kconfig entry to prevent building this
> driver when ACPI is disabled, since the driver requires ACPI
> functionality for its reset method.
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/ad624e0d-cfd7-4521-ae33-c5c3287b4204@=
linux.ibm.com/
> Fixes: 912a499a7955 ("Bluetooth: btintel_pcie: Support Product level rese=
t")
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> ---
> Hi Marcel and Luiz,
>
> I'm submitting a fix for a build failure in the btintel_pcie driver when
> CONFIG_ACPI is not set. Christophe Leroy helped identify that commit
> 912a499a7955 introduced this issue.
>
>  drivers/bluetooth/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index c5d45cf91f88..fc1b37044a9b 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -502,7 +502,7 @@ config BT_NXPUART
>
>  config BT_INTEL_PCIE
>         tristate "Intel HCI PCIe driver"
> -       depends on PCI
> +       depends on PCI && ACPI

Good catch, I will fix it in place.

>         select BT_INTEL
>         select FW_LOADER
>         help
> --
> 2.45.2
>


--=20
Luiz Augusto von Dentz
