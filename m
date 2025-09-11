Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0004E2580E4
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586447; cv=none; b=Yt0Rn11MSeufK8B7vW7SU946yWmbYJmiusE2/P7IEKnh4tAvNqbfwjbDQ1149x6j1GryyQFCoEB7XpaSznuF1y+R1S/L3xidYu9p3ba7Uii2EwxrBSS3A19nD9gcUH+Kna3+CzL/rBFtBUSpMP/lqauxBgSWd73xaVRJdz1/c/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586447; c=relaxed/simple;
	bh=Tpy4ickjdhJAzfF7JuSSTmpsyKbM8CngMtPyuvm7yJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDmc3eoFpQhxtvIAbP1WXS19eYpUNjljtT7AN6IwA631hlVrrApbrIHrlFjspIt++SYCVXVYy7QNrNok1yGVFy4xe5LnPUXb+eSYUjhEgGGsCcH/CsvHe6RcXSbhj5iNXaWLe+uJR9nwRoKYkqAi56FalTZ8stpwpnryrGF6JKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBxOZIft; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBxOZIft"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-32170a988a1so446228fac.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 03:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757586445; x=1758191245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96fqw7FRePezKm4ZHE0s+atlWdvNKcIU7VIxvyArpWE=;
        b=UBxOZIfthuV7sVv5+eUIT/+p6yEZDTsq637ffZkWQ0fdZaIzM6BDgXpjJe7Sb8L2wt
         J+HagiNkKkL3uSm8MSs+9c2l89XUhZiipInoS4PrKgigZ24W0OnyGCW1xJdi9BTZaXas
         imBEtY54WLHPlzwAVOWd5735Zu6oFI+rkfwnZBcNZZIoZ7vNkqwLCP3rGEmdkuOl6gcf
         twC1PVv1ZAMiJV1zRyZZdGKzMZYpul7bhfvhDzVgRz0JP2SytqBrR0nf+XnZ9Y+NqzY0
         r0OxeKy8kSGTePAmDThqRRUC/Q/U3U3RQs8jqPpcK8K9xtP/cgwPHQUePBZ2vKEXP5D3
         +bIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757586445; x=1758191245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96fqw7FRePezKm4ZHE0s+atlWdvNKcIU7VIxvyArpWE=;
        b=GCE3azcVKmDUdNoT5O3rji5MKdIvx5RvsYHIOL95sOj6tHWv52LVyYplhhUczM1GAO
         OGFQo1nerKlr9o9rL/BLSlA/qfoyKP1dvhuZZGdN1T9xPbCb5X/BxIUQo4FKN8s6LdSM
         B4lqrRKdcu0LdQVrEbABMwErxJjON7Eej8tLRcUkJFnKHHhxWM6KybFLviTG4Cnu0Lf+
         5E/BuexleMB3/k6HLLkiPgYcgN4s0Su59ftmEVevpJD70RuQe2jHZXl0NuEpkZdJX1jt
         ZspjP5DxD2DBUNUKp+0FAfasv5+Fnj2LT9QTreUaXv7Wsgq/HL7pIBdf5BcSZ9aA10AD
         8ucQ==
X-Gm-Message-State: AOJu0Yx8SkSEojGoHWuLoO+2O+bJ5FcoHAcFAtPhbQ3jRHlstLfawpvW
	fwnzWMXWH+FyVgQnWs4k9bvCDIOZh2uR0j/TAtC7orgiMh3/fJnnbNCxlYFpH+NS/5AiqfEZlan
	odBqfq4HyXxMtu128OlGK0lgbNq+0nIm08xxu
X-Gm-Gg: ASbGncuXEJDqx3EzpQtgJkiPnNraKxm9UHH8Ob+zpWpn6JYJjKg70o3LT1hBQRSTLxD
	icPPIOskXjEBP/gkw5HtQ+cT7t7INHEaN3+6xVqgCl/REv1NBBZrlY4eozs0RnRCqJEBSPNFbeC
	0+Y1inF/TUad8LN8VBESk+HEmxxGvrf9XK37LOp4KkSQ3sqJ2o0c1k1j1D0Cg5Ke9WrUS0qJIof
	vPgEQl5Vy/+2YRqYUWPQjqa/jzCDwbLoAjWRzyubFpfRcFLErsd
X-Google-Smtp-Source: AGHT+IE4MxF4RYLSz3jRLkFx5Ayjj1pHxWl3khJ1WiEqbT36/vwUWAFgikfKQDh/MXK8MXX7T0Al64looMU2mCsWhEU=
X-Received: by 2002:a05:6870:7025:b0:321:2680:2f77 with SMTP id
 586e51a60fabf-32264e267fdmr9565513fac.35.1757586444894; Thu, 11 Sep 2025
 03:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221122140222.1541731-1-dimitri.ledkov@canonical.com>
 <8802b5d1-abf1-4ceb-8532-7d8f393f1be6@molgen.mpg.de> <bd507f6c-cea9-41aa-98f7-a5cc81dd77e4@molgen.mpg.de>
In-Reply-To: <bd507f6c-cea9-41aa-98f7-a5cc81dd77e4@molgen.mpg.de>
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Thu, 11 Sep 2025 12:27:13 +0200
X-Gm-Features: AS18NWCsxdmkiek6CKdhB1-2Fin5CE0lrEyAmKjT6Yhi_E1lwFN6LnPki4ySguA
Message-ID: <CAO8sHcnTzioN=WMAf35EQ-4iEwuUmmeEPQ9L=WsxzeF1_rn3XQ@mail.gmail.com>
Subject: Re: [PATCH v5 RESEND] Bluetooth: btintel: Correctly declare all
 module firmware files
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, stable@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Was this patch applied in the end? If not, is there anything else I should =
do?

Cheers,

Daan De Meyer


On Wed, 27 Aug 2025 at 07:31, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> [Cc: Remove Dimitri=E2=80=99s bouncing address]
>
> Am 27.08.25 um 07:29 schrieb Paul Menzel:
> > Dear Daan,
> >
> >
> > Thank you for the patch.
> >
> > Am 26.08.25 um 22:29 schrieb DaanDeMeyer:
> >> From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> >>
> >> Strictly encode patterns of supported hw_variants of firmware files
> >> the kernel driver supports requesting. This now includes many missing
> >> and previously undeclared module firmware files for 0x07, 0x08,
> >> 0x11-0x14, 0x17-0x1b hw_variants.
> >>
> >> This especially affects environments that only install firmware files
> >> declared and referenced by the kernel modules. In such environments,
> >> only the declared firmware files are copied resulting in most Intel
> >> Bluetooth devices not working. I.e. host-only dracut-install initrds,
> >> or Ubuntu Core kernel snaps.
> >>
> >> BugLink: https://bugs.launchpad.net/bugs/1970819
> >> Cc: stable@vger.kernel.org # 4.15+
> >> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> >> ---
> >> Notes:
> >>      Changes since v4:
> >>      - Add missing "intel/" prefix for 0x17+ firmware
> >>      - Add Cc stable for v4.15+ kernels
> >>      Changes since v3:
> >>      - Hopefully pacify trailing whitespace from GitLint in this optio=
nal
> >>        portion of the commit.
> >>      Changes since v2:
> >>      - encode patterns for 0x17 0x18 0x19 0x1b hw_variants
> >>      - rebase on top of latest rc tag
> >>      Changes since v1:
> >>      - encode strict patterns of supported firmware files for each of =
the
> >>        supported hw_variant generations.
> >>
> >>   drivers/bluetooth/btintel.c | 26 ++++++++++++++++++++++----
> >>   1 file changed, 22 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> >> index a657e9a3e96a..d0e22fe09567 100644
> >> --- a/drivers/bluetooth/btintel.c
> >> +++ b/drivers/bluetooth/btintel.c
> >> @@ -2656,7 +2656,25 @@ MODULE_AUTHOR("Marcel Holtmann
> >> <marcel@holtmann.org>");
> >>   MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSIO=
N);
> >>   MODULE_VERSION(VERSION);
> >>   MODULE_LICENSE("GPL");
> >> -MODULE_FIRMWARE("intel/ibt-11-5.sfi");
> >> -MODULE_FIRMWARE("intel/ibt-11-5.ddc");
> >> -MODULE_FIRMWARE("intel/ibt-12-16.sfi");
> >> -MODULE_FIRMWARE("intel/ibt-12-16.ddc");
> >> +/* hw_variant 0x07 0x08 */
> >> +MODULE_FIRMWARE("intel/ibt-hw-37.7.*-fw-*.*.*.*.*.bseq");
> >> +MODULE_FIRMWARE("intel/ibt-hw-37.7.bseq");
> >> +MODULE_FIRMWARE("intel/ibt-hw-37.8.*-fw-*.*.*.*.*.bseq");
> >> +MODULE_FIRMWARE("intel/ibt-hw-37.8.bseq");
> >> +/* hw_variant 0x0b 0x0c */
> >> +MODULE_FIRMWARE("intel/ibt-11-*.sfi");
> >> +MODULE_FIRMWARE("intel/ibt-12-*.sfi");
> >> +MODULE_FIRMWARE("intel/ibt-11-*.ddc");
> >> +MODULE_FIRMWARE("intel/ibt-12-*.ddc");
> >> +/* hw_variant 0x11 0x12 0x13 0x14 */
> >> +MODULE_FIRMWARE("intel/ibt-17-*-*.sfi");
> >> +MODULE_FIRMWARE("intel/ibt-18-*-*.sfi");
> >> +MODULE_FIRMWARE("intel/ibt-19-*-*.sfi");
> >> +MODULE_FIRMWARE("intel/ibt-20-*-*.sfi");
> >> +MODULE_FIRMWARE("intel/ibt-17-*-*.ddc");
> >> +MODULE_FIRMWARE("intel/ibt-18-*-*.ddc");
> >> +MODULE_FIRMWARE("intel/ibt-19-*-*.ddc");
> >> +MODULE_FIRMWARE("intel/ibt-20-*-*.ddc");
> >> +/* hw_variant 0x17 0x18 0x19 0x1b, read and use cnvi/cnvr */
> >> +MODULE_FIRMWARE("intel/ibt-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9].=
sfi");
> >> +MODULE_FIRMWARE("intel/ibt-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9].=
ddc");
> >
> > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> >
> >
> > Kind regards,
> >
> > Paul
