Return-Path: <SRS0=Rr1U=P5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A771EC2F3A0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 13:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7649220989
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 13:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOQamZFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbfAUN5E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:57:04 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:43482 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729981AbfAUN5D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jan 2019 08:57:03 -0500
Received: by mail-pg1-f174.google.com with SMTP id v28so9522203pgk.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jan 2019 05:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2RzACEeAA9o7UgrJW36+jZrUT4587HrFnK80fzSHSk=;
        b=hOQamZFSMUgcRhbkpop5IaCKWaDX0yu/70R/1D38sKJfKKzGCZupboDdwwKTI73fjI
         ronNPJ6N9CLIGSLNQecMQ4BGbphlHDIep19VjYerA6EOKuV9Mi2dNOqOXsLgKwlXsGfl
         0mJQ1qu61QeY5Zw8ExlkgK+98ZOIOUZbL7FtfGrX95Br62Egc2mxy4DpcuLsU8WjUGnS
         CEj75r0bJp4o/26UHYIWhgmDeAn2ICqHVDJ0QHkOHFfPdjCvSRaWnhz6SE8yr1/RN9qa
         dwWOPBlOA0EtRgrWVCy5k1WyBu5XydLr8vwQHC21uI/95ufvl0TIKn+3owMi6fqm4HYF
         t6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2RzACEeAA9o7UgrJW36+jZrUT4587HrFnK80fzSHSk=;
        b=TwIxorZrqckQL+ayv8EO+9dV9Y1EKPe56h/nm/bG5ryg2MasDXmVHQizdRxwcCvqeU
         pyuUwcSPVQA0OVMMmAhgxXNs/KCSG/DU9JBhcHh9rcKnl+w/iF4YzzQCnwcUHws9gz9W
         fP56UDo+i1069vtWHbNTXaa4v5CcclMyqeiPnMSiU+hoc+podIUnugUJmi5i7uOWDTxZ
         FsUD5psUTOQTEoIcTcl4qpV/WL+9/y/hHtDGrySn7/qLxT4MY8qxKXG90PI6TWIm8yc8
         YhyeHIkKTyDLTmzjwTBecdhH0m8UPtaBHHOIg40t/nXtZsfPO1eXCW3m+qoyQ5R6Shz7
         +PYA==
X-Gm-Message-State: AJcUukeQG+0eL7e4fsVBkhDE+AWcWeA+hOglEF0FSosT+dKZd25MsDai
        XLQYA+j6W6gi+ZvIGHo3omTDFjr+wDwPWY9a/bI=
X-Google-Smtp-Source: ALg8bN6he0PG5wYYvA0f/PymEVmVsemX2rXeY8tMjKmMSKMCJcJm2LhWJvA+YsDMEEG+B+k06gFM20JCwwmOvphfyyM=
X-Received: by 2002:a62:4e83:: with SMTP id c125mr30030037pfb.101.1548079022136;
 Mon, 21 Jan 2019 05:57:02 -0800 (PST)
MIME-Version: 1.0
References: <CA+T8qpa+qHK7O6zr+a7CUysPzzR4jce7peCCcuOVN4J9TP6teQ@mail.gmail.com>
 <CABBYNZKGS=AcqtgfFffLBWZX6pxOHmkpnXgW4ddr4hO58a_pHQ@mail.gmail.com>
In-Reply-To: <CABBYNZKGS=AcqtgfFffLBWZX6pxOHmkpnXgW4ddr4hO58a_pHQ@mail.gmail.com>
From:   Youssif Saeed <youssif.am.saeed@gmail.com>
Date:   Mon, 21 Jan 2019 13:56:50 +0000
Message-ID: <CA+T8qpb=w5gnYMWh2fv6Q61ssHs1hrvJ=0gh0murxQZsvbt5vA@mail.gmail.com>
Subject: Re: BlueZ 5.50: Browsing local GATT table
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz

On Mon, Jan 21, 2019 at 12:12 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Youssif,
>
> On Mon, Jan 21, 2019 at 1:05 PM Youssif Saeed
> <youssif.am.saeed@gmail.com> wrote:
> >
> > Hi
> >
> > Is there a tool/utility for browsing the local GATT table. I have so
> > far used "bluetoothctl info" as follows:-
> >
> > [bluetooth]menu gatt
> > [bluetooth]register-service 0xFFFF
> > [bluetooth]register-characteristic 0xAAAA read,write
> > [bluetooth]register-application
> > [bluetooth]back
> > [bluetooth]info
> > Controller 00:16:A4:09:31:11 (public)
> > Name: linuxvm
> > Alias: linuxvm
> > Class: 0x000c0000
> > Powered: yes
> > Discoverable: no
> > Pairable: yes
> > UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
> > UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
> > UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
> > UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
> > UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
> > UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
> > UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
> > UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
> > UUID: Unknown                   (0000ffff-0000-1000-8000-00805f9b34fb)
> > UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
> > Modalias: usb:v1D6Bp0246d0532
> > Discovering: no
> >
> > However, this does not show the list of characteristics/descriptors
> > and their handles which is what I am after.
> >
> > I am using BlueZ 5.50 on an Ubuntu machine running Linux 4.15.0-43-generic.
>
> I guess you would be after the registered local attributes, command
> info doesn't print that only the UUID of the services, we could have
> then as part of list-attributes perhaps but it would only show the
> attributes register by that instance of bluetoothctl nothing else. As
> for the handles that is currently not exposed to the application, do
> you require them perhaps to restore them in the same location?
>
> --
> Luiz Augusto von Dentz

Thanks for getting back to me. Yes I am after the registered local
attributes. We're working on PTS testing the BlueZ stack and a few
tests require you to submit handles for the local GATT
services/characteristics, which is why having this would be very
useful. In my personal opinion the output to the deprecated "gatttool
primary/characteristics/descriptors" is ideal for displaying all the
necessary information. Something similar to this but for the local
GATT table can be very beneficial for future users even outside the
scope of PTS testing.

Youssif Saeed
