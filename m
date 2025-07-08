Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22A72E11DE
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989407; cv=none; b=bTsCHeinlfXj1REGoo/5o+QM+ppxz2wqNirgoZltEEcDAKqMDzz/RtdhxJhp4pdv4Cb0TwAqECtYwR+mYiza/KDQQkn/1VpAPTKdN/g/iM6aPd1WiXJYJx/RXYlbHzMNcCcRq1md8ORhlAzvO/nk2m8lCLnpG7aMseYJAIJ1VMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989407; c=relaxed/simple;
	bh=KHDWlh9QgcUcur6yq1+meyYuS7RAp+9/VDElIyB5pYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEb2PSlaAPxanNxlM3Xxvx43sCkfdCKBlp4WsRc5rXveywgmvbWUGfTd92BMttBDN+vDXWAxhdDwC/L9DQ2ihYhvLR8CLx4RsKXXHz3tlYMGHPwejDseaPRtEpDof5X0gEUp+RFo+WNER346EmmgIX+6ve8UqGYdmtKTG1npqRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lK0cDNro; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK0cDNro"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32f1aaf0d60so37202221fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 08:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751989404; x=1752594204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Hrhohr+OvIOQbZ5/dR1eoVjnfjA87m+6eJ59YDnqPE=;
        b=lK0cDNro8yaWJfPRyYrbO7BM4Efj9QcZr+BoHpn0TVmeM4AFsnOAUomqq2FYpthYp8
         3/AM8P32U+iWbgkgD5XaM5IxuDuK4g6Cn+SQC97fZO8Y5n61aLjPlu6FC08MFEyt+y87
         nsj060Nt5FLPgXyqXu1SWD/rjwctLXCdQ8xqGww63Pwa9VlDIHGAQPiCQ3a0jOnWyZNi
         YLVr5Hf4NXTcFchB1BNZ/38HG00QngEpi2ZTSB4oHTQYN03aoQ9JFOIKmjbcx3XtqH6K
         ssMexUahgKyUybjD2mV+w2XqJocja9rDrFFEFVI1HLTjn1XF8kfuRNVuA0H0f8LbcXcD
         b0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751989404; x=1752594204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Hrhohr+OvIOQbZ5/dR1eoVjnfjA87m+6eJ59YDnqPE=;
        b=pbfqIYP9+0PkWo40vpDIERc+yAkmr/Jeo5dYLvRyHzjAidfra5+xKrR7R/P6WSvKiq
         r7r9jEse9kSVawFSaayOVH+iolXVVG8/DuNxe83DNI52kpC2NEhaPYjAgHi2r7GSXg4q
         lid6iOI3RuOnSxV+bf3JZhUe2l8A6QaQFedblImEi4cBO3bVSfcKZlNoLE2Vi6VwbXNI
         Elcrvgf767N2qA6IjdvNzFJE4J6/xwJ0DvTB0b6YmYhgjedMYMXw64MtA6uPjFV0cEo3
         BGM+QYP5fAShYeEOd34L4/1MagAGh4rcA6yhsm71Qby/x0vrrrYZ+QUSHzEGhpGyx/Q/
         2TSw==
X-Gm-Message-State: AOJu0YzslKQAe1fwuD0JiL0Ot0so3rNtc0QIAYOqVxicaere6d6Pl55g
	SaTogDDd3QcK65Xbh9dKkeBP/4TDLNeJooLEvkzufKHVCapuqFgoa7UmpARu5ANdZtJJXXXUcK9
	z8LB4vVStDQaHEtY88UKG9FEEe3/46mA=
X-Gm-Gg: ASbGncstv3gcc5vL1d9z/wrt9OwDkSuIaSawu1o9/fqSWh0bo2B0xMl6+Wmjrw7AxL3
	ZDGbhaVQRhYmmGerHmoHD3ESJfrt4c8ID3duFlQ+1ajwFb6ZEA6yjlplZyWuZmPQj6js7PyZIHw
	oLaG1zTfZtqi5tOdzJTe/ddezpfx+BmhJ/fHdnCoolfw==
X-Google-Smtp-Source: AGHT+IEbbzjGuBxmXSRciKaegQt86L4UXL2cKwrkq69svqzwDsQ5xALbdJbTfH/r1/t/HlTKbwc5E1uxrY02BVwwZR8=
X-Received: by 2002:a2e:ae0c:0:b0:32f:219d:760d with SMTP id
 38308e7fff4ca-32f39ad155cmr11006501fa.20.1751989403494; Tue, 08 Jul 2025
 08:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BN0PR02MB8304F3E5A337240DDB24BB97E74EA@BN0PR02MB8304.namprd02.prod.outlook.com>
In-Reply-To: <BN0PR02MB8304F3E5A337240DDB24BB97E74EA@BN0PR02MB8304.namprd02.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Jul 2025 11:43:10 -0400
X-Gm-Features: Ac12FXxroWdo0jyUNhetK0V93T0njKF25MtumnPx9Q_4j_mmAtBE2cHtmeXmg2c
Message-ID: <CABBYNZJ=udxJgqCwAxUhOLLD5WofWvnC+jLD=suMONRGv0u_yA@mail.gmail.com>
Subject: Re: Query on Periodic Advertising
To: "Damodar Reddy GangiReddy (QUIC)" <quic_dgangire@quicinc.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Harish Bandi <quic_hbandi@quicinc.com>, 
	Mohammed Sameer Mulla <quic_mohamull@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Damodar,

On Tue, Jul 8, 2025 at 11:21=E2=80=AFAM Damodar Reddy GangiReddy (QUIC)
<quic_dgangire@quicinc.com> wrote:
>
> Hi Luiz ,
>
> I am reaching out to you to check about the Periodic Advertising in bluez=
. I am seeing below in emulator folder but there is no document available i=
n Doc folder about the periodic advertising.
> //hci->commands[37] |=3D 0x04;   /* LE Set Periodic Advertising Parameter=
s */
>     //hci->commands[37] |=3D 0x08;    /* LE Set Periodic Advertising Data=
 */
>     //hci->commands[37] |=3D 0x10;    /* LE Set Periodic Advertising Enab=
le */
>     //hci->commands[37] |=3D 0x20;    /* LE Set Extended Scan Parameters =
*/
>     //hci->commands[37] |=3D 0x40;    /* LE Set Extended Scan Enable */
>     //hci->commands[37] |=3D 0x80;    /* LE Extended Create Connection */
>     //hci->commands[38] |=3D 0x01;    /* LE Periodic Advertising Create S=
ync */
>     //hci->commands[38] |=3D 0x02;    /* LE Periodic Advertising Create S=
ync Cancel */
>     //hci->commands[38] |=3D 0x04;    /* LE Periodic Advertising Terminat=
e Sync */
>     //hci->commands[38] |=3D 0x08;    /* LE Add Device To Periodic Advert=
iser List */
>     //hci->commands[38] |=3D 0x10;    /* LE Remove Device From Periodic A=
dvertiser List */
>     //hci->commands[38] |=3D 0x20;    /* LE Clear Periodic Advertiser Lis=
t */
>     //hci->commands[38] |=3D 0x40;    /* LE Read Periodic Advertiser List=
 Size */

Yeah, we use those commands with the broadcast test cases under iso-tester.

>
>
> In AOSP Stack , Android has provided SDK APIS to enable Periodic Advertis=
ing but in the latest bluez version there is no option in bluetoothctl to e=
nable Periodic Advertising.
> Is there any plan to provide APIS in bluez version ?
> Is Periodic advertising part of experimental features ?
> Kind Regards,
> Damodar.

Currently we only use PA with LE Audio Broadcast, so there is no
dedicated API for PA alone, broadcast is enabled via experimental
flags, you can find more information in pipewire regarding the
main.conf options for LE Audio:

https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/LE-Audio-+-LC3-sup=
port

If you need PA for something other than Broadcast let us know, we
might need to extend our MGMT APIs to allow usage of that.

--=20
Luiz Augusto von Dentz
