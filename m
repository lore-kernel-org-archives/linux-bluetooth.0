Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6FDC74A4B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 18:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjCMSjB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 14:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjCMSig (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 14:38:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C9086DEB;
        Mon, 13 Mar 2023 11:37:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t15so12226369wrz.7;
        Mon, 13 Mar 2023 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678732609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0On3lk8dvxcR+1Ki8IT4nZKbfo+xTeDYisoJbo8GSvQ=;
        b=QDGq684iFqzHTyROS4kkduB7wenwlNsZLog+SAWAk45PtfTGajIhTWbpg0bpjYsFmO
         QB22KQfD8+JkZKa9p3z/JH/GpcUUVIp7loT/vGy97FiinJZgkWd7IGe/WEu29xB2wBxi
         sGvTH6WjcyPoZysIRsV03sEyRF/TeRAYfLC3AK0hzVzIZk5i1frEkgtXrkXKU/9f9kES
         Z2m9ERBf4f9ntoX061l9HuB8BeVC6M0ip8+LopVFBlvL/5946I5ayzdlHJK+ZIwOwflR
         gtFxARx99WaiBNyhxk2wzw2lBEE8LapSOxDN2XCh9VT6fse/dgM5iVsst+DfzzTCXL4W
         VJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678732609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0On3lk8dvxcR+1Ki8IT4nZKbfo+xTeDYisoJbo8GSvQ=;
        b=0wsfU7h4lUO+Svuf7PW1au3RW8qxJRn3pbAk3S02+rp9APGOtKzYcyJP+cQbasbH/s
         VwP4I8btjG6aqTWxZwTXOWO/4AnPjWL4L62sVw4KTabCQmtImBLRFxdZs/w3SLPUdjSI
         DHxUMfArXhJaVkR5cDYgC3Us+MDKL0aWajiHNZpmBzOeZheeouJBNn0f+gA0f/cdUc+K
         /gNzfcWgFwg7P7s2U0dZG8wlWka5GomhrR1smwqMT16ZTaHNtm1vfdUw1bkv98f7Lr89
         ojEB/bQnxcQ4ALH6/iRjvLm07ACHj19lr/QBWKmai3LN4ikzRZtEw7afw2aBnUbnUBIl
         J1XA==
X-Gm-Message-State: AO0yUKVc5qMj3EBue6epmA9QBT5RiWt9tLTG81AVrO89jwoMRHweMoNt
        lMEGnX2PqrxZUbTQ9yYsCL3NXLVCL4JdVfwpKZA=
X-Google-Smtp-Source: AK7set8B0dNsqRcONkpmAQzYZpFmKmuWzseRMwzUiu+G+KUHnd9RjQ6h37IsNYiDXaiabSg/eqoZDg7ImeZQGTYO1BM=
X-Received: by 2002:a5d:4347:0:b0:2c7:1320:7781 with SMTP id
 u7-20020a5d4347000000b002c713207781mr7187605wrr.13.1678732608854; Mon, 13 Mar
 2023 11:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230228152205.133582-1-macroalpha82@gmail.com>
 <20230228152205.133582-3-macroalpha82@gmail.com> <CADcbR4+Onb6RM7grPrqRL8Rth0mbFXykRmPq8R1QxYRGaHQHtA@mail.gmail.com>
 <CADcbR4L6b9D1FJx9u1jFvZ6jhixNs3_Ky+Mu0rHwtXZ6ATO-Eg@mail.gmail.com>
In-Reply-To: <CADcbR4L6b9D1FJx9u1jFvZ6jhixNs3_Ky+Mu0rHwtXZ6ATO-Eg@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Mon, 13 Mar 2023 11:36:21 -0700
Message-ID: <CA+E=qVdjvYn2qPCP+9EaS=90DT_uEVSk0z04tU3DL0X8NumUAQ@mail.gmail.com>
Subject: Re: [PATCH 2/3 V4] Bluetooth: hci_h5: btrtl: Add support for RTL8821CS
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Mar 13, 2023 at 11:12=E2=80=AFAM Chris Morgan <macroalpha82@gmail.c=
om> wrote:
>
> I found the fix, simply put changing the compatible from
> realtek,rtl8822cs-bt to realtek,rtl8732bs-bt fixes it (because it sets
> the "H5_INFO_WAKEUP_DISABLE" flag). Is it too late for a V5, or should
> I submit this as a fix to the devicetree and devicetree documentation?

But is it actually compatible with rtl8723bs-bt though? I think you
may need to add an entry for 8821cs to rtl_bluetooth_of_match in
hci_h5.c

> Thank you.
>
> On Fri, Mar 10, 2023 at 10:25=E2=80=AFAM Chris Morgan <macroalpha82@gmail=
.com> wrote:
> >
> > I shudder to bring this up now, but I'm encountering a new bug and
> > might have to withdraw this.
> >
> > I'm receiving errors in dmesg of the following, and I can't seem to
> > figure out the root cause:
> > Bluetooth: hci0: Out-of-order packet arrived
> >
> > Any thoughts on what might cause it?
> > Thank you.
> >
> > On Tue, Feb 28, 2023 at 9:22=E2=80=AFAM Chris Morgan <macroalpha82@gmai=
l.com> wrote:
> > >
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > >
> > > RTL8821CS is a WiFi + Bluetooth combo chip from Realtek that provides
> > > WiFi A/B/G/N/AC over an SDIO interface and Bluetooth 4.2 over a UART
> > > interface.
> > >
> > > Note that the firmware this was tested with was firmware version
> > > 0x75b8f098.
> > >
> > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > ---
> > >  drivers/bluetooth/btrtl.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> > > index 69c3fe649ca7..72947d319fa6 100644
> > > --- a/drivers/bluetooth/btrtl.c
> > > +++ b/drivers/bluetooth/btrtl.c
> > > @@ -128,6 +128,14 @@ static const struct id_table ic_id_table[] =3D {
> > >           .fw_name  =3D "rtl_bt/rtl8821c_fw.bin",
> > >           .cfg_name =3D "rtl_bt/rtl8821c_config" },
> > >
> > > +       /* 8821CS */
> > > +       { IC_INFO(RTL_ROM_LMP_8821A, 0xc, 0x8, HCI_UART),
> > > +         .config_needed =3D true,
> > > +         .has_rom_version =3D true,
> > > +         .has_msft_ext =3D true,
> > > +         .fw_name  =3D "rtl_bt/rtl8821cs_fw.bin",
> > > +         .cfg_name =3D "rtl_bt/rtl8821cs_config" },
> > > +
> > >         /* 8761A */
> > >         { IC_INFO(RTL_ROM_LMP_8761A, 0xa, 0x6, HCI_USB),
> > >           .config_needed =3D false,
> > > --
> > > 2.34.1
> > >
