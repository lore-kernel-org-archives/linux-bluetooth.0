Return-Path: <SRS0=otBP=MV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA47C64EB0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Oct 2018 20:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E47214FA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Oct 2018 20:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCrnutuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E47214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJJDto (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:49:44 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:52838 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeJJDto (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Oct 2018 23:49:44 -0400
Received: by mail-it1-f172.google.com with SMTP id 134-v6so4786265itz.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Oct 2018 13:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0dcNHmtxyZDtlFJ66hsmD8hs3o2KuUp94NRwuEXLvms=;
        b=vCrnutuOXs+Zd9W03WweuRK81MBN3VaMt8hXEG7imDgc25LwgFxceerbXx2A+HHzQU
         A6gxjxq8m9MquQo9e8imuLMRGYLsLd036YOzjpBxrgYw3OiMwNVwrsagidGeESviLUso
         EQgMspzyW6VI05qDN44ZMaK8ewKZ+wslJAkc3DTDEslPv5q/ujNY1Eo5muxW3oX3Y+mr
         kKxHCs8XfUyROLOB/WaHQ0BjEU0lDuPzwDhNAuTTCBc9mJlLgW2J02NwxnDgHeeCmAGb
         4LbBVIi+dUqb+vbDtXZxnKnY2/4S3kHMj5XVhy9ToLffYl40Am7R5N5bc9efGeAMlFX2
         2uhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0dcNHmtxyZDtlFJ66hsmD8hs3o2KuUp94NRwuEXLvms=;
        b=aoyMYEEMt6rZ9zybHNwWkRGIr1HXLG8CT6H+GH2vC35jmUZtB1NCYTk6gEAl7zWTt/
         eKFefPnAn8Lzn8q+uVSFvyc4iZbprEIJE4MX353rBReo0k+2i74KPWiyYr9IJ0hVpMVF
         j3HQPx4M52+oOcwbGm3yTHAg/dFAXrCi8pmG8dRzqQ95ky7ROnWcO/MwilK6qsJbIRPZ
         pfx2v7KzQQE7m56qOgibySBkxwdI6gnoZpSCEiFB4ZmKpACfkLJm8oQAQcnOcFJURcX2
         4Js0yW+xr36AbNwyuhJIeJczk59wWSmwHqkzYWFb9FzCdxuKwZjMMy8C4ijIwXm7YvhD
         87nA==
X-Gm-Message-State: ABuFfoho1msMsF0AOsaBZHsHSK4Xcl5vgN2N3hT8q1mOgcpqDeSYv+pe
        zFVdsK0anuFc9GGREhiBroPLK5uj4P5YWuzc/3z7cU13
X-Google-Smtp-Source: ACcGV61IUBA5IRfbGp6TE5vO8ALJbgHzQFeY7MzI+AvRIdEsSZ0cLauEJnRV9c8IHsZYrt4sCSiL3qAGZdzMZaw9Wbk=
X-Received: by 2002:a24:e20c:: with SMTP id q12-v6mr3051314ith.89.1539117061076;
 Tue, 09 Oct 2018 13:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <7246fd0d-022f-0d7b-ab09-1030ac06e0fa@chicoree.fr>
In-Reply-To: <7246fd0d-022f-0d7b-ab09-1030ac06e0fa@chicoree.fr>
From:   Barry Byford <31baz66@gmail.com>
Date:   Tue, 9 Oct 2018 21:30:49 +0100
Message-ID: <CAAu3APYwnuB+XTuo3jOX=HFsFLWd2X-HW6YdfYnmn51fah=_ag@mail.gmail.com>
Subject: Re: Serial communication over BT using the DBus API
To:     sylvain@chicoree.fr
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Sylvain,

On Tue, 9 Oct 2018 at 20:50, Sylvain Leroux <sylvain@chicoree.fr> wrote:
>
> Hi everyone,
>
> I'm trying to establish a serial communication between two hosts over
> Bluetooth.
>
> Things go well if I start the `bluetoothd` on the server in
> _compatibility mode_. That way, I can attach the "serial port" profile
> to the channel. Then, using `rfcomm watch` and `rfcomm connect` to
> establish the connection between the server and the client, I can
> receive "raw" data sent by the server:
>
> ----
> # Server side
> /usr/lib/bluetooth/bluetoothd -C
> sdptool add --channel=1 SP
> rfcomm watch hci0 1 bash -c 'cat somefile > /dev/rfcomm0'
> ----
>
> ----
> #Client side
> sudo rfcomm connect /dev/rfcomm0 BB:CC:DD:EE:FF:11 1
> sudo cat /dev/rfcomm0
> -----
>
> If I do _not_ run the `bluetoothd` server in compatibility mode, SDP is
> no longer supported and the data I receive seems to modified by the BT
> stack, leading to my data being mixed with garbage--exactly like when I
> don't set the "serial port" profile while running in compatibility mode.
>
>
> I don't like the idea of depending on a deprecated interface. And from
> what I read, I understand the new way to go is to use the DBus API.  Any
> solution using bluetoothctl, busctl, dbus-send or similar tools would do
> the trick. But I can't manage to understand the sequence of operations
> required to transmit raw data between the server and the client *from a
> shell script* using that new API.
>
> Could you give me some example or point me to the relevant documentation?

You might want to take a look at the Bluedot library that has used the
DBus API to communicate over the Serial Port Profile.
Server:
https://github.com/martinohanlon/BlueDot/blob/master/bluedot/btcomm.py#L141
Client:
https://github.com/martinohanlon/BlueDot/blob/master/bluedot/btcomm.py#L466

The main section using DBus is in:
https://github.com/martinohanlon/BlueDot/blob/master/bluedot/utils.py


Hope that helps.

>
> Regards,
> - Sylvain Leroux
