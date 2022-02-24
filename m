Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752CEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 16:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiBXQ3u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiBXQ3u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 11:29:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68B111A3615
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 08:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645720156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F0gekTUOa2xUf/JXAP28TEkOv5+K+Sq5W2ohEMm8vKY=;
        b=A33h4h2XVTZwPNiap7cDI4Vu8/HOE+v1E2V0Rk84qNLF/iifJz8Qwkg6ihjxF8nOajXzM2
        vybZPQhaUzzK1LvftjveO5PWV9/qSWC6heB8TJ/q56qxUbj2pg4FWXW5lOcTDuhdhHNp/v
        r9bZzTkc8PpzG0vQD05vb1tUfN09xOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-BtUed3iJP2e3_gq8ODRyhQ-1; Thu, 24 Feb 2022 11:29:13 -0500
X-MC-Unique: BtUed3iJP2e3_gq8ODRyhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A015D1006AA8;
        Thu, 24 Feb 2022 16:29:11 +0000 (UTC)
Received: from starship (unknown [10.40.195.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC955865BC;
        Thu, 24 Feb 2022 16:29:09 +0000 (UTC)
Message-ID: <0838aa454b7b127fab1b2a945180304088251b13.camel@redhat.com>
Subject: Re: Since commit e8907f76544ffe225ab95d70f7313267b1d0c76d bluetooth
 scanning stopped working on my system
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
Date:   Thu, 24 Feb 2022 18:29:08 +0200
In-Reply-To: <fc74637a-f3c8-7870-82ec-90bf55b60462@molgen.mpg.de>
References: <f648f2e11bb3c2974c32e605a85ac3a9fac944f1.camel@redhat.com>
         <CABBYNZKWpPvJvKefgjw5YXCk9BL7900X+XnobLS6gw+50wKNfA@mail.gmail.com>
         <31367223b2e310521493b257244c188f3c22a619.camel@redhat.com>
         <fc74637a-f3c8-7870-82ec-90bf55b60462@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 2022-02-24 at 16:43 +0100, Paul Menzel wrote:
> Dear Maxim,
> 
> 
> Am 24.02.22 um 14:01 schrieb Maxim Levitsky:
> > On Tue, 2022-02-22 at 10:35 -0800, Luiz Augusto von Dentz wrote:
> > > On Mon, Feb 21, 2022 at 7:14 PM Maxim Levitsky wrote:
> > > > Today I updated to a new kernel and I am bisecting few 
> > > > regressions:
> 
> […]
> 
> > I do notice that even on 5.16 kernel, I am not able to use the HSF
> > or whatever low quality bi-directional bluetooh protocol is called
> > for my headset. Used to work, I don't know what broke it, likely not 
> > related to this.
> > 
> > I also updated bluez to 5.6 by installing fedora 33 package, and 
> > initially it seems to work, but after reboot, the issue shows up 
> > again. Looks like sometimes the scan does work. So far I wasn't able 
> > to make it work even once since then. Reloading btusb doesn't help. 
> > Can't install newer package due to deps on glib sadly. I might be 
> > able to compile it from source, but that will take some time to 
> > figure out how the components of the bluez stack are connected 
> > together.
> > 
> > For the reference I have 'Intel Corp. AX200 Bluetooth' and I have
> > the same device on my AMD laptop and both have USB ID 8087:0029 My
> > AMD laptop has Fedora 34 though.
> 
> Sorry, I lost track, if it’s still about one regression, you 
> successfully bisected or not.
yes, I sucessfully bisected the regression. 1 commit before mentioned commit
the bluetooth works for me, and not after it, with same .config and everything else.


> 
> Anyway, passing through the USB Bluetooth device to QEMU helped me [1], 
> and might help you to overcome the dependency problems. (My steps 
> actually worked, but turned out the Linux kernel commit I tested with 
> had another regression not making the Bluetooth controller initialize.)
First thing I tried, but alas it worked for me in fedora 34 VM I tried to test with
(with the same 5.17-rc5 kernel, albeet with different .config, more tailored for a VM).

Best regards,
	Maxim Levitsky

> 
> Marcel also replied, he is using btproxy to debug issues, but I did not 
> try it, as it wasn’t clear to me how to get it working easily, and he 
> also wrote something about non-public patches.
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: 
> https://lore.kernel.org/linux-bluetooth/5891f0d5-8d51-9da5-7663-718f301490b1@molgen.mpg.de/T/#u
> 


