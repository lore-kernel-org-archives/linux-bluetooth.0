Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B936D158A13
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132217; cv=none; b=SQ/1ujk0CTAYGzWbAT/6otGXMN7ecOKZyGgtE5ABVehahf22bhYmJTE92ZThDOclKiUPRARZ4pJBo//1K040AKMg1FRIsdhvgGtOi4CcrGVyCZCy+bW7JliuDM+na0ISrzVal/A3BA7YVB+V4ELbnzvltJSCOxadg47Q2k1pdBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132217; c=relaxed/simple;
	bh=pEEoThluMVk3imrrvu2HEKGZMfF6hSpkuKpm7yaeRA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXOeciO6m9di88x98JMxeYFDtN29DIEcux3EkJevl3dUJU2GaswxRmZmArcECUecphU/W38TQgytmRfVLMPTQxkWCtSxYBweGShSXXoIGJWrqKgMZa02WF9YxiuMHQPxHmPfUPPAWM9vsY4zK9eB/5GDTeEupYTcXybX1xDdcNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdTx7nBO; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdTx7nBO"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb561f273eso1595981fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 11:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732132214; x=1732737014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zslVovY72mXVDpBgOIf5K8HPKIKfXTanPvd15HSxigY=;
        b=ZdTx7nBOqti91zosQI3m2KeEdrgDMhNEFiwkqyT2lkiJNhRxIqN8LCLawN9XMVcob6
         b82vnscpXhWljdRlr7yvx2MK9kSs5YbrVZExACJASZsz4+iMUMbXjBwU4EjOe4b5DERf
         XfR+SFN+BH6DnNmSHSCcyMeWXRMxlf+mjHQKeImgNorZfBKB5BAU4Jv67ATlKqIPUmc/
         Exiks6DJk/9wsrIdrUa89okg4Vx5wVPoY5F6wRomUIt6xuMnz//wMNbv6RGjL4zdAtyF
         /IW0xjOpfntsvx3eJ7zhFXpeioHySk3UUtpPlFZeS//wqaHe5AZRLlzfZvfmL8PPixxH
         Rtjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732132214; x=1732737014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zslVovY72mXVDpBgOIf5K8HPKIKfXTanPvd15HSxigY=;
        b=Sjy/CSFhJcb2/XjcIOJdRrXAzor8YvqrMW561rVLmAFO/FijHc5bURLMhBk3S4GF57
         UrTy18c56P6+a4209fCLPkquOeehg+nyQQk4iq40mDFIkhfKAQ7EKm25b1eGEB1uScph
         tQKvKhhAr1C5vbN60Ne4T5AL5D6y2nRnpoS6pZ5bm237WQIin4SUHxnnOiEJLCdh3+Dl
         F0Tw7I19OBIJPhFlKaAo6I4dMataa/yXzsg9AWhGlvX+XtkJ+w3Gq/SYZAi9EXE7AG2I
         iifcYrozCHkBDixFmS0KQnrWKkiL81YfV6S0SSZPpZVi1iliSdtZFJ8UlgLhl7442ZLl
         Fpag==
X-Gm-Message-State: AOJu0YwJL0zj0vDUSXlKhLOPLMDnldMOZ1GqeHmCv63sORZTKODESrMx
	CYfsS8YXSXF2D7ZOJV9UnYdsgRDVvbhwGVP+OcamQvorNcJgtclHYDH657IR3MKCbIs8q33GECR
	d8YaJ0D1SCg0yPTWWktyA6Sqi4zpnaHOF
X-Google-Smtp-Source: AGHT+IFIr6mVI6pIM+yrf5LgzI0PFARqYfaIjxtlHiFeQ3EqymtKogs/RAlnSDMXz68W9x0CuM5ZjSpAQx+1LdUQhx4=
X-Received: by 2002:a05:651c:b14:b0:2fb:51e0:93f with SMTP id
 38308e7fff4ca-2ff8dcf7836mr29760681fa.35.1732132213629; Wed, 20 Nov 2024
 11:50:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2260310.hkbZ0PkbqX@n9w6sw14>
In-Reply-To: <2260310.hkbZ0PkbqX@n9w6sw14>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 Nov 2024 14:50:00 -0500
Message-ID: <CABBYNZKYA8PiW0f_Y-=KbXpmA0BBiodi6+YdhYDEFLPT7hbJfA@mail.gmail.com>
Subject: Re: Problems with LE advertising when powering off
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Wed, Nov 20, 2024 at 2:07=E2=80=AFPM Christian Eggers <ceggers@arri.de> =
wrote:
>
> I have a regression with my LE advertising after updating the kernel
> from 5.15.x to 6.6.x.
>
> At some time in the past I came to the conclusion that my Bluetooth adapt=
er
> (TP-Link UB500 with Realtek RTL8761BU) "forgets" all LE advertising when
> powered off (e.g. by "rfkill block ...").  Due to this thinking I registe=
red
> a D-Bus signal handler on "org.freedesktop.DBus.Properties.PropertiesChan=
ged"
> and called "org.bluez.LEAdvertisingManager1.RegisterAdvertisement" (or
> "UnregisterAdvertisement") after the "Powered" property of my "org.bluez.=
Adapter1"
> got updated.
>
> With Linux-5.15, there was no problem removing the advertising instance
> after the HCI was powered down.  In remove_advertising(), the call of
> hci_req_clear_adv_instance() (and then hci_remove_adv_instance())
> successfully removed the instance from struct hci_dev.  As the
> HCI was already powered down, no attempt was made to remove it
> from the controller hardware itself.
>
> With Linux-6.6, remove_advertising() calls hci_cmd_sync_queue(), which
> checks for HCI_RUNNING and returns -ENETDOWN.  So the advertising instanc=
e
> is neither removed from the controller nor from struct hci_dev.
>
> When I power up the HCI again (by "rfkill unblock ..."), the BT stack
> tries to "update" the advertising (hci_powered_updat_adv_sync(), called
> from hci_power_on_sync()).  This fails then in hci_disable_ext_adv_instan=
ce_sync(),
> I get the following output in btmon:
>
> < HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 6   =
                                                                           =
 #257 [hci0] 55.116038
>         Extended advertising: Disabled (0x00)
>         Number of sets: 1 (0x01)
>         Entry 0
>           Handle: 0x01
>           Duration: 0 ms (0x00)
>           Max ext adv events: 0
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                                           =
 #258 [hci0] 55.117040
>       LE Set Extended Advertising Enable (0x08|0x0039) ncmd 2
>         Status: Unknown Advertising Identifier (0x42)
>
> The kernel log shows "Bluetooth: hci0: Opcode 0x2039 failed: -38".

Ok this shall probably be handled in the kernel and remove its
advertising instance and notify the userspace the controller has lost
tracking of this instance so we can cleanup the upper layers.

> When my application then tries to (re-)register its advertising,
> I get the following btmon output:
>
> bluetoothd[408]: @ MGMT Command: Add Extended Advertising Parameters (0x0=
054) plen 18                                                            {0x=
0001} [hci0] 55.260267
>         Instance: 1
>         Flags: 0x00010003
>           Switch into Connectable mode
>           Advertise as Discoverable
>           Contain Scan Response Data
>         Duration: 0
>         Timeout: 0
>         Min advertising interval: 0.000 msec (0x0000)
>         Max advertising interval: 0.000 msec (0x0000)
>         TX power: 0 dbm (0x00)
> < HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 6   =
                                                                           =
 #261 [hci0] 55.311447
>         Extended advertising: Disabled (0x00)
>         Number of sets: 1 (0x01)
>         Entry 0
>           Handle: 0x01
>           Duration: 0 ms (0x00)
>           Max ext adv events: 0
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                                           =
 #262 [hci0] 55.313950
>       LE Set Extended Advertising Enable (0x08|0x0039) ncmd 2
>         Status: Unknown Advertising Identifier (0x42)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                                        {0x=
0001} [hci0] 55.325430
>       Add Extended Advertising Parameters (0x0054)
>         Status: Failed (0x03)
> bluetoothd[408]: =3D /usr/src/debug/bluez5/5.72/src/advertising.c:add_cli=
ent_complete() Failed to add advertisement: Failed (0x03)                  =
               55.329010
>
>
> I guess that all this happens because the controller has forgotten its ad=
vertising
> during power down and now there is a mismatch between the entries in stru=
ct hci_dev
> and the controller.
>
> Is it normal that a controller clears its advertising entries when powere=
d down?
> Who (kernel / application) would be responsible for "restoring" the adver=
tising
> after the controller had a power cycle?

Not really, I don't think Ive seen this behavior before at least but
perhaps the driver is powering down during rfkill which probably means
it would act as a reset was sent, that said I'm surprised nothing else
breaks with this behavior.

> regards,
> Christian
>
>
>
>


--=20
Luiz Augusto von Dentz
