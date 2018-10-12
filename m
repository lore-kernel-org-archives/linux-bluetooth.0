Return-Path: <SRS0=J5Jk=MY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C8CC6783C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Oct 2018 11:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99432087D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Oct 2018 11:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N51YK8bc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99432087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeJLTJ2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:09:28 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:44350 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeJLTJ2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Oct 2018 15:09:28 -0400
Received: by mail-oi1-f174.google.com with SMTP id u74-v6so9597598oia.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Oct 2018 04:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v1TVrq60AFoqs7noVjIFn+h+BerMSR/yLyjiFIN/h98=;
        b=N51YK8bcDFhd82XSVqUC29SnfIWaeW8gggyup52xmkJuD2b81Zbi00TWLcYagj60hy
         YLRfAwLyPdX6Wv41/zgObZeGAOMO88FqfBr/CkarvNlmxxE8lW3fk0iHOqoDaM+s3sQF
         yRDXO6oDywECVfRual4Y46w7mC8MzJg9WPierJ4rT71W4OxhViGGa1a2x2ogVPUeCAuv
         +cbnoarNnLfdsMvo5BVNHtPdVK0rPenullAr8Bisu+eHFJ8TTFphFVrbBEs6B3KsZ2bG
         YBIdLGRX6Q67dGqHtJg/icLqW8+781/Er38ohmEXXy67M4P7kblbg5faXmD+0Ybi0QUB
         EVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v1TVrq60AFoqs7noVjIFn+h+BerMSR/yLyjiFIN/h98=;
        b=onkzfwkFnsy38QeogV1QcB49QyHLMvP/6wbcNlH8T2rv90Z4FsNZ0r+MTCk7UhS+6n
         H7gxSpALw+NZCqjpPyP9456DDw2FGE57QqvzcRWW9HtAWcs4xldr9cOKCM/F7BEFbOln
         coP4regZ2dwxRMsRh2vlJBqG4JXEyHcMGI9g+tsAe/BjEVn/iqNUxjE5vymqUypT24hZ
         Xggzr42PL1mXT+3G6IpR/C1e/xjys2YcetHYvUxWSy4gQw3wDM65dreleIhvHGusY3LC
         5vweBCU2J5Vza8nI5nYuuDyHg8nms2vKSbPXUQGAmFOg/hMKeNwq7Y37Cjq4ZR68vPVx
         FilQ==
X-Gm-Message-State: ABuFfoimAufw00ybe4+C4KWSrB5TT6X4K9mFPc5e0entOWdo4Z54ZuwR
        URyxTTBsnZ6MHOV5o0sZKMEMH3tdAjNuFF9JKIo=
X-Google-Smtp-Source: ACcGV63JInvW5CWu1CcE/wa4rC2ZpstwXp9APpYhAKMoRWEVSspX9P0A8xRNzHuEaIyqGu9aYZUovLDmKPYmGPUfW6Q=
X-Received: by 2002:aca:4786:: with SMTP id u128-v6mr3138837oia.250.1539344245842;
 Fri, 12 Oct 2018 04:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <da781fd16860492a9b4d28334a593b77@fronius.com> <CABBYNZKWhK5NKQqpgXqTAFcaBkVM=CrSLtuxzD=MPyw6p-es7A@mail.gmail.com>
 <1a98ed47a70446f08fea529bcd85eafc@fronius.com>
In-Reply-To: <1a98ed47a70446f08fea529bcd85eafc@fronius.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 12 Oct 2018 14:37:12 +0300
Message-ID: <CABBYNZ+JGw=Bo=SvnTemCTaFxgnZUXgQJ1Nitsq=ALy5Ax55Zg@mail.gmail.com>
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
On Fri, Oct 12, 2018 at 2:15 PM Eisenkolb Thomas
<Eisenkolb.Thomas@fronius.com> wrote:
>
> Hello Luiz,
>
> I have now tried the same procedure with my desktop linux pc instead of t=
he embedded linux device.
> The result is the same but I think in the logs is now more useful informa=
tion.
>
> It is also a Bluetooth 4.2 hardware but this time with an intel chipset.
>
> I have tried two cases(the same procedure as before).
>  1) first I established a connection from the smartphone to the desktop(d=
esktop as peripheral device)
>  2) try to establish a connection from desktop to the sensor(desktop as c=
entral device) using the command "connect 88:...." in blutoothctl tool whil=
e the connection between smartphone and desktop is still established
>       The device was successfully discovered and is still available and w=
aiting for connection.
>       a) desktop starts passive device scan.
>       b) sensor sends scan response.
>       c) after the scan response is received, desktop disables the device=
 scan
>       d) no further action at hci interface(expected le connection attemp=
t command)
>       e) bluetoothctl runs into timeout and logs "Failed to connect: org.=
bluez.Error.Failed"

Perhaps it is because of the following code in the kernel:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/tree/net/bluetooth/hci_event.c#n5082

Now I wonder it wouldn't be better to remove that line and just let
the controller reject it if it don't support connections while being a
slave.

> After that I disconnected the smartphone from the desktop and did the sam=
e as mentioned in point 2.
> The only difference in this case is that the connection attempt command i=
s immediately sent after the passive device scan is disabled(point 2.c).
>
> Maybe this is more helpful than the last answer.
>
> Should I set any special flags that I get it to work?
>
> Thanks.
>
> Best Regards,
> Thomas Eisenkolb
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
