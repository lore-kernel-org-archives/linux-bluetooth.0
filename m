Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3F194A73
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728685203; cv=none; b=LDkUmE7a3UGN5Iuijkw5S9KjGg0QdMH8tPfzXbqgzARUja1WkWMKWWdCDQWgV+fxMJ6kVlqvbQMlipGc/tfQkaMKx5r+qn4fRNK427hWAEpcch4CI2oqSDKv/G27RvlBJCb4EOWxfdJ/m00cLIrEJBGWyGZIVCjXZ9GYaTaVTMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728685203; c=relaxed/simple;
	bh=CWE6i36zi2jdZbGaY+Z8lXi+38dxJ7VXLe8DUdyR1d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7P+U++LGBBFOhgM7R0ngrjpCV1WAa9HqGShEBoUCFzNeK3rKyyRhreCbxjrgSXTuKR/ni3MQp1IcN2azV4kESmV4m1J0Fb5VXX1dNWeOMZxnAv+sJOf+8+g1AMbybJsTTx0fIXt/gGAZuZRrFfyQpp2NJe0HqhUh4Cnqjm0PgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hngUoymn; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hngUoymn"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb3c3d5513so7320991fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 15:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728685199; x=1729289999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWntwT+nXXuJeeRYUCFI1gpeyGmqr2/rkGEcnJ4mfGc=;
        b=hngUoymnfwjcPDAxo8q2SoMxSLjxYScFXllBeaQ955IFVi3dug9WzuLNW/wPi5Ndnf
         FyZvIkLxkftuk+0o2XLh3ID4AyaQPWIWU56CXHajVUgPvmIvMPFmJFvTA9Xl889USj37
         PV6QWiVaak+F84k4e9C3wsQyQwNasBO2OdWt+6zAucTuAPCGuuvrO+fZ8vDXJLvkIlGt
         xLsaLWtx+0FA8GAbM/OOQce1u2J0yxzANbP7stBbk+TXIKo2ocNDq5bQSnQdcuHnHLkR
         tY3d47DEz2iMIEberxvLz0xkg5b+xzuNT5P/Nf485cCA7yzMqh5oXjiIp+ud9lG83YaP
         DDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728685199; x=1729289999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWntwT+nXXuJeeRYUCFI1gpeyGmqr2/rkGEcnJ4mfGc=;
        b=o1q48bkYJgAniDJTH7W+6egH+qWkGu3+Qp3XkUFcBtNiWs9sMwmcc4soYPH3WrtjyY
         Zsp48kN6HeyKyylk2Eo9+1YaXMe3c04oQM8uwh9Mq0kISAiBf0y7Y1VwPrYUL/B+z9u5
         IEWzKgRTokzhVfdaTYLMdE4jt5PaG3N+O6Qr9+P7a1NsPDUZ9AEPMuveX7WPE1YKBbpm
         eyfq0jooBpnJV0wShPAu5enI4IBcOpCzrrOjlIveekfJMAnaprLRohreZLtS4SRFU7jd
         gHyd2dsoxa+92ZAumDtaFLQ6hmh570K4BVBp/lZHs2q23A5qNJIb6L2/VvUkSCqtCFi/
         9+KA==
X-Forwarded-Encrypted: i=1; AJvYcCVd025PEawRUglu7uiLg32D51oGTNFz/kEB3VHKYNJ9XpuIdRTLzl9zIug981ks08vVMiocr6sr0DLlM0ex5eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR7UD3UITB+QP2P+WYsk1seOvahEQXYTa4u3Yqh4pHMHYjLxsk
	4jLQAzN+keh0OmR4l7Ss1c3iCp4CXd+L7WRFCjyktx+pSTGcmQzfPEsY0ZlE3VESDuh0tkL8KKk
	PHV2Eg3KbywIsVZvSn6VmFZ0sNAg=
X-Google-Smtp-Source: AGHT+IHTYnQAsmRJtzF2ijTzaDEDfcozVBTEQbhHdN33Gq1Tj9EPvygr4mT16GmurHg3ooLsYPkxb5zY6ACFiFai6qY=
X-Received: by 2002:a2e:be06:0:b0:2fa:e0c4:f08b with SMTP id
 38308e7fff4ca-2fb329b9b31mr21516191fa.36.1728685199039; Fri, 11 Oct 2024
 15:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <595efd8b-e0fe-4a87-90b1-4b579f3cc876@gmail.com>
 <CABBYNZJMWni33VQ2sX9EDcNbsFbX7pjAFj4QLri9N7jyLY0HvQ@mail.gmail.com>
 <c8b5c842-463e-4c30-b7e0-f41bf1d59305@gmail.com> <CABBYNZ+kcwgPvCNFZHZZok_a6ZNXEPNABNefb4iaSNDNm4wPVA@mail.gmail.com>
 <CABBYNZKbXE4unZi3MPP2LPzYcv0OLHoaqqey02N1qUzSR=4PhQ@mail.gmail.com>
 <d85205ed-dd47-4690-99a3-8f20ea7ab237@gmail.com> <CABBYNZL7BJq57iJEm8y6D1JWikymC-gSP-N6jHXpgBjgWC_B6A@mail.gmail.com>
 <4492450a-aa01-49ae-9ff4-ef3641a6b6f2@gmail.com>
In-Reply-To: <4492450a-aa01-49ae-9ff4-ef3641a6b6f2@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 11 Oct 2024 18:19:46 -0400
Message-ID: <CABBYNZJPHc3-An5hB7HOtNRCP62=uUF9UckSPOF04kLVawu-MA@mail.gmail.com>
Subject: Re: Connection issue since 81b3e33bb054 ("Bluetooth: btusb: Don't
 fail external suspend requests")
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	BlueZ development <linux-bluetooth@vger.kernel.org>, Kiran K <kiran.k@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiner,

On Fri, Oct 11, 2024 at 4:56=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> On 11.10.2024 22:06, Luiz Augusto von Dentz wrote:
> > Hi Heiner,
> >
> > On Fri, Oct 11, 2024 at 3:44=E2=80=AFPM Heiner Kallweit <hkallweit1@gma=
il.com> wrote:
> >>
> >> On 11.10.2024 21:26, Luiz Augusto von Dentz wrote:
> >>> Hi Heiner,
> >>>
> >>> On Fri, Oct 11, 2024 at 3:05=E2=80=AFPM Luiz Augusto von Dentz
> >>> <luiz.dentz@gmail.com> wrote:
> >>>>
> >>>> Hi Heiner,
> >>>>
> >>>> On Fri, Oct 11, 2024 at 2:52=E2=80=AFPM Heiner Kallweit <hkallweit1@=
gmail.com> wrote:
> >>>>>
> >>>>> On 11.10.2024 18:36, Luiz Augusto von Dentz wrote:
> >>>>>> Hi Heiner,
> >>>>>>
> >>>>>> On Fri, Oct 11, 2024 at 6:49=E2=80=AFAM Heiner Kallweit <hkallweit=
1@gmail.com> wrote:
> >>>>>>>
> >>>>>>> Since linux-next from Oct 4th my bt speaker fails to connect if I=
 switch it on.
> >>>>>>> It just hangs trying. Manually connecting it via bluetoothctl wor=
ks though.
> >>>>>>> With this patch reverted it auto-connects again.
> >>>>>>> If you need additional details, please let me know.
> >>>>>>
> >>>>>> I suspect something is trying to suspend the controller then, it
> >>>>>> shouldn't be USB auto-suspend since that should behave as it
> >>>>>> previously but if there is something externally (aka. userspace)
> >>>>>> trying to suspend then it will force it to suspend.
> >>>>>>
> >>>>> On the host side it's a combined WiFi/BT PCIe adapter (RTL8822CE).
> >>>>> Runtime PM is enabled, so this may kick in. I'm not aware of any
> >>>>> userspace tool which may try to suspend the WiFi/BT adapter.
> >>>>> Disabling Runtime PM may be a workaround, but I don't think that's
> >>>>> the actual solution.
> >>>>>
> >>>>
> >>>> Well I assume it still using USB as transport, not PCIe, otherwise i=
t
> >>>> wouldn't be using btusb. Regarding runtime PM, I assume it still mea=
ns
> >>>> PMSG_IS_AUTO Documentation/driver-api/usb/power-management.rst:
> >>>>
> >>>>      'External suspend calls should never be allowed to fail in this=
 way,
> >>>>      only autosuspend calls.  The driver can tell them apart by appl=
ying
> >>>>      the :c:func:`PMSG_IS_AUTO` macro to the message argument to the
> >>>>      ``suspend`` method; it will return True for internal PM events'
> >>>>
> >>>> --
> >>>> Luiz Augusto von Dentz
> >>>
> >>> Perhaps there is a double call to the likes of hci_suspend_dev due to
> >>> system suspend and device suspend acting together, so maybe we need
> >>> something like the following:
> >>>
> >>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >>> index 779c4aeaef22..c257759ae2f4 100644
> >>> --- a/net/bluetooth/hci_core.c
> >>> +++ b/net/bluetooth/hci_core.c
> >>> @@ -2812,7 +2812,7 @@ int hci_suspend_dev(struct hci_dev *hdev)
> >>>
> >>>         /* Suspend should only act on when powered. */
> >>>         if (!hdev_is_powered(hdev) ||
> >>> -           hci_dev_test_flag(hdev, HCI_UNREGISTER))
> >>> +           hci_dev_test_flag(hdev, HCI_UNREGISTER) || hdev->suspende=
d)
> >>>                 return 0;
> >>>
> >>>         /* If powering down don't attempt to suspend */
> >>> @@ -2843,7 +2843,7 @@ int hci_resume_dev(struct hci_dev *hdev)
> >>>
> >>>         /* Resume should only act on when powered. */
> >>>         if (!hdev_is_powered(hdev) ||
> >>> -           hci_dev_test_flag(hdev, HCI_UNREGISTER))
> >>> +           hci_dev_test_flag(hdev, HCI_UNREGISTER) || !hdev->suspend=
ed)
> >>>                 return 0;
> >>>
> >>>         /* If powering down don't attempt to resume */
> >>>
> >>>
> >> No change in behavior with this change.
> >
> > Ok, I guess we can rule out system suspend then, does commenting out
> > the call to hci_suspend_dev makes it works again? If it does it means
> > the device is suspending and it appears the likes of
> > HCI_FLT_CONN_SETUP either doesn't work or is not being set to the
> > controller to allow incoming connections, since it is an Audio device
> > I think the problem is that we don't set HCI_CONN_FLAG_REMOTE_WAKEUP,
> > only input device do set it, so we may need to treat device suspend
> > and system suspend differently.
> >
>
> The following makes it work again.
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 7860750ec..33fd65d49 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2808,6 +2808,8 @@ int hci_suspend_dev(struct hci_dev *hdev)
>  {
>         int ret;
>
> +       return 0;
> +
>         bt_dev_dbg(hdev, "");
>
>         /* Suspend should only act on when powered. */
>

Can you try with the following changes:

https://gist.github.com/Vudentz/52c0cf8b9472a03b8eb447951be13811

--=20
Luiz Augusto von Dentz
