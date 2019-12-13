Return-Path: <SRS0=edj+=2D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0155BC43603
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Dec 2019 23:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFAF0214AF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Dec 2019 23:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfLMXsQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:48:16 -0500
Received: from jax4mhob23.registeredsite.com ([64.69.218.111]:53584 "EHLO
        jax4mhob23.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbfLMXsQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Dec 2019 18:48:16 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.85])
        by jax4mhob23.registeredsite.com (8.14.4/8.14.4) with ESMTP id xBDNm9D0144291
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2019 18:48:09 -0500
Received: (qmail 58141 invoked by uid 0); 13 Dec 2019 23:48:09 -0000
X-TCPREMOTEIP: 208.85.15.155
X-Authenticated-UID: sbrown@opensat.com
Received: from unknown (HELO 155-15-85-208.altiusbb.net) (sbrown@opensat.com@208.85.15.155)
  by 0 with ESMTPA; 13 Dec 2019 23:48:09 -0000
Received: from localhost (localhost [127.0.0.1])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id 715361540556;
        Fri, 13 Dec 2019 18:48:08 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at ewol.com
Received: from 155-15-85-208.altiusbb.net ([127.0.0.1])
        by localhost (fl-server.ewol.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LZ7ZvGUlLGYF; Fri, 13 Dec 2019 18:48:01 -0500 (EST)
Received: from w7.lan (w7.lan [192.168.1.9])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id 876BF15400CE;
        Fri, 13 Dec 2019 18:48:01 -0500 (EST)
Message-ID: <dd06eec8d9bc44e40b3bfae453b1424608c9c885.camel@ewol.com>
Subject: Re: Bluez mesh-cfgclient: Not able to configure the device
From:   Steve Brown <sbrown@ewol.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "aabhay169@gmail.com" <aabhay169@gmail.com>
Cc:     "ay.agarwal@samsung.com" <ay.agarwal@samsung.com>,
        "anupam.r@samsung.com" <anupam.r@samsung.com>
Date:   Fri, 13 Dec 2019 18:48:01 -0500
In-Reply-To: <c68d91215e510b319ac569633f0fcd388d505f73.camel@intel.com>
References: <CALbZ3NJniYdZXgaNDR9778cfbr7kkNhGEeSm3pDqwOHXRp8Thg@mail.gmail.com>
         <083b4e2c7f18c4043ad939289a09c057b4c5e8c5.camel@intel.com>
         <CALbZ3NJ6JDjoB3Vr2aROP6mkJZwL1QtPrrBPyc8X6=PO_C9wsw@mail.gmail.com>
         <c68d91215e510b319ac569633f0fcd388d505f73.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhay,

On Tue, 2019-12-10 at 15:27 +0000, Stotland, Inga wrote:
> Hi Abhay,
> 
> On Tue, 2019-12-10 at 18:20 +0530, Abhay Agarwal wrote:
> > Hi Inga
> > 
> > 
> > Thanks for the reply
> > 
> > Unfortunately we are still not able to resolve the issue
> > 
> > We have used following mesh-cfgclient commands
> > 
> > 
> > [mesh-cfgclient]# create
> > 
> > [mesh-cfgclient]# appkey-create 0000 0001
> > 
> > [mesh-cfgclient]# discover-unprovisioned on
> > 
> > Unprovisioned scan started
> > 
> > Scan result:
> > 
> >     rssi = -62
> > 
> >     UUID = F24B3F329DF200000000000000000000
> > 
> > 
> > [mesh-cfgclient]# provision F24B3F329DF200000000000000000000
> > 
> > Provisioning started
> > 
> > Assign addresses for 4 elements
> > 
> > Provisioning done:
> > 
> > Mesh Node:
> > 
> >     UUID = F24B3F329DF200000000000000000000
> > 
> >     Primary = 00aa
> > 
> >     elements = 4
> > 
> > 
> > [mesh-cfgclient]# menu config
> > 
> > [mesh-cfgclient]# target 00aa
> > 
> > [config: Target = 00aa] appkey-add 0001
> > 
> > No response for "AppKeyAdd" from 00aa
> > 
> > 
> > We have also confirmed that the local NetKey with index 0000 and
> > appkey with index 0001 are both present, as used in above commands.
> > As can be seen in config_db.json
> > "netKeys":[
> >     {
> >          "index":"0000"
> >      }
> >   ],
> > "appKeys":[
> >     {
> >          "boundNetKey":"0000",
> >          "index":"0001"
> >      }
> >   ],
> > 
> > 
> > Please advise what can be done to resolve this issue.
> > 
> > 
> > Thanks and regards
> > Abhay Agarwal
> > On Saturday, December 7, 2019, Stotland, Inga <
> > inga.stotland@intel.com> wrote:
> > > Hi Abhay,
> > > 
> > > On Fri, 2019-12-06 at 15:55 +0530, Abhay Agarwal wrote:
> > > > Hi
> > > > 
> > > > I am trying the mesh-cfgclient tool to control a sylvania
> > > > smart+
> > > > bulb with it.
> > > > I am able to provision the device on PB-ADV.
> > > > 
> > > > Unfortunately I am not able to configure the device. It shows
> > > > the
> > > > error message as
> > > > [config: Target = 00aa]# appkey-add 0
> > > > No response for "AppKeyAdd" from 00aa
> > > > 
> > > > Note that I have been able to configure and control the device
> > > > (on/off) using meshctl.
> > > > 
> > > > Please advise what can be the issue and how to debug this.
> > > > 
> > > > Thanks and Regards,
> > > > Abhay Agarwal
> > > 
> > > I suspect that the reason is for this behavior is the fact that a
> > > local AppKey with index "0" does not exist.
> > > 
> > > Prior to sending AppKeys or NetKeys to a remote node,the keys
> > > need
> > > to be generated locally by executing
> > > commands from the main mesh-cfgclient menu:
> > > "create-subnet" for a NetKey
> > > and
> > > "create-appkey" for an AppKey
> > > 
> > > Best regards,
> > > Inga
> > > 
> 
> Are you able to run the bluetoooth-meshd daemon in debug mode, i.e.,
> start it from the command  line with "-nd" option? It would be
> helpful
> to see if the appkey message is being sent to the remote node.
> 
> Best regardds,
> Inga
> 
> 
I was able to successfully perform that same sequence without a
problem. I created an appkey 0 and 1 and added them to my Sylvania
lamp.

[config: Target = 00c5]# appkey-add 0
Received AppKeyStatus
Node 00c5 AppKey status Success
NetKey	000
AppKey	000
[config: Target = 00c5]# appkey-add 1
Received AppKeyStatus
Node 00c5 AppKey status Success
NetKey	000
AppKey	001

I found that my Sylvania lamps arrived mostly broken and wouldn't do
much until their firmware was updated with the Sylvania ios app.

Also, PB-ADV hasn't been super reliable for me. Sometimes, I have to
repeat the command before I get a status response. 

Steve


