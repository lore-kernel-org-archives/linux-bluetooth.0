Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794488250;
	b=OGrBEb2eJtSsSiB+gttRwv/saMG3uTK0oO/h8dJHIsvNDbI4+wYjU1+UIqJfmn6X0Y4A
	 LAYLaVhByt/sLeYQ3aKyNRsHVqselOBL1qvTnOg4owwnZRTt2ojr3tpn8R7S8fNpKwEhd
	 OemiZNViOlM+h3TzaMcvWN1+/wut1C9HMFFaSUkqIRKWyE2SC7YdjLOBOVkBakD5F47Uq
	 29DgPg3E/G3mt2+zyZC2LM81CErwIQnH1HsPM22KbqmjQFqw95Qc0Zx4HK4JmhJUS6nw0
	 k8DRvNs0iJD+lg8RWzpkVpl9gHagF3/VfYJqn9otpBGD505UOUTa8f4n80lZXNeniFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QwjtaejwHcpDXMAslS3uVhsx3lI/CrcCuwcEtURbnWQ=;
	b=GOwU4Yc7de9m1Op8a/hZ4uXcmk7IE9rT3jfxpn4exM143HJfmi1ulOB0wo6tm1+CG4lJ
	 oeIOk6rD8qnpFWXQoHEudl57bV+HUe/ZRMRxO6VptfiB2GU2DCjtJSZ5+Bjqz7kdWjED3
	 lqsNLnw7FPnae4ey+rn6s6F0DJCh5GxA/ev++U5uCBp3/4ex8YIl6W3xbLr4ZeG5vCfQ2
	 J7hHuHsiAfmQR+PeKBOykULCjoP5kV0rFyR6iwRz14+oesuj6SH92bczsBbZ21uVnCfZR
	 4wlYTqxc2qNHYXdsgmJ8km1T4cnaPr4g2pIDHDuMwmV2rPu727hAKAYPdrB35TxhQoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=Ck8de3oy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7B606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 12:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95B7B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=Ck8de3oy
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b6e8b6d424so6343132a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 04:57:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794488248; cv=none;
        d=google.com; s=arc-20260327;
        b=a12IzfrU5V2zCb1vCVld7QQpeRxdsDm+JRAzYFNOCRrRRa4Sc8mDIkPkgBWAfxiDku
         MU0m9Av3w9ljXw7Zc5kYVIgh6HcXEiloRVx5d7G6K9snlyvXTehBRGg8tdBCuA7XO+g/
         S6t6mlcpfeaoxPKZR89XFCUfUbOcNUv/TqriRthf1c9wb+ZdQB6MuQ1z/bDikrDUNg0X
         iXc14ZJB9QHLb5GxbkbED+w4JFBd9+ImlwRfTWGd061H3KLuvvnWh+pj0Rz7QgqhZlry
         0gaKbK6oa4tSL4AhEoykSFn9nGcfLsQuafwlilSPquILlXEHLZ7/5uh5eOxrHTpQMPwU
         Vjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QwjtaejwHcpDXMAslS3uVhsx3lI/CrcCuwcEtURbnWQ=;
        fh=UsA3t8Eyve2DMlnRPy6ovbr9wC6leeIKT2os21833Bw=;
        b=OvYb3to4zF6veMYM/7diKy4IEzsjiIqUh4k36gorREwoEmpOUlgTKrrGeFJ6go3pF8
         2MMZhPBOE1QPyrVDY+qmBlfjYicCSGugtH8RApAfsUUr5JVjpV8T6TkxWWpRxE5mby6e
         BvlJYmxNvJRvT+AC5WThxqcKxmwjjzQ0O3+9qsjvZMrjBDLLtFqr1HZDd32TQOphGkQk
         slxwB4VBfsCR7YNWKUfkDP+DscVobJmyPx77us9n6Nhba3MpVnz9m1r5dXHE8AMUuivl
         k6A8Ac+gI8gZO3f9kPsoUhRDHjwjRDRWfhwzEtpiFyk77cG73bZ1eeqVGB5FjwPkfid3
         kvYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1794488248; x=1795093048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QwjtaejwHcpDXMAslS3uVhsx3lI/CrcCuwcEtURbnWQ=;
        b=Ck8de3oyVOuBXjWWNERiRX6kifNx8Y6MwGVEyjQs4mgvSRlaUnGfKsMDQ7pOTpUSxF
         LLMS9doO2ZHoyUP0Qx9wiKw4888CBVO6ETO8Wk8/v9kucYwkNb5A1MZa7q4Apcf5fFIz
         M3MM7Y3BrI2lk3WEZG2+KrbFX8qXRLUMcKjr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794488248; x=1795093048;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QwjtaejwHcpDXMAslS3uVhsx3lI/CrcCuwcEtURbnWQ=;
        b=RnyI+j4Psxn1g6WMO8AyVjcnFDQz4pVYou5wsOzvZQgqy/Am0zzEhuiyXnbiJq0gmO
         YJ4Qi0e3M+SITL2xbT1GNQBhIvGdJMOLCJ1HtzoAcI3Zho0IUYmSJquN976h1DR4rrT6
         /78FVVotfpENW8MB32PGyrx47DSvXBICZ3jcgakXl+nujC2ujNFO951dycOMnkgTM0zr
         F38ho9cKJP7glG4q7tnexB6T2Ay0OSgflP8v/5IfXrt8KCMqYoQOICr3c0um+vykkhly
         Ifn4qJ0xjL1Jd5FFvkBY7K3U+7crCTBAWByY2ybk1JqKVOvo0WGC4FAYQdzZIgIqv8du
         Lgag==
X-Forwarded-Encrypted: i=1; AL+hErFZ69kz7J3cwZD7z6g9WUCNZZagbwcr3bPPrAP3sOxSx5gl3nsWe78eGRQvkIpPmkaPFKT2PB1v/sfgsONAq1E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZFyNzvQOmuryFKzNur13mhfOyMvVaiqrgQrRw5fZFX/in5UqM
	rXkS7+pYKVzyk/wHm7PeNvTO6z/+40d/2l8qbf0w9K0tImAQhj1D7y7V0j3u74Du2mbTZHHaxzU
	Ic2xlVAnnAadr9DCJ60+wxZju4tTyJOjk+4vYyvDCeA==
X-Gm-Gg: AYBFou1SuRmxjBFKlFmF4b0kVPwLwIJBMvEgUph0uVmH9jJnKkDaGl5sFXxWIy8hyUR
	PDIibSh+LNouAr6Y2i7al9OtG7MnSz/ZdBGrQuI5qOhotRyMF6AVC8mFzlTgeuG8GGJMOGqauWl
	fj2J3gQcHdgANTV9bqCBKcs1lJsDW6VPRx9n90bkagkdIelYtxXw+kBqTHA3UpSVsEFIvRRmdfL
	XKzggG2mebrw/AgidCic5/lkfVX2eINQWvUG5lBUes2hsOnFN0K81u2Pa8cNwPlvE39NWlCU+K8
	s5/F0Wkq15/T8YA9PuFs1g5yv6fA/IGrHcEyk50UBABNW9jd9HtXwSSyuM8bMEgv9i17ocjN89f
	ugQb5MMiEagu7BGRCdJuLe77dt8og7d+MdrEAPW8/6bJudFhzOSbe4FvCatfbpF105oITiOxNDj
	h6zERnqyHRdAyrMtAxywjy8G7d35JqWdZc5d0+yZhQrjy+huyeHopQ8FA=
X-Received: by 2002:a05:6402:4407:b0:6b7:b0bc:f4af with SMTP id
 4fb4d7f45d1cf-6b7b0bcf5c5mr873269a12.7.1794488247914; Thu, 12 Nov 2026
 04:57:27 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110175334.676816-1-piyus@iiitd.ac.in> <20261110175334.676816-2-piyus@iiitd.ac.in>
 <CABBYNZL9GjdZvU6Z8B2v5_5iGXBno5K-GvqkKfX5vjEaTkV9vw@mail.gmail.com>
In-Reply-To: <CABBYNZL9GjdZvU6Z8B2v5_5iGXBno5K-GvqkKfX5vjEaTkV9vw@mail.gmail.com>
From: Piyus Kedia <piyus@iiitd.ac.in>
Date: Thu, 12 Nov 2026 18:27:16 +0530
X-Gm-Features: AclHuK8hls-AW8yfs8-PRYUOyj383dNj68tz1FvuidA2KViMtTYZ32vFMU0YiIw
Message-ID: <CADq=QSxbEXxgbZry=d0F5ACxNUST_u2fChEc8XgZ3YR-zyOmaA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: hci_sync: drop adv instances the
 controller cannot carry
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kapil Vaswani <kapil@presceralabs.ai>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

We just submitted another version that addressed the issues raised by Sashi=
ko.

https://lore.kernel.org/linux-bluetooth/20261112125420.3905719-1-piyus@iiit=
d.ac.in/T/#u

Best,
Piyus

On Thu, Nov 12, 2026 at 1:19=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Piyus,
>
> On Tue, Nov 10, 2026 at 12:54=E2=80=AFPM Piyus Kedia <piyus@iiitd.ac.in> =
wrote:
> >
> > An advertising instance stores up to HCI_MAX_EXT_AD_LENGTH (251) bytes
> > in adv_info. How much of that is accepted when the instance is added is
> > decided by max_adv_len(), which depends on a feature bit in the
> > controller's LE Extended Advertising support:
> >
> >   ext_adv_capable(dev) ? HCI_MAX_EXT_AD_LENGTH : HCI_MAX_AD_LENGTH
> >
> > ext_adv_capable() reads hdev->le_features[1], which is re-read from the
> > controller on every bring-up, while the instance list is only freed in
> > hci_release_dev(). Instances therefore outlive a power cycle, and an
> > instance added while the controller reported LE Extended Advertising
> > can be far larger than the capability now allows.
> >
> > hci_update_adv_data_sync() picks the writing path by that same bit.
> > Without it the legacy path runs, and hci_set_adv_data_sync() writes
> > into struct hci_cp_le_set_adv_data, whose data[] is HCI_MAX_AD_LENGTH
> > (31) bytes on the stack, while eir_create_adv_data() copies
> > adv->adv_data_len bytes into it. A controller that reports the feature
> > on one bring-up and not on the next overflows that buffer. This can
> > happen when, for example, a USB dongle answers LE Read Local Features
> > differently after a reset. scan_rsp_len has the same problem against
> > hci_cp_le_set_scan_rsp_data.
> >
> >   BUG: KASAN: stack-out-of-bounds in eir_create_adv_data+0x2ab/0x440
> >   Write of size 220 at addr ffffc90006b679c1 by task syz-executor
> >
> >   BUG: KASAN: stack-out-of-bounds in eir_create_scan_rsp+0x119/0x1a0
> >   Write of size 220 at addr ffffc90006ca79c1 by task syz-executor
> >
> > Both are reached from HCIDEVUP by way of hci_powered_update_adv_sync()
> > re-arming a stored instance.
> >
> > Bounding the copy in eir.c would leave the instance registered and
> > unusable, to be retried on every bring-up. Unregister it instead, once
> > the features have been re-read and before anything is scheduled, and
> > report it with MGMT_EV_ADVERTISING_REMOVED. Userspace can add the
> > instance again at a size this controller will accept. Dropping the
> > instances before the list_empty() test below also lets the default
> > instance be set up.
> >
> > The removal is under hci_dev_lock() because
> > hci_schedule_adv_instance_sync() sends commands, which cannot be done
> > with the lock held.
> >
> > Fixes: 112b5090c219 ("Bluetooth: MGMT: Fix always using HCI_MAX_AD_LENG=
TH")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Kapil Vaswani <kapil@presceralabs.ai>
> > Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
> > Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
> > ---
> >  net/bluetooth/hci_sync.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 9213e3ef9f26..ee8b1cd9dee5 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -3608,6 +3608,34 @@ static int hci_powered_update_adv_sync(struct hc=
i_dev *hdev)
> >         if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
> >                 return 0;
> >
> > +       /* An instance's data was accepted against max_adv_len() as it =
was
> > +        * when the instance was added, and that is a branch on a contr=
oller
> > +        * feature which has just been re-read. Anything too large for =
the
> > +        * current capability can no longer be rendered: drop it and te=
ll
> > +        * userspace, so it can add the instance again at a size this
> > +        * controller will take.
> > +        *
> > +        * This is safe as long as there is no command send while the l=
ock is
> > +        * held.
> > +        */
> > +       hci_dev_lock(hdev);
> > +
> > +       list_for_each_entry_safe(adv, tmp, &hdev->adv_instances, list) =
{
> > +               u8 instance =3D adv->instance;
> > +
> > +               if (adv->adv_data_len <=3D max_adv_len(hdev) &&
> > +                   adv->scan_rsp_len <=3D max_adv_len(hdev))
> > +                       continue;
> > +
> > +               bt_dev_warn(hdev, "instance %u too large for this contr=
oller",
> > +                           instance);
> > +
> > +               if (!hci_remove_adv_instance(hdev, instance))
> > +                       mgmt_advertising_removed(NULL, hdev, instance);
> > +       }
> > +
> > +       hci_dev_unlock(hdev);
> > +
> >         /* If RPA Resolution has not been enable yet it means the
> >          * resolving list is empty and we should attempt to program the
> >          * local IRK in order to support using own_addr_type
> > --
> > 2.34.1
>
> Sashiko flagged a few problems:
>
> https://sashiko.dev/#/patchset/20261110175334.676816-1-piyus%40iiitd.ac.i=
n
>
> --
> Luiz Augusto von Dentz
