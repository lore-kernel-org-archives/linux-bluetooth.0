Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F27DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 13:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbiBXNCL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 08:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiBXNCK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 08:02:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 062AF33353
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 05:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645707698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QNk5r92DyfhNN6mn/MVKBBusQYOztjJQoHAr5qOGBxI=;
        b=MIlaJp+i8pNcOLfn5NQBFkIWaCWHfU8yRCrv5nkUqCU5mTFmRxt1/SPffpwjWZBed+kA3e
        JkdYypsEolX8kuQENUvRpKRUMPyheSpIQRjtLcr1m3zQXl9ameCuduvraF9oCXEYxQ4YJH
        45IB50NeLzLdewVu+BbqA46w1sLOWYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-iFj6uJfkOoq3QUhyWFo-0A-1; Thu, 24 Feb 2022 08:01:29 -0500
X-MC-Unique: iFj6uJfkOoq3QUhyWFo-0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 954EA8145F6;
        Thu, 24 Feb 2022 13:01:28 +0000 (UTC)
Received: from starship (unknown [10.40.195.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 103E383BE8;
        Thu, 24 Feb 2022 13:01:26 +0000 (UTC)
Message-ID: <31367223b2e310521493b257244c188f3c22a619.camel@redhat.com>
Subject: Re: Since commit e8907f76544ffe225ab95d70f7313267b1d0c76d bluetooth
 scanning stopped working on my system
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Thu, 24 Feb 2022 15:01:25 +0200
In-Reply-To: <CABBYNZKWpPvJvKefgjw5YXCk9BL7900X+XnobLS6gw+50wKNfA@mail.gmail.com>
References: <f648f2e11bb3c2974c32e605a85ac3a9fac944f1.camel@redhat.com>
         <CABBYNZKWpPvJvKefgjw5YXCk9BL7900X+XnobLS6gw+50wKNfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 2022-02-22 at 10:35 -0800, Luiz Augusto von Dentz wrote:
> Hi Maxim,
> 
> On Mon, Feb 21, 2022 at 7:14 PM Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > Today I updated to a new kernel and I am bisecting few regressions:
> > 
> > I noticed that if I open GNOME's bluetooth setting, it hangs for like minute or so,
> > and then shows only the paired devices and no scan results.
> > 
> > I bisected this to this commit.
> > 
> > For reference I am running fairly old fedora 32 on this machine, and thus I have
> > bluez 5.55 and stock GNOME from fedora 32.
> > 
> > I can provide any more info on anything if required and/or test patches.
> > 
> > I wasn't able tor revert this commit as it is part of a bigger rewrite of scanning
> > which makes sense.
> > 
> > I tried merging bluetooth-next master as of today,
> > into my kernel but no noticeable improvement.
> 
> Is there any error being reported in bluetoothd, does bluetoothctl
> have the same problem? It would be great if you could provide an HCI
> trace of the problem.
> 
I haven't used bluetoothd much but that is what I see:

[mlevitsk@starship ~]$bluetoothctl 
Agent registered
[bluetooth]# scan on
[bluetooth]# scan on
Failed to start discovery: org.bluez.Error.InProgress
[bluetooth]# scan on
Failed to start discovery: org.bluez.Error.InProgress
[bluetooth]# 

No results show up, attempting to scan again shows the InProgres error.

On my AMD laptop on the other hand (also runs the same 5.17-rc5 kernel),
after 'scan on' I start seeing lots of scan results of various devices near me.


journalctl -u bluetooth -b0

-- Logs begin at Wed 2022-01-12 11:47:00 IST, end at Thu 2022-02-24 14:50:59 IST. --
Feb 23 22:16:45 starship systemd[1]: Starting Bluetooth service...
Feb 23 22:16:45 starship bluetoothd[1825]: Bluetooth daemon 5.60
Feb 23 22:16:45 starship systemd[1]: Started Bluetooth service.
Feb 23 22:16:45 starship bluetoothd[1825]: Starting SDP server
Feb 23 22:16:45 starship bluetoothd[1825]: profiles/network/bnep.c:bnep_init() kernel lacks bnep-protocol support
Feb 23 22:16:45 starship bluetoothd[1825]: src/plugin.c:plugin_init() System does not support network plugin
Feb 23 22:16:45 starship bluetoothd[1825]: Bluetooth management interface 1.21 initialized
Feb 23 22:16:56 starship bluetoothd[1825]: Endpoint registered: sender=:1.251 path=/MediaEndpoint/A2DPSink/sbc
Feb 23 22:16:56 starship bluetoothd[1825]: Endpoint registered: sender=:1.251 path=/MediaEndpoint/A2DPSource/sbc
Feb 23 22:16:56 starship bluetoothd[1825]: src/profile.c:ext_start_servers() RFCOMM server failed for Headset Voice gateway: socket(STREAM, RFCOMM): Protocol not supported (93)
Feb 23 22:16:56 starship bluetoothd[1825]: src/profile.c:ext_start_servers() RFCOMM server failed for Headset unit: socket(STREAM, RFCOMM): Protocol not supported (93)
Feb 23 23:11:21 starship bluetoothd[1825]: Controller resume with wake event 0x0
Feb 24 09:05:29 starship bluetoothd[1825]: Controller resume with wake event 0x0


I do notice that even on 5.16 kernel, I am not able to use the HSF or whatever low quality bi-directional bluetooh protocol is called for my headset. Used to work, I don't
know what broke it, likely not related to this.

I also updated bluez to 5.6 by installing fedora 33 package, and initiallly it seems to work, but after reboot, the issue shows up again.
Looks like sometimes the scan does work. So far I wasn't able to make it work even once since then.
Reloading btusb doesn't help.
Can't install newer package due to deps on glib sadly. I might be able to compile it from source, but that will take some time to figure
out how the components of the bluez stack are connected together.

For the reference I have 'Intel Corp. AX200 Bluetooth' and I have the same device on my AMD laptop and both have USB ID 8087:0029
My AMD laptop has Fedora 34 though.

Best regards,
	Maxim Levitsky



