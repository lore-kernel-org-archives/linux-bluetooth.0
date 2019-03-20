Return-Path: <SRS0=+K9s=RX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303CBC43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Mar 2019 11:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D2F2175B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Mar 2019 11:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tkxf9/hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfCTLZR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:25:17 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:34143 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfCTLZR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Mar 2019 07:25:17 -0400
Received: by mail-oi1-f180.google.com with SMTP id u12so1492830oiv.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2019 04:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ygIkqo8e7QUWA3Rh59LumuZrfemh7IIsBl3fUErbf8M=;
        b=Tkxf9/hyxRHQGfGFjNwT0nyT/CAY4AVSes4WemHiAhFxENqZWZIsvP/PA9IT8wgEag
         oNYTFimEfjPoJgmPDDnqlg808nMlaT8h5h4aOmWk6bPhLoi577XlnOA3b2R0VjkLfZH1
         1ZMjNxmrzMJZrH4LhTQSJ3taFNQThJzk3RM39OuwFfcinxmHYVjN30rflMYJ3Yg9wca8
         VHfz6QEZJMdrntQ1U8WlxpUX30z50fr6hkvWzyhbiIc02Zi1FtFppgJeqZ2+mFDEuJDj
         43NY4ZJTEinuhxaUDk/TG3z5AnsQ5MLgXzhlDR3s5qNtD/i3zlaVuxEB5WVoLAvq0tU6
         Ti+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ygIkqo8e7QUWA3Rh59LumuZrfemh7IIsBl3fUErbf8M=;
        b=MkoOzYc/tfZMa5bMCDB1dxEuMrfkM680JE/lI+p12QNOluuhFtEmvCrC3UNi5lUI3R
         PUZxhR03ANnxKIIoBG9S8CueSRJOCHMpqugM1KXT4topcZ4Wjq4CJTon1j5qhG2/R6lX
         5aTKu4hDxVPwufCCXXgIeF/JhL2BRfA9LVQvVzI71RDlwgWX3wp7w6SpFxQm507V9Caz
         ErFA0pOqhdCMTokhdgZtUhn3afR3RW3DJ66hewrO5EG1oknP3d3J7SoqlZOTsIfjyZ2q
         7DpX8IO4MVVnC+03+yl6ZMCWQXgOZ8vGFC5IOfb8c1Tjqcvt7WXlc50261Yg7zlGvAAk
         2qPg==
X-Gm-Message-State: APjAAAWsbV+sOm3I5165lG5ny25ZRrMpdJ7m1OjnCwzlqlp+7v7GsUQu
        bWL42gtIwVa5GG8AEN5SYrwf9rP2RUXtuV++jkE=
X-Google-Smtp-Source: APXvYqyHWe55sf/uxksZdbKRrI88d7ujVAAJTvYCcfyY3BWLdnyIRkjHw3rNyl40yz4E8HZUlKMdTRXu2lsAX6njisM=
X-Received: by 2002:aca:abce:: with SMTP id u197mr4875319oie.67.1553081116102;
 Wed, 20 Mar 2019 04:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAKWEGV6aTNGcOcfO5xL+H0P95xh=6dOTdCnvNMrGCxpR1G-aJw@mail.gmail.com>
 <CABBYNZJC8RuGb5sKCDznAZimmVmg9LFhg=gN9T4eUUBLrMUikg@mail.gmail.com>
In-Reply-To: <CABBYNZJC8RuGb5sKCDznAZimmVmg9LFhg=gN9T4eUUBLrMUikg@mail.gmail.com>
From:   Yauhen Kharuzhy <jekhor@gmail.com>
Date:   Wed, 20 Mar 2019 14:25:03 +0300
Message-ID: <CAKWEGV507EkaQDiY_E+JifUkYRxTmaLDyXQKuGMPiN-HtFzs_Q@mail.gmail.com>
Subject: Re: bluez: Disable GATT client at non-initiator side?
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

=D0=B2=D1=82, 19 =D0=BC=D0=B0=D1=80. 2019 =D0=B3. =D0=B2 23:22, Luiz August=
o von Dentz <luiz.dentz@gmail.com>:
>
> Hi Yauhen,
>
> On Tue, Mar 19, 2019 at 5:07 PM Yauhen Kharuzhy <jekhor@gmail.com> wrote:
> >
> > Hello,
> >
> > I am trying to implement GATT services with bluez API.
> >
> > If external device initiated LE connection to device with bluez
> > running, bluez start to discover services at initiator and, if one of
> > characteristics required pairing, request pairing. This is not
> > intended behaviour for some reason in my case, so I need to disable
> > GATT client if bluez is not initiator side of the connection, similar
> > to ReverseServiceDiscovery config option for non-LE.
> >
> > Is it possible by any way? As i see code, device_attach_att() function
> > in src/device.c initializes GATT client unconditionally in both cases.
> > For debug, I disabled client initializing and this seems works for
> > external-initiated connections.
>
> We could perhaps reuse the same logic to disable the GATT service
> discovery, though the should not cause any pairing request since the
> discovery don't actually read any value, apart from characteristic
> declaration which shall not require authentication.

Yes, problem really in BATT profile accept stage:

164    16.407237    localhost (jeknotez)    5c:ca:67:f8:3b:11 ()
ATT    12    Sent Read Request, Handle: 0x0016 (Battery Service:
Battery Level)
166    16.466794    5c:ca:67:f8:3b:11 ()    localhost (jeknotez)
ATT    14    Rcvd Error Response - Insufficient Encryption, Handle:
0x0016 (Battery Service: Battery Level)
167    16.467125    localhost (jeknotez)    5c:ca:67:f8:3b:11 ()
SMP    11    Sent Security Request: AuthReq: Bonding,
SecureConnection, Reserved

=D1=81=D0=B0=D0=BA 20 13:53:42 jeknotez bluetoothd[4945]:
profiles/battery/battery.c:batt_probe() BATT profile probe
(74:E0:C9:69:D2:8C)
=D1=81=D0=B0=D0=BA 20 13:53:42 jeknotez bluetoothd[4945]:
src/service.c:change_state() 0x5557fcda23b0: device 74:E0:C9:69:D2:8C
profile batt-profile state changed: unavailable -> disconnected (0)
=D1=81=D0=B0=D0=BA 20 13:53:42 jeknotez bluetoothd[4945]:
profiles/battery/battery.c:batt_accept() BATT profile accept
(74:E0:C9:69:D2:8C)
=D1=81=D0=B0=D0=BA 20 13:53:42 jeknotez bluetoothd[4945]:
src/service.c:change_state() 0x5557fcda23b0: device 74:E0:C9:69:D2:8C
profile batt-profile state changed: disconnected -> connected (0)

device_probe_profiles()
...
batt_accept()
  gatt_db_foreach_service()
    foreach_batt_service()
      handle_batt_service()
        gatt_db_service_foreach_char()
          handle_characteristic()
                    if (uuid_cmp(GATT_CHARAC_BATTERY_LEVEL, &uuid)) {
                         handle_battery_level(batt, value_handle);
                    }



--=20
Yauhen Kharuzhy
