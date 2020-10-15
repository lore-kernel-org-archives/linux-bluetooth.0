Return-Path: <SRS0=NBlN=DW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0210FC433E7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 20:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F6CD20759
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 20:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=snewbury.org.uk header.i=@snewbury.org.uk header.b="hKG0t6ki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392330AbgJOUgt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Oct 2020 16:36:49 -0400
Received: from know-smtprelay-omc-9.server.virginmedia.net ([80.0.253.73]:57275
        "EHLO know-smtprelay-omc-9.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392305AbgJOUgK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Oct 2020 16:36:10 -0400
Received: from mail.snewbury.org.uk ([86.24.188.28])
        by cmsmtp with ESMTPA
        id T9ypkHyjXq8OAT9ypkJajR; Thu, 15 Oct 2020 21:36:07 +0100
X-Originating-IP: [86.24.188.28]
X-Authenticated-User: sjnewbury@virginmedia.com
X-Spam: 0
X-Authority: v=2.3 cv=WuMFz+Xv c=1 sm=1 tr=0 a=1Au+4VMCrm8g9YIHxruHCQ==:117
 a=1Au+4VMCrm8g9YIHxruHCQ==:17 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=afefHYAZSVUA:10 a=N1CowNylAAAA:8 a=VwQbUJbxAAAA:8 a=RC3RnfkK1g4JzTiRlqcA:9
 a=8VnVOQpA_V8CsW3A:21 a=SrWvuh-4m88bLPUN:21 a=QEXdDO2ut3YA:10
 a=sPYuha5Ws6K-Rx_L469D:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=snewbury.org.uk;
         h=content-transfer-encoding:mime-version:user-agent
        :content-type:content-type:references:in-reply-to:date:date:from
        :from:subject:subject:message-id; s=eater; t=1602793983; x=
        1604608384; bh=AFHh+kkZwqzb6xIgL1AT2r9dg3goMuPq0MeM9NSV7e8=; b=h
        KG0t6ki0v7UUFyfXavFsbj6rI8/78D1tzjM/yk6i6JsU7WC8sfjHpGGPdewEylbg
        fpqsuNVRBaof0boVRSZW4EaTAQD06iVeNbCqqWk4rMvXrA3neG+b0m0euWkAsIXk
        iillgRSjaYwE74u1j3avpL+yjl4LF1IFUYW3I8wB+Y=
X-Virus-Scanned: amavisd-new at snewbury.org.uk
Received: from artifact.local ([IPv6:2001:470:6efd:f101:0:0:0:a58])
        (authenticated bits=0)
        by mail.snewbury.org.uk (8.16.1/8.16.1) with ESMTPSA id 09FKX3e8161608
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Oct 2020 21:33:03 +0100
Message-ID: <5a48225728860dbee779ea54c112e8cfa2cfddfd.camel@snewbury.org.uk>
Subject: Re: [PATCH] 100% CPU usage on keyboard disconnect
From:   Steven Newbury <steve@snewbury.org.uk>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Thu, 15 Oct 2020 21:36:14 +0100
In-Reply-To: <CABBYNZ+ahHHmZx2dOx8zpQ34LEiYk0btpLQ_6Kv8e6+d_Ko66g@mail.gmail.com>
References: <f6d623eecc635022b85a31359b2f11b0104267c5.camel@snewbury.org.uk>
         <CABBYNZ+ahHHmZx2dOx8zpQ34LEiYk0btpLQ_6Kv8e6+d_Ko66g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIaHNptCJnMmu1cLt464pmQg37fMjlU4LT+1//wf6q1Bbqz6b1VahenYijhT5gmsgiIyzYj1P+MH3oS7zBm7dnW8VSwKhRFBHoPwHlqanzkGuF0GWlSH
 GmEKQ+OFeUYAEbZW9sZVniUM/20C+Jc5xqive6Im9Jz6MQMuQMwRNxDIbO9uzQ7+fIDf2/VEqVPO0R8xEHkGTwS/SBe8JleQYTjEIAMCYzlqHt48jspUw5bC
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 2020-10-15 at 10:12 -0700, Luiz Augusto von Dentz wrote:
> Hi Steven,
> 
> On Thu, Oct 15, 2020 at 4:13 AM Steven Newbury <steve@snewbury.org.uk
> > wrote:
> > There are a couple of issues with g_io_channel usage in bluez which
> > cause CPUs to spin on half-closed channels.
> > 
> > This patch fixes bugs where bluetooth keyboards fail to work on
> > initial
> > connection, and cause 100% cpu on disconnect.
> > 
> > Also fix bug with similar symptoms triggered by some other HID
> > devices
> > such as Sony PS3 BD Remotes.
> > 
> > In the previous discussion on the kernel bugzilla below, it was
> > suggested to remove sec_watch, and I attached a follow-up patch to
> > do
> > so, however that change causes problems with current bluez-5
> > releases
> > where a fd is used after being closed.
> > 
> > See https://bugzilla.kernel.org/show_bug.cgi?id=204275
> > 
> > Signed-off-by: Steven Newbury <steve@snewbury.org.uk>
> > ---
> >  attrib/interactive.c    | 4 +++-
> >  profiles/input/device.c | 3 ++-
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/attrib/interactive.c b/attrib/interactive.c
> > index 9a7976d34..453ff064e 100644
> > --- a/attrib/interactive.c
> > +++ b/attrib/interactive.c
> > @@ -64,6 +64,7 @@ static int opt_psm = 0;
> >  static int opt_mtu = 0;
> >  static int start;
> >  static int end;
> > +static guint gsrc;
> > 
> >  static void cmd_help(int argcp, char **argvp);
> > 
> > @@ -193,6 +194,7 @@ static void disconnect_io()
> >         attrib = NULL;
> >         opt_mtu = 0;
> > 
> > +       g_source_remove(gsrc);
> >         g_io_channel_shutdown(iochannel, FALSE, NULL);
> >         g_io_channel_unref(iochannel);
> >         iochannel = NULL;
> > @@ -415,7 +417,7 @@ static void cmd_connect(int argcp, char
> > **argvp)
> >                 error("%s\n", gerr->message);
> >                 g_error_free(gerr);
> >         } else
> > -               g_io_add_watch(iochannel, G_IO_HUP,
> > channel_watcher, NULL);
> > +               gsrc = g_io_add_watch(iochannel, G_IO_HUP,
> > channel_watcher, NULL);
> >  }
> 
> I wouldn't bother with the fix above since the attrib part will be
> going away soon.
> 
> >  static void cmd_disconnect(int argcp, char **argvp)
> > diff --git a/profiles/input/device.c b/profiles/input/device.c
> > index a711ef527..9abf595f6 100644
> > --- a/profiles/input/device.c
> > +++ b/profiles/input/device.c
> > @@ -982,7 +982,8 @@ static int hidp_add_connection(struct
> > input_device *idev)
> >                 }
> > 
> >                 idev->req = req;
> > -               idev->sec_watch = g_io_add_watch(idev->intr_io,
> > G_IO_OUT,
> > +               if (!idev->sec_watch)
> > +                       idev->sec_watch = g_io_add_watch(idev-
> > >intr_io, G_IO_IN,
> >                                                         encrypt_not
> > ify, idev);
> 
> If this is happening isn't there a idev->req already set and we are
> overwriting it?
> 
It was definitely causing a problem, but I can't remember exactly what
occurred, I wrote the patch originally years ago!  I think it leaked
the watch.


