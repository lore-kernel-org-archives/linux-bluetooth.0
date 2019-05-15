Return-Path: <SRS0=OL4k=TP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91505C04E53
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 May 2019 11:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F02420843
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 May 2019 11:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbfEOL4M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 May 2019 07:56:12 -0400
Received: from atl4mhob13.registeredsite.com ([209.17.115.51]:51964 "EHLO
        atl4mhob13.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730999AbfEOL4L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 May 2019 07:56:11 -0400
Received: from mailpod.hostingplatform.com (atl4qobmail02pod5.registeredsite.com [10.30.71.85])
        by atl4mhob13.registeredsite.com (8.14.4/8.14.4) with ESMTP id x4FBu7wk027987
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2019 07:56:07 -0400
Received: (qmail 139360 invoked by uid 0); 15 May 2019 11:56:07 -0000
X-TCPREMOTEIP: 208.85.15.155
X-Authenticated-UID: sbrown@opensat.com
Received: from unknown (HELO 155-15-85-208.altiusbb.net) (sbrown@opensat.com@208.85.15.155)
  by 0 with ESMTPA; 15 May 2019 11:56:07 -0000
Received: from localhost (localhost [127.0.0.1])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id 630B0154042F;
        Wed, 15 May 2019 07:56:06 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at ewol.com
Received: from 155-15-85-208.altiusbb.net ([127.0.0.1])
        by localhost (fl-server.ewol.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ih4uINjXV6CC; Wed, 15 May 2019 07:55:59 -0400 (EDT)
Received: from z230.lan (z230.lan [192.168.1.3])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id D5FCE1540278;
        Wed, 15 May 2019 07:55:59 -0400 (EDT)
Message-ID: <07f90b48d482ff6bb88be4734b41a08ac5a98592.camel@ewol.com>
Subject: Re: Issue with mesh provisioning.
From:   Steve Brown <sbrown@ewol.com>
To:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc:     Shaik Mahaboob Nazeer <nazeer.m@phytec.in>,
        linux-bluetooth@vger.kernel.org,
        Jonas Remmert <j.remmert@phytec.de>
Date:   Wed, 15 May 2019 07:55:59 -0400
In-Reply-To: <CACumGOKJckqHDsB==1MwNFOtZVtduRPZhTmtbQT-fTaztuv+dQ@mail.gmail.com>
References: <33a1f056-12c2-1aaa-4172-ea1fba341428@phytec.in>
         <a133a8d46955c9c3d248cf06e52d445a82ed7621.camel@ewol.com>
         <0ec70f654132923489ee2603fe9ac885ac547830.camel@ewol.com>
         <CACumGOKJckqHDsB==1MwNFOtZVtduRPZhTmtbQT-fTaztuv+dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Luiz,

Some more:

The recvmsg call at tools/mesh/gatt.c:417 returns -1 and
errno 11 "Resource temporarily unavailable"

The log follows. The first read succeeded, but the second fails.

======================

[CHG] Controller 00:1A:7D:DA:71:14 Discovering: no
Connection successful
Services resolved yes
Found matching char: path /org/bluez/hci0/dev_D0_09_F0_18_BF_38/service0010/char0011, uuid 00002adb-0000-1000-8000-00805f9b34fb
Found matching char: path /org/bluez/hci0/dev_D0_09_F0_18_BF_38/service0010/char0013, uuid 00002adc-0000-1000-8000-00805f9b34fb
Start notification on /org/bluez/hci0/dev_D0_09_F0_18_BF_38/service0010/char0013
Characteristic property changed /org/bluez/hci0/dev_D0_09_F0_18_BF_38/service0010/char0013
AcquireNotify success: fd 7 MTU 69
Notify for Mesh Provisioning Out Data started
Open-Node: 0x555776243190
Open-Prov: 0x555776234250
Open-Prov: proxy 0x55577623f3f0
Initiated provisioning
Characteristic property changed /org/bluez/hci0/dev_D0_09_F0_18_BF_38/service0010/char0011
AcquireWrite success: fd 8 MTU 69
GATT-TX:	 03 00 10 
sock_read len: 13
GATT-RX:	 03 01 04 00 01 00 00 06 00 18 00 00 00 
sock_read len_sar: 13
Got provisioning data (12 bytes)
	 01 04 00 01 00 00 06 00 18 00 00 00 
GATT-TX:	 03 02 00 00 02 04 06 
GATT-TX:	 03 03 e4 ae 6e 5e fc b7 b9 63 74 f0 ca 71 89 c4 
GATT-TX:	 af 00 a2 fd f8 74 1d fd 87 74 8a 86 20 91 bd ed 
GATT-TX:	 54 87 6b 63 5d ec 42 1f 19 fb 1a c9 05 88 b0 be 
GATT-TX:	 91 80 97 ce c4 f3 b0 79 72 12 e9 bb 81 a2 8e ed 
GATT-TX:	 a5 6b 
sock_read len: -1
sock_read error 11 Resource temporarily unavailable[Zephyr]# quit

=================

On Wed, 2019-05-15 at 13:48 +0300, Von Dentz, Luiz wrote:
> Hi Steve,
> 
> That specific patch doesn't change the meshctl, the following one
> does:
> 
> commit d6eec1b67d6d9e3336b7e3cd8f655baf408d864a
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Mon Nov 19 17:35:54 2018 +0200
> 
>     meshctl: Switch from write to sendmsg for Acquire*
> 
>     Use sendmsg with MSG_NOSIGNAL to prevent crashes involving
> SIGPIPE.
> 
> Not sure what is the problem with that since we just switch from a
> pipe to a socketpair.
> 
> On Wed, May 15, 2019 at 1:01 PM Steve Brown <sbrown@ewol.com> wrote:
> > On Tue, 2019-05-14 at 15:25 -0400, Steve Brown wrote:
> > > On Tue, 2019-05-14 at 14:50 +0530, Shaik Mahaboob Nazeer wrote:
> > > > hi,
> > > > 
> > > > -> We tried Zephyr Mesh onoff example on nrf52 eval kit to test
> > > > the
> > > > Mesh Functionality.For provisioning of the node
> > > >    we are using meshctl, built from the latest current master
> > > > of
> > > > the
> > > > bluez source.So during the provisioning of the node when we
> > > >    start the "meshctl" and run the "discover-unprovisioned on"
> > > > we
> > > > are
> > > > able to get the Device UUID for the provisioning.
> > > > 
> > > >    Later when we try to provision the node using the "provision
> > > > <UUID>" command it initiate the provision and does not wait
> > > >    for the user to enter OOB .You can find the log as below.
> > > >    /*******************************************/
> > > > 
> > > 
> > > --- snip ---
> > > 
> > > >   /**************************************/
> > > > 
> > > > Could you elaborate a little on the status of the current
> > > > master of
> > > > bluez in regards to BLE mesh, is it usable or should we look to
> > > > older
> > > > versions?
> > > > 
> > > > Do you know if there is a common issue while provisioning of
> > > > the
> > > > node
> > > > with the current master and
> > > > is there anything that need to be configured before
> > > > provisioning?
> > > > 
> > > I get the same results.
> > > 
> > > I check out 48a2c3db1ccff28a615fac56066ca7d721f98d0a
> > > 
> > > That was the last time I used meshctl.
> > > 
> > > It requests an oob string and completes provisioning.
> > > 
> > > Steve
> > > 
> > 
> > I bisected to
> > 
> > commit 91df85690cc1943e46ef90561dd1ac0d673ee3d7
> > Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Date:   Mon Nov 19 15:36:15 2018 +0200
> > 
> >     client: Switch from write to sendmsg for Acquire*
> > 
> >     Use sendmsg with MSG_NOSIGNAL to prevent crashes involving
> > SIGPIPE.
> > 
> > 
> > 

