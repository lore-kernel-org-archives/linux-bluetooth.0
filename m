Return-Path: <SRS0=yJGP=4E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3525AC7619C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 16 Feb 2020 04:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA24420857
	for <linux-bluetooth@archiver.kernel.org>; Sun, 16 Feb 2020 04:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mnmoran.org header.i=@mnmoran.org header.b="RQLEU+Ms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgBPEjR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 Feb 2020 23:39:17 -0500
Received: from hoster906.com ([192.252.156.27]:36364 "EHLO hoster906.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgBPEjR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 Feb 2020 23:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=mnmoran.org; h=subject
        :to:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=dkim; bh=CqnKB2/YqKrL
        vCtk8C2pyfTKfpdLAIfGR66nayRwVp0=; b=RQLEU+Ms15yrIYekGLPQK8nJF/oN
        +by30R6uYnvBDhqsFpzikkOLiYrfHiwBOUZOzjST2JMoPd6i7+mW2ZRGZxFxhRJA
        TYPXadYYYkiWcfx41BmCnwXI6zNvHeLcAuI8vksbG6Zlyc3XXcYopSPkrnPRbuj8
        kRJACbmBHcuJLto=
Received: (qmail 13505 invoked by uid 503); 16 Feb 2020 04:39:16 -0000
Received: from unknown (HELO ?192.168.254.100?) (pop-before-smtp@162.39.210.60)
  by hoster906.com with ESMTPA; 16 Feb 2020 04:39:16 -0000
Subject: Re: mesh: Send mesh model message to group address
To:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <848c1b0b-83c6-41a3-fc66-1359fa9a72bb@mnmoran.org>
 <e2f322b4ba3abb81b59a51d8bb5c3611b968cd4f.camel@intel.com>
From:   "Michael N. Moran" <mike@mnmoran.org>
Message-ID: <410faf08-70e6-ebb2-df7d-79ea1ee0b9f4@mnmoran.org>
Date:   Sat, 15 Feb 2020 23:39:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e2f322b4ba3abb81b59a51d8bb5c3611b968cd4f.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

Thanks for the quick reply.

On 2/15/20 2:50 PM, Gix, Brian wrote:
> Hi Michael,
> On Sat, 2020-02-15 at 13:20 -0500, Michael N. Moran wrote:
>> I've been using meshctl to provision/configure a group of
>> mesh nodes.
> 
> First off, don't use meshctl for work going forward, unless for some reason you *require* GATT support.  Mesh
> is designed to primarily be an Advertising based system, and so all current work is being done on the
> bluetooth-meshd daemon, which does not yet have GATT support.

I've been working on a mesh stack implementation since June, 
so I have a pretty good understanding of the protocol.

I started the development using a now defunct Linux meshd 
project that used PB-ADV for provisioning. It never had much 
mesh support beyond provisioning.

Later, I moved to meshctl after I implemented Mesh 
Provisioning and Mesh Proxy over GATT.

More recently I've been using various silicon vendor Android 
based mesh apps, which all use GATT exclusively.

At the moment, I'm working on the LPN and Friend support.

> We currently have a pretty robust solution based on:
> 
> 1. Run mesh/bluetooth-meshd as root
>      1.1 You may need to first install, *or* copy
>          mesh/bluetooth-mesh.conf --> /etc/dbus-1/system.d/bluetooth-mesh.conf
> 
>      1.2 Make sure mesh/bluetooth-meshd has a dedicated v4.0 or
>          better controller. This can be done by stopping bluetoothd,
>          or by having a 2nd controller in the system and making sure
>          that in /etc/bluetooth/main.conf, AutoEnable=false
> 
>      1.3 reboot
> 
> 2. Run tools/mesh-cfgclient
> 

OK. I'm currently using bluez-5.50 on some rapberry-pi zero 
w unis with in a Yocto build. I use one pi to run meshctl.

Obviously, bluez has changed since I started. :-)

>> There does not seem to be a mechanism in meshctl to send
>> model messages to group addresses or virtual addresses.
>>
>> As an example, consider the simple OnOff model. I can
>> configure the subscription for an OnOff model with a group
>> address. However, the meshctl onoff command will not work
>> with a group address set for the onoff target.
>>
>> I have modified the cmd_set() function in onoff-model.c by
>> removing the node_find_by_addr(target) check and this works
>> fine. Obviously, that only works for the OnOff model. I'd
>> happily submit a patch for that model, but that doesn't seem
>> to be a very good general solution.
>>
>> So is meshctl the right (only) tool to use on Linux?
>> Is there a newer tool that is planned or under development?
> 
> See above, and use the tip of the repository (currently at v5.53)

I cloned the tip and have poked around a bit. However, I 
don't see any OnOff model work other than the 
tools/mesh-gatt/onoff-model.c, which does not *appear* to be 
a part of the mesh-cfgclient build.

I'm probably missing something.
How is this supported in mesh-cfgclient?
