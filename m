Return-Path: <SRS0=J5Jk=MY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F67AC6783C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Oct 2018 08:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5603B20868
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Oct 2018 08:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIJ8nwQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5603B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeJLPvy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:51:54 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:33126 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeJLPvy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Oct 2018 11:51:54 -0400
Received: by mail-ot1-f42.google.com with SMTP id q50so11646060otd.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Oct 2018 01:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gnlRI/wB2jPr5y58Z5StZ/CP7VViabjNtgBpn0PoKKw=;
        b=NIJ8nwQfOJ6FgpH7c0MimIFCYvP0EYypYdy3uxLacJv275hHQUWD9km/zdkeSRPpRe
         9BM7hSk6ZMfDiIMyEI6LNcoibUQ/UreL8xj49I3Wnx0Repy6sjsmhHbIS0Mpoyc3CIPk
         z+YgUor4ZUfc7CfvZhJrE0m3DzfOyGvs8AWNIBev0fm6rL3gjk4T3Mbu11iKs1qiYgfE
         Wi7JzYsoyFS8UZ/5sfg4TyZd9+Ev/4RJadLaemokKZ/9R8teXq1XnWtEJYBZwkVRSMaM
         XE1y6GMBdY40pfKs4eibQac13ceQEYrUqwbN02mThtnhxpPSadn5cX5m9RliXaDwFOMa
         G4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gnlRI/wB2jPr5y58Z5StZ/CP7VViabjNtgBpn0PoKKw=;
        b=MlV3SWUAS6GUibupRHjaVXFdtRHYcQG8q/RMdkrq9NKdlB7fbWkuuJvWcvVEanc33X
         0jC5HcyOpmWZf/hcBdul27b4xfJTWiA5Vi7/MrYcCBa5YS0tUyZDTsrIYcBI7sk7GC+V
         7dydy2wjMWrFwZT3NY+f0EXjS3JrfoIVc7aHx398M/qFdM7eLbZL4k7apy5lpGzbxRSq
         bdt9/hYhxblO7GS4uFEBz9IUMizyaaXZYQXZxqZkD7W3AMR5QcAQPL3U+SfuvaZR0KoO
         DOA80EKVXlGCxPjVCZicXIaCtGSKv/tLfcjNwQAC8ZDXnJnQhGhRn2VLtLAypoJTIhve
         FHOQ==
X-Gm-Message-State: ABuFfoiELzxcfb4vEGDbhwEhnRVAYCnBVsUwdF+vudJqv0XMiPkGEnuP
        jAFiUU0kXHM8I+MI7VCdiBAPW1HbT3CzhiJWS2Hqr+nc
X-Google-Smtp-Source: ACcGV63zcZoSrBe9Xs2CnN/weB7+FV9LO7LF7rL29KGWfas1nQQFOM7b2JyJoKEzkadCYaTvW+C0B0LcDGlvt69gPtk=
X-Received: by 2002:a9d:44ca:: with SMTP id p10mr3059663otg.291.1539332435998;
 Fri, 12 Oct 2018 01:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <da781fd16860492a9b4d28334a593b77@fronius.com> <CABBYNZKWhK5NKQqpgXqTAFcaBkVM=CrSLtuxzD=MPyw6p-es7A@mail.gmail.com>
 <bed1213e3c6d4d3abe06be95ef9aba79@fronius.com>
In-Reply-To: <bed1213e3c6d4d3abe06be95ef9aba79@fronius.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 12 Oct 2018 11:20:22 +0300
Message-ID: <CABBYNZ+dx3SCqsZF=cdpm0cnx=Nc2O-hSyKQF9Euq57G-BBCCw@mail.gmail.com>
Subject: Re: Bluetooth: Is it possible to operate Bluez concurrent in central
 and peripheral role?
To:     Eisenkolb.Thomas@fronius.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Thomas,

On Fri, Oct 12, 2018 at 10:36 AM Eisenkolb Thomas
<Eisenkolb.Thomas@fronius.com> wrote:
>
> Hello,
>
> Thanks for the answer.
>
> I have recorded logs of the exact use cases which I have to realize.
>
> The following MAC-Addresses of the devices are important:
>         - Embedded Linux device: "78-C4-0E-80-07-CD"
>         - Smartphone: "4C-D6-A9-48-CA-0C"
>         - Sensor device: "88-6B-0F-94-C2-38"
>
> I wanted to shorten the logs that no information gets lost.
>
> To produce this log I did the following operations in chronological order=
:
>         1) start btmgt tool (embedded linux)

You shouldn't need to btmgmt for these use cases, bluetoothctl can
manage advertisements.

>         2) call btmgt info (embedded linux)
>         3) Register advertising instances (embedded linux as peripheral)
>         4) Scan for advertising devices (Smartphone as central)
>         5) Stop scan for advertising devices(Smartphone as central)
>         6) Connect to embedded linux device (Smartphone as central)
>         -> established
>         7) Start scan for advertising devices(embedded linux as central)
>         8) Stop scan for advertising devices(embedded linux as central)
>         9) Connect to sensor(embedded linux as central)
>         -> Failed

I don't see the connection request, perhaps it doesn't happen because
we never found it while scanning? Does the connection timeout?

>         10) Disconnect from embedded Linux(Smartphone as central)
>         11) Connect to sensor(embedded linux as central)
>         -> established
>         12) Connect to embedded linux device(Smartphone as central)
>         -> failed
>         13) Tray again connect to embedded linux device(Smartphone as cen=
tral)
>         -> failed

Same thing here, perhaps bluetoothd logs would tell why it has failed.

>
> There are three log files in the attachments which have been recorded con=
current.
> One from "btmgt", "bluetoothctl" and "btmon".

Don't mix btmgmt with bluetoothd, btmgmt is more of a debug tool for
testing the kernel interface directly instead of using D-Bus but using
both is not recommended.

> As you will see in the logs from the sight of the embedded device I was j=
ust able to establish one connection concurrent.
> Whether peripheral connection or a central connection but not both at the=
 same time.

I see a lot of reports which means we are scanning but it looks like
there is never a connection attempt, except for the ones that does
succeed.

> If the embedded device acts just as central device, it is possible to est=
ablish more connections to different sensors at the same time.

That is really weird because the only difference is that you would not
be advertising, this could be a problem with the controller though,
have you tried any other controller to see if it has the same
behaviour?

> Thanks for your help.
>
> Best Regards,
> Thomas
>
> Hi Thomas,
> On Thu, Oct 11, 2018 at 10:18 AM Eisenkolb Thomas <Eisenkolb.Thomas@froni=
us.com> wrote:
> >
> > Hello,
> >
> > I am working with blueZ 5.50 on a linux embedded device with kernel 4.1=
4.
> >
> > Now I have to implement a use case where the linux embedded device comm=
unicates as a central device with a few sensors through Bluetooth LE charac=
teristics and at the same time it should advertise some data and accept at =
least one incoming connection from a Smartphone as a peripheral device for =
maintenance cases.
> >
> > I haven't found any information about blueZ is supporting both LE roles=
 at the same time.
> > I have already tried it now for 2 days to get this use case to work and=
 I found a few limitations for which I didn't find any solution.
> >
> > I was not able to advertise any data while my device had an active conn=
ection to a peripheral device.
> > Also while the Smartphone is connected to my embedded device(peripheral=
), I don't receive any advertised Data from any sensor and I cannot connect=
 to any sensor.
> >
> > The Bluetooth Hardware Module which I am using on the embedded Linux Sy=
stem supports Bluetooth 4.2. From the Bluetooth Standard I have found that =
concurrent use of both Bluetooth Low Energy Roles should be supported since=
 Bluetooth 4.1.
> >
> > Is it possible from blueZ Stack side to implement this use-case?
>
> BlueZ should work as dual roles already, if it doesn't there could bugs o=
r the controller preventing commands to work properly.
>
> > If yes, can you give me some hints what I have to consider to get this =
case working?
>
> Do you have HCI logs of the problem(s)?
>
> > If no, have you got a timeline when it will be supported or is this no =
planned to implement in near future?
>
> Most of upstream effort is on mesh and updates to include 5.0 features, b=
ut dual-role is something that we might consider high priority if that is n=
ot working properly.
>
> >
> > Thanks for your answer,
> > Thomas
> >
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
