Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6C2131738
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Mar 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732611; cv=none; b=na67feG36i926pyj56h2sZeexLzV/omA2Ulunk8Iv1ljag192zq9zr/IojJOJ5BM/eILW/gE/+R44bGSxui8ItKtIUfLHH1sSbCVj/m760fwklLnVg9BOScw0L2tYkQy/AxoZHlKCpaUJTu9fBYzvQ/fT4cDOHg2gVlNmqvpdCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732611; c=relaxed/simple;
	bh=2sd5sRwvPQFHqmBHtKbud+sIo5O1ZK+UXhgVxDDGJY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awrvbAANtpQwb44t/0ndMuYutTU0xgSqhBxnAHd9bOKm/UIOwyiRKiU/3JWmC68E6abv2WmtUvv5CF7LcJ7l/yVmUq4r8yya00+aGIPtLptx9PEjnLIbsyGwMnSN6lOU2PmSB5UtIB8BryHNw1DmnVCqrGaoDTkJfRi9pqDpr+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhPUg198; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhPUg198"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d27184197cso95606011fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Mar 2024 05:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709732608; x=1710337408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyBIygUvTMhV1CX+JkpaFZvh9b+k6umxdRVcGYn6apc=;
        b=lhPUg198VK700ja8DZnPKMLzDQsx6tCusHNjPgZ+Q6LCvF1iXgPh4WR8vRT1eeJQiT
         btjZcdbH4bMcMETPmm38RXjv3UP5aAwucP1bCSFf/GGaX6IYP8LLVLwdcz95UyEWy571
         UKsms3ZeWvmOXTtvdhUZMTSuq1OVFVxmigB1khWIhXpxOC9s6tWZ3N6EYfHspF2Y0Ui/
         5mpCffAIF6PSUJ+kaa4JqO5mBwi8xSu6jZygWSKZHtcePoekF0KdcPFWBG4P4LWKlzI2
         LYYAbCb6eoqnPwsUoyClsbNHTuMYUZDQwg3W6dVp6A24EPM7/tWwZVXOLBWxC1Lcrw6m
         F13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709732608; x=1710337408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyBIygUvTMhV1CX+JkpaFZvh9b+k6umxdRVcGYn6apc=;
        b=OMsI008bfrj+9oogjNUtCGrwAcsdNt+HYF56kTeKZfW+GFp/wh1Qc2foFJ6WHny+fx
         Gyg+y9NqU/C2xEd5awpuxSrgx5o4Vna0HfW59HSOrMDNyCnVlK3zXHERpyRLpZR6LjYE
         9qQl5FjAf+Cn6W5qhOVW3lJSkEHIUSqZlF0qTmY6qGYXkBjaLsP940N2NGGaeITMGayR
         vxVWJqXGDwBaV5x1CBSJaPeMdeRRm+tTU2j1Px9Ie4QTokfxyVAM7td3JpmAsknrswNE
         PTrqwkJYCKDbR1nXLUqgHkE3SjvtLleVbUblLxppYM6U27Dbbu8jZ9mJ1ca3/NIkXcb0
         k96A==
X-Gm-Message-State: AOJu0YzlkvTk6U9HkBoRVZ2cBAb3ck+aMrmDa4ZSspBdHsdrD1tNnQpl
	rFsJq32B/IBiMVhZEsFgdvYWDsFVTvVYLRPwggu7ieE8XtIWR61gc+kPc72qWYguiLNte072rNF
	wGY+ZFGKkP8nPahOUvzWSXLsa+pVPwoX9Ws8=
X-Google-Smtp-Source: AGHT+IHfoHKuPhbe8V47cC5PF6OL95yplHxahwbXv+mqnfSRi+oMwLOAAeDUGMldRsuVTEeghoEEl98T9e4smwG+tEY=
X-Received: by 2002:a2e:86c8:0:b0:2d2:e784:abc2 with SMTP id
 n8-20020a2e86c8000000b002d2e784abc2mr3566844ljj.33.1709732607296; Wed, 06 Mar
 2024 05:43:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305144459.119564-1-kiran.k@intel.com> <20240305144459.119564-2-kiran.k@intel.com>
 <CABBYNZJC60s9m8D_KmYOT6R8+QY5_c5-4VgcgO8phpWD7ZTqWQ@mail.gmail.com> <PH0PR11MB75853FCEE7FAD4406EA64A34F5212@PH0PR11MB7585.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB75853FCEE7FAD4406EA64A34F5212@PH0PR11MB7585.namprd11.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 6 Mar 2024 08:43:14 -0500
Message-ID: <CABBYNZJojKayf2zHYGEqXtuYnCrgvd=_EY+nBXx+_CfwFrvZOQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Bluetooth: btintel: Add support for downloading
 intermediate loader
To: "K, Kiran" <kiran.k@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, 
	"Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Wed, Mar 6, 2024 at 4:44=E2=80=AFAM K, Kiran <kiran.k@intel.com> wrote:
>
> Hi Luiz,
>
> Thanks for the comments.
>
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Wednesday, March 6, 2024 3:57 AM
> > To: K, Kiran <kiran.k@intel.com>
> > Cc: linux-bluetooth@vger.kernel.org; Srivatsa, Ravishankar
> > <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> > <chethan.tumkur.narayan@intel.com>
> > Subject: Re: [PATCH v3 2/2] Bluetooth: btintel: Add support for downloa=
ding
> > intermediate loader
> >
> > Hi Kiran,
> >
> > On Tue, Mar 5, 2024 at 9:31=E2=80=AFAM Kiran K <kiran.k@intel.com> wrot=
e:
> > >
> > > Some variants of Intel controllers like BlazarI supports downloading
> > > of Intermediate bootloader (IML) image. IML gives flexibility to fix
> > > issues as its not possible to fix issue in Primary bootloader once
> > > flashed to ROM. This patch adds the support to download IML before
> > downloading operational firmware image.
> > >
> > > dmesg logs:
> > > [13.399003] Bluetooth: Core ver 2.22
> > > [13.399006] Bluetooth: Starting self testing [13.401194] Bluetooth:
> > > ECDH test passed in 2135 usecs [13.421175] Bluetooth: SMP test passed
> > > in 597 usecs [13.421184] Bluetooth: Finished self testing [13.422919]
> > > Bluetooth: HCI device and connection manager initialized [13.422923]
> > > Bluetooth: HCI socket layer initialized [13.422925] Bluetooth: L2CAP
> > > socket layer initialized [13.422930] Bluetooth: SCO socket layer
> > > initialized [13.458065] Bluetooth: hci0: Device revision is 0
> > > [13.458071] Bluetooth: hci0: Secure boot is disabled [13.458072]
> > > Bluetooth: hci0: OTP lock is disabled [13.458072] Bluetooth: hci0: AP=
I
> > > lock is enabled [13.458073] Bluetooth: hci0: Debug lock is disabled
> > > [13.458073] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> > > [13.458075] Bluetooth: hci0: Bootloader timestamp 2022.46 buildtype 1
> > > build 26590 [13.458324] Bluetooth: hci0: DSM reset method type: 0x00
> > > [13.460678] Bluetooth: hci0: Found device firmware:
> > > intel/ibt-0090-0291-iml.sfi [13.460684] Bluetooth: hci0: Boot Address=
:
> > > 0x30099000 [13.460685] Bluetooth: hci0: Firmware Version: 227-11.24
> > > [13.562554] Bluetooth: hci0: Waiting for firmware download to complet=
e
> > > [13.563023] Bluetooth: hci0: Firmware loaded in 99941 usecs
> > > [13.563057] Bluetooth: hci0: Waiting for device to boot [13.565029]
> > > Bluetooth: hci0: Malformed MSFT vendor event: 0x02 [13.565148]
> > > Bluetooth: hci0: Device booted in 2064 usecs [13.567065] Bluetooth:
> > > hci0: No device address configured [13.569010] Bluetooth: hci0: Found
> > > device firmware: intel/ibt-0090-0291.sfi [13.569061] Bluetooth: hci0:
> > > Boot Address: 0x10000800 [13.569062] Bluetooth: hci0: Firmware
> > > Version: 227-11.24 [13.788891] Bluetooth: BNEP (Ethernet Emulation)
> > > ver 1.3 [13.788897] Bluetooth: BNEP filters: protocol multicast
> > > [13.788902] Bluetooth: BNEP socket layer initialized [15.435905]
> > > Bluetooth: hci0: Waiting for firmware download to complete [15.436016=
]
> > > Bluetooth: hci0: Firmware loaded in 1823233 usecs [15.436258]
> > > Bluetooth: hci0: Waiting for device to boot [15.471140] Bluetooth:
> > > hci0: Device booted in 34277 usecs [15.471201] Bluetooth: hci0:
> > > Malformed MSFT vendor event: 0x02 [15.471487] Bluetooth: hci0: Found
> > > Intel DDC parameters: intel/ibt-0090-0291.ddc [15.474353] Bluetooth:
> > > hci0: Applying Intel DDC parameters completed [15.474486] Bluetooth:
> > > hci0: Found Intel DDC parameters: intel/bdaddress.cfg [15.475299]
> > > Bluetooth: hci0: Applying Intel DDC parameters completed [15.479381]
> > > Bluetooth: hci0: Firmware timestamp 2024.10 buildtype 3 build 58595
> > > [15.479385] Bluetooth: hci0: Firmware SHA1: 0xb4f3cc46 [15.483243]
> > > Bluetooth: hci0: Fseq status: Success (0x00) [15.483246] Bluetooth:
> > > hci0: Fseq executed: 00.00.00.00 [15.483247] Bluetooth: hci0: Fseq BT
> > > Top: 00.00.00.00 [15.578712] Bluetooth: MGMT ver 1.22 [15.822682]
> > > Bluetooth: RFCOMM TTY layer initialized [15.822690] Bluetooth: RFCOMM
> > > socket layer initialized [15.822695] Bluetooth: RFCOMM ver 1.11
> > >
> > > Signed-off-by: Kiran K <kiran.k@intel.com>
> > > ---
> > >  drivers/bluetooth/btintel.c | 38
> > > ++++++++++++++++++++++++++++++++++++-
> > >  drivers/bluetooth/btintel.h |  3 +++
> > >  2 files changed, 40 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.=
c
> > > index ed98bb867cff..00e98606cf02 100644
> > > --- a/drivers/bluetooth/btintel.c
> > > +++ b/drivers/bluetooth/btintel.c
> > > @@ -521,6 +521,9 @@ static int btintel_version_info_tlv(struct hci_de=
v
> > *hdev,
> > >                             version->min_fw_build_nn, version->min_fw=
_build_cw,
> > >                             2000 + version->min_fw_build_yy);
> > >                 break;
> > > +       case IMG_IML:
> > > +               variant =3D "Intermediate loader";
> > > +               break;
> > >         case IMG_OP:
> > >                 variant =3D "Firmware";
> > >                 break;
> > > @@ -2194,10 +2197,26 @@ static void btintel_get_fw_name_tlv(const
> > struct intel_version_tlv *ver,
> > >                                     char *fw_name, size_t len,
> > >                                     const char *suffix)  {
> > > +       const char *format;
> > >         /* The firmware file name for new generation controllers will=
 be
> > >          * ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top =
step>
> > >          */
> > > -       snprintf(fw_name, len, "intel/ibt-%04x-%04x.%s",
> > > +       switch (ver->cnvi_top & 0xfff) {
> > > +       /* Only Blazar  product supports downloading of intermediate =
loader
> > > +        * image
> > > +        */
> > > +       case CNVI_BLAZARI:
> > > +               if (ver->img_type =3D=3D IMG_BOOTLOADER)
> > > +                       format =3D "intel/ibt-%04x-%04x-iml.%s";
> >
> > Shouldn't iml be the extension rather than the name? Like in intel/ibt-=
0090-
> > 0291.iml which you can probably achieve by just replacing suffix, that =
said this
> > function seems to be called with .ddc as suffix as well so I assume the=
re is
>
> I feel it's better to keep the extension as sfi as the image format for I=
ML and OP binaries are same.

So sfi and ddc are file formats? The only thing Ive found was:

https://filext.com/file-extension/SFI

They sound more like binary blobs, .bin, or image files .img, but we
choose to distinct them via file extension, thus why Is suggested to
use .iml.

> > some check preventing it to be called while version is IMG_BOOTLOADER?
> There is no such restriction. The same function gets called even when ver=
sion is IMG_BOOTLOADER. Inside this function we check for product and versi=
on to decide whether to load IML or OP image.

Wouldn't we end up having *iml.ddc then?

> >
> > > +               else
> > > +                       format =3D "intel/ibt-%04x-%04x.%s";
> > > +               break;
> > > +       default:
> > > +                       format =3D "intel/ibt-%04x-%04x.%s";
> > > +               break;
> > > +       }
> > > +
> > > +       snprintf(fw_name, len, format,
> > >                  INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver-
> > >cnvi_top),
> > >                                           INTEL_CNVX_TOP_STEP(ver->cn=
vi_top)),
> > >
> > > INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvr_top),
> > > @@ -2607,6 +2626,23 @@ static int btintel_bootloader_setup_tlv(struct
> > hci_dev *hdev,
> > >         if (err)
> > >                 return err;
> > >
> > > +       err =3D btintel_read_version_tlv(hdev, ver);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       /* If image type returned is IMG_IML, then controller support=
s
> > > +        * intermediae loader image
> > > +        */
> > > +       if (ver->img_type =3D=3D IMG_IML) {
> > > +               err =3D btintel_prepare_fw_download_tlv(hdev, ver, &b=
oot_param);
> > > +               if (err)
> > > +                       return err;
> > > +
> > > +               err =3D btintel_boot(hdev, boot_param);
> > > +               if (err)
> > > +                       return err;
> > > +       }
> > > +
> > >         btintel_clear_flag(hdev, INTEL_BOOTLOADER);
> > >
> > >         btintel_get_fw_name_tlv(ver, ddcname, sizeof(ddcname), "ddc")=
;
> > > diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.=
h
> > > index 52b2f1986f85..ae15b2253b6d 100644
> > > --- a/drivers/bluetooth/btintel.h
> > > +++ b/drivers/bluetooth/btintel.h
> > > @@ -51,7 +51,10 @@ struct intel_tlv {
> > >         u8 val[];
> > >  } __packed;
> > >
> > > +#define CNVI_BLAZARI           0x900
> > > +
> > >  #define IMG_BOOTLOADER         0x01    /* Bootloader image */
> > > +#define IMG_IML                        0x02    /* Intermediate image=
 */
> > >  #define IMG_OP                 0x03    /* Operational image */
> > >
> > >  struct intel_version_tlv {
> > > --
> > > 2.34.1
> > >
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Regards,
> Kiran
>


--=20
Luiz Augusto von Dentz
