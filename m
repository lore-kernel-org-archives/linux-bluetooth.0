Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346FC3B0ADF
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775659623; cv=pass; b=T9ixPkjAX9YLv5trK9WFX54zY2E4vbO8H2FBWvppihK3v0beq6pba/G/EzcoiXa2rXllaCeujwyApAdic5ZRq1xrS7i37oJRqhWiZBJ/41s1CuMnfW+iUlGNBpGOVgbhiRTVMmznjioQYOoF0MaebTmiLGT21mBEi/4Oe4eB+F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775659623; c=relaxed/simple;
	bh=d2eDSCr7naQzF1CgIQJUx21DmfDs2veOFQWh7Z8B1Bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CN6dRGOHmTqJUEYCkjqdaNtYJqjVuMTFHR+aT9BGhxtSe+iVSJ/f4X2hb6CokeJvQnrau1FBf0au3cLwwqxVWxXeuFESQ09no1eiAlt2vF5xif69fb9+Kgm7OQo2fOLC13QMHfIv2cEinXRRnfQAQqDzKX/BekSb90yEM6SMLLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzFNIjpF; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzFNIjpF"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-650221149e2so6386281d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 07:47:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775659621; cv=none;
        d=google.com; s=arc-20240605;
        b=P1e+cUPD+OCXV/mofgKU0JHwPd5wfcMl2luTdfP2JSX0BRvZwEuJAodLdNUW4QI7ZW
         i0YR4PQUUZWS9t33D5v7j0gvKWFIf/IoIGhUB1AgwsyJ+gMUBs06sQpfx3ldGT6xw+TR
         PC3iiUcKc3hhRmZf5yXQ1Oi6TQxbGIKf+gdlRbYnT1x7tsvh6wHssjJkK0xge/hkGzm0
         mzizyvoBAp/V6yM4l9U0czObVuVemqWVh2Q+zLDa4y7DroLlRTJBCCufqsRejUbw4P/k
         kh2TQr+z324sUMJ+lSSru4CFmBnhXunNah0izby/DfDeZzRRunFWNR6CK9Pp2YXdFeeV
         k0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=La/Sai7sLpHaKzjoGXOuIVYmgmhPb8IqjxWA7Z7S5kY=;
        fh=G32oQlbOH4RnnGTXvns9H0EHjQ8ZmAa3WRM1vrDh2dc=;
        b=CV/DAh0VgAcP1GzMAqb/3cE6tM1rXJJozDMgEAo9NUD9mb+f9opVdDti7KC187TOTD
         VYoodPa7WNP1dDvGGjdO9HciRxzcOfF82zNsp5/rGTBUy2AD5WpT04OANfuqSOYr82mh
         3SKy9CTKvhUMvCkEcKKiwpNjfL04PmICLUJJCswEqt6N89YXjyRLnkkSEAfY2TQsSmr8
         jq1OiKJTrXLuw7lXJ51qEHCkB4kk083wQJgEUaWgKSGI3nBJUB5Hzs439Rmq0g1AjYXn
         ZeAkKhEtw6JOtVOqe2jzAj77YxLqu4JiEoEXuHKmeqxcXblhq0FjtKuoWjgNwcKt//ZJ
         tYuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775659621; x=1776264421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La/Sai7sLpHaKzjoGXOuIVYmgmhPb8IqjxWA7Z7S5kY=;
        b=jzFNIjpFwLzOPkjZrqlGZFr/Yo8diW5zSAtbZBuqGPWXlyv+9YqYZvDJkquuqxHwu3
         iHR5e1b0v16Xud3AM3RkqlaMWXB8mCSRQekuCUCCr305myOBFEj1/hMBdPJ5eVgQ+6Hg
         gc+D747KU2VY1aKO/cIvxPs039qZ8bDoGMrzb5S74CV4eTyuvxhfSzok85/YLgEORT3O
         oU87M4kyHT3JVjfHc0LT8uX/LeB3xqoQwaUFKB3Iy6AaEJgANIs1I6gT/9wnfYOpJvuA
         w7mRzaDq/eCN4LqzgPgwghZOK3SPb0NCD+TEzpAGNk4eCS5QidpPqqSphPY+dKNVGi9L
         r+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775659621; x=1776264421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=La/Sai7sLpHaKzjoGXOuIVYmgmhPb8IqjxWA7Z7S5kY=;
        b=XM3sNSXS2ToGt+NwpLO7Eq99xaMx3SZz3OOWJZfnwHAel9gzPJ+fa9KJyzZX0TMaQD
         ysxe7AvqFfLQt2SGVKjMyCIChLa+uMjbW/HR3XNF+X+G8R72RvHcNoL6+7K8y6pKuJMg
         87AgyasLT3PEhxd/pJFcliep1CzSeAI8AUKVNGYF8Bx46BSIZ9RgtYIKVMX638w4xPZC
         C1uDt8n+iCUrLb93bhnMTbc9dIDxNssxUB53uTRpMLbEEE8izQ5rl0UDPOeGcmZUfqRZ
         /lrsRx3o9xpxmjkkM5+iDPM3F5hDythisuJHe29INBDOedJVErsHe8zCLtBhUMEeFUE6
         bmrA==
X-Forwarded-Encrypted: i=1; AJvYcCXQwDsAoF5cmgozBrs2TucmL0jRsM4gpBQI3rKRpDgKVTRhSE+1+o8lgclBk2wa8NIIjHZo0dkY+TJkOpbOMS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxQWiI/uNJ99Ow4ysOmLz2usL5HPwqYSrHYWQNa1hxyO4j/g4z
	h5jeo52EBLLo/VQBvn5pzvSj+b9DutxyqKLMZvqeihE3jQMUjGtRt1HMTeu1KdtmpUZvKNRNwKL
	Y+IDg3KUujxJ0EwNrwT/fklwWjWUVHeo=
X-Gm-Gg: AeBDieten9IDkNcP4QYHx/muHvcoqUd3BZRcCnp+Msbbb8NaJyHooahFcwKgteP3fk8
	NMUOPZ4avcnyiUCCfFfqYk4LVQAiICafipLOsU9sy/Tr5nFOV/J6N/+xVA3JcGyQsXKwJFsHvwV
	heUbGiAK9pNKlbbNP39WTFFH4D0c3FBbDd59EClmA5Wi3pVmymXI60WzsVsIZd4Z3QZtAA30oVs
	w3LHovNkOZUr33fI5eisX2+vqM0u/gwt4+76KzSfEmGX6MZQr+XjfjQKnQHUTa/naCTwOI8ojXS
	Vk7N9qWUyIi7MtuLX4Ig1lRk1ggYdi+rgYyzCqxpGJtZQvMv7mgi2LvBavaXMJ0TUVM=
X-Received: by 2002:a05:690e:1c1c:b0:650:5316:1729 with SMTP id
 956f58d0204a3-65053162098mr16799018d50.35.1775659620944; Wed, 08 Apr 2026
 07:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408083217.1915419-1-kaihsin.chung@synaptics.com> <16bbcee4-2908-4eec-a03f-b847353b8bda@molgen.mpg.de>
In-Reply-To: <16bbcee4-2908-4eec-a03f-b847353b8bda@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 8 Apr 2026 10:46:50 -0400
X-Gm-Features: AQROBzBB-qYjgxSkGN0tIanowip70J6u0fMGc3KSbuXAHKywQ29iarNXq-MwvRk
Message-ID: <CABBYNZJ+m9Y4JjLoq8jgwU_3Q197BRZrq+GM35X3hxKsyFaf1A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add Synaptcis 4384 Chip Support
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>, marcel@holtmann.org, 
	luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kaihsin Chung <kaihsin.chung@synaptics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 8, 2026 at 4:47=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>
> Dear Kaihsin,
>
>
> Thank you for your patch.
>
> Am 08.04.26 um 10:32 schrieb kaihsin:
>
> Please add an elaborate commit message.
>
> > Signed-off-by: kaihsin <kaihsin.chung@synaptics.com>
>
> Please configure to use the full name:
>
>      git config --global user.name "Kaihsin Chung"
>      git commit --amend --author=3D"Kaihsin Chung
> <kaihsin.chung@synaptics.com>" -s
>
> Then please re-roll as v2 (`git format-patch -v2 =E2=80=A6`).
>
> > ---
> >   drivers/bluetooth/btbcm.c   | 2 ++
> >   drivers/bluetooth/hci_bcm.c | 3 ++-
> >   2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> > index f9a7c790d7e2..21ef875d6aa7 100644
> > --- a/drivers/bluetooth/btbcm.c
> > +++ b/drivers/bluetooth/btbcm.c
> > @@ -515,6 +515,8 @@ static const struct bcm_subver_table bcm_uart_subve=
r_table[] =3D {
> >       { 0x4106, "BCM4335A0"   },      /* 002.001.006 */
> >       { 0x410c, "BCM43430B0"  },      /* 002.001.012 */
> >       { 0x2119, "BCM4373A0"   },      /* 001.001.025 */
> > +     { 0x2128, "BCM4384A0_AP6684P" },/* 001.001.040 */
> > +     { 0x4119, "BCM4384B0_AP6684PL"},/* 002.001.025 */
> >       { }
> >   };
> >
> > diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> > index 874d23089b39..972685e83b8a 100644
> > --- a/drivers/bluetooth/hci_bcm.c
> > +++ b/drivers/bluetooth/hci_bcm.c
> > @@ -1609,7 +1609,8 @@ static const struct of_device_id bcm_bluetooth_of=
_match[] =3D {
> >       { .compatible =3D "brcm,bcm4335a0" },
> >       { .compatible =3D "cypress,cyw4373a0-bt", .data =3D &cyw4373a0_de=
vice_data },
> >       { .compatible =3D "infineon,cyw55572-bt", .data =3D &cyw55572_dev=
ice_data },
> > -     { },
> > +     { .compatible =3D "brcm,bcm4384-bt" },
> > +     { },
>
> Any idea, why the empty element is shown as changed?

Most likely identation changed like capture by sashiko:

https://sashiko.dev/#/patchset/20260408092128.1915973-1-kaihsin.chung%40syn=
aptics.com

> >   };
> >   MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
> >   #endif
>
>
> Kind regards,
>
> Paul
>


--=20
Luiz Augusto von Dentz
