Return-Path: <SRS0=QFCk=X4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52610C4CED1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Oct 2019 13:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298992133F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Oct 2019 13:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKWdt/gY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfJCNEo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:04:44 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:37072 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729677AbfJCNEo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Oct 2019 09:04:44 -0400
Received: by mail-oi1-f176.google.com with SMTP id i16so2502448oie.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Oct 2019 06:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbUIcMTq7/tDMv7UNnFGVmarXop0ovJ/0f6yVBavp/A=;
        b=fKWdt/gYQiw55IBmBIYmiUleh+qi/GKUPT3V4JObNREnIKJLuUBbtuZGY9lLh3deGL
         ujHpjQefXbYsz91R77MpNtFziUHrZfKIKtzBHzMwi3OjzUPOWtfMp+wkJP87rOkgbUTQ
         A/Z/0A7eRvkZRAujrGucPZIOrXKbVWCwQLq+g+iNgu3W1lpdODxyYvJkxZAQUqJH+54F
         fYgiUP0xqJJhE/WgZkN7LOsCcG7U8u3Q4DT3FK1jCM0ZJuHw62p+aght0ZECWHXNiUq8
         tdOBrH8N8fSKS/8bpuQYRxMSNnYRFbe76ce/7u8aZn+DlQM6Lv8CQ/icmVmNRlx8qvjp
         HogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbUIcMTq7/tDMv7UNnFGVmarXop0ovJ/0f6yVBavp/A=;
        b=R2+F/QlkvYkYSwKFtonRy4NQCEmUL22GRnEa9hVApUJCIcyZvT6mDtX4DM1DHGy9mu
         jA8Qiegubef50fGhHQH7V0DpLWeKsgn0bZIWrOcNqmIKZkW8PD9kJNFpagoqzLJxiqmU
         JV9NYv9aOnzFPpNWF8D9NnykHDGbsNDSHCQKF1vdG37z+IvpI1jAcHzWA8SEEmS1Q0KT
         Sl0hH5zkA05j9UTGZqDuIsP6ohUU/rVyT0AMFqnCnTPOzZGrGhM/wLv5MqQdFXoznrbg
         FxJOVhmy/P5t1y7dUB8bWjrwFtEC0G/sJMlLfNyBqGeN3+m6hxm0W1zV/bidZY3LJzuZ
         mkmQ==
X-Gm-Message-State: APjAAAVDDXvKQq1KxJsO/VA0ZUQPyDnkfjppMoLyUP4DOuIByR5Obpe/
        jTrDpBONbEDIyMO2kTM2qQwmxqHSsyXYKPtlDBE=
X-Google-Smtp-Source: APXvYqwHIoFbJR5+w1uE7iIGaokZYXtFFRaBGEI6MBdGilcWYq4RMfTeBEgC8ih+ACwVeNC94TsqiskXYYdIld1mBzU=
X-Received: by 2002:aca:4e85:: with SMTP id c127mr2715309oib.21.1570107883488;
 Thu, 03 Oct 2019 06:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <a04053d3-6165-5dfa-932c-5a93d2bd1358@einfach.org>
In-Reply-To: <a04053d3-6165-5dfa-932c-5a93d2bd1358@einfach.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 3 Oct 2019 16:04:31 +0300
Message-ID: <CABBYNZLK_rzAf5aPzJHShEVvXSvndZFh5TjyjaaFzAPw_sHoTA@mail.gmail.com>
Subject: Re: bluetoothd: Please don't filter UUIDs
To:     Bruno Randolf <br1@einfach.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bruno,

On Tue, Oct 1, 2019 at 8:06 PM Bruno Randolf <br1@einfach.org> wrote:
>
> Hello All,
>
> I am a developer using bluez via D-Bus to access GATT services and
> characteristics [1] and I would like to argue that bluez should not
> filter UUIDs of characteristics it handles by internal plugins.

Well I guess you are forgetting that other users of the GATT may
interfere with plugin which is why we do the claim APIs in the first
place.

> I recently came across this with the battery service (BAS). Our BLE
> device exports it, I can read it on Android, iOS and from other devices,
> but reading it from Linux is impossible. The UUID doesn't even show up
> in the list of characteristics! It took me a while to figure out, that
> it is filtered out and that you are supposed to read it via a different
> API on D-Bus [2].

Reading is done automatically if the plugin is enabled, you can
disable the plugin if you don want it to be automatically read, having
both will not gonna happen since it will incur in more traffic in this
case and may have security implication in services such as HoG.

> It surely makes sense to provide this more generic API, but I'd argue
> that all services and characteristics should be available via the normal
> GATT-based API using org.bluez.GattCharacteristic1 as well.

Not if the service has security implication, for instance we don't
want application to be able to access the keys presses coming from a
HoG device, or other things like changing the settings bluetoothd has
configured.

> One of my clients, for example, uses Linux/bluez as an interface for
> Server-based reading and writing of GATT characteristics of several
> managed devices. So I can read all those UUIDs, but why not the battery
> level? What happens when Bluez learns other GATT services, will their
> characteristics then also disappear? I think there is a strong argument
> for maintaining a generic API for GATT reading/writing characteristics
> independently.

But there is even a stronger argument if something breaks because the
app access something it shouldn't, even if there are no conflicts
between the plugin the very least it would cause is duplicating the
traffic.

> I made the following change to the bluetoothd code to get access again
> to all UUIDs, and I would like you to consider to include it upstream to
> enable us to access all characteristics via the normal GATT API:
>
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -2006,9 +2006,6 @@ static void export_service(struct
> gatt_db_attribute *attr, void *user_data)
>         struct btd_gatt_client *client = user_data;
>         struct service *service;
>
> -       if (gatt_db_service_get_claimed(attr))
> -               return;
> -
>         service = service_create(attr, client);
>         if (!service)
>                 return;
>
> Thank you,
> bruno
>
>
> [1] I published parts of that as an open source library:
> https://github.com/infsoft-locaware/blzlib
>
> [2]
> https://stackoverflow.com/questions/49078659/check-battery-level-of-connected-bluetooth-device-on-linux
>
>


-- 
Luiz Augusto von Dentz
