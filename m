Return-Path: <SRS0=lCj9=MW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10101C43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Oct 2018 15:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68232086E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Oct 2018 15:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68232086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chicoree.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJJWnu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:43:50 -0400
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:60459 "EHLO
        2.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJJWnu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Oct 2018 18:43:50 -0400
X-Greylist: delayed 4229 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Oct 2018 18:43:50 EDT
Received: from player758.ha.ovh.net (unknown [10.109.160.253])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id AF257188CD9
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Oct 2018 14:53:44 +0200 (CEST)
Received: from [10.129.36.18] (reverse-177-9.fdn.fr [80.67.177.9])
        (Authenticated sender: sylvain@chicoree.fr)
        by player758.ha.ovh.net (Postfix) with ESMTPSA id 302D22C00B7;
        Wed, 10 Oct 2018 14:53:42 +0200 (CEST)
Subject: Re: Serial communication over BT using the DBus API
To:     Barry Byford <31baz66@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
References: <7246fd0d-022f-0d7b-ab09-1030ac06e0fa@chicoree.fr>
 <CAAu3APYwnuB+XTuo3jOX=HFsFLWd2X-HW6YdfYnmn51fah=_ag@mail.gmail.com>
 <6a77b228-2603-3413-7ffb-fb8f178a09f1@chicoree.fr>
 <CAAu3APaJ3XyPnSuE8UUxW7N8fqcOVd6xKB0hYcd3svV=x5dO0A@mail.gmail.com>
From:   Sylvain Leroux <sylvain@chicoree.fr>
Message-ID: <1e8c15e4-5597-91c7-7554-51cd78cfe92a@chicoree.fr>
Date:   Wed, 10 Oct 2018 14:53:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAu3APaJ3XyPnSuE8UUxW7N8fqcOVd6xKB0hYcd3svV=x5dO0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17750937935221395086
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrudeigdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



On 10/09/2018 11:09 PM, Barry Byford wrote:
>> I'm currently investigating how I could use `busctl` to reproduce that
>> behavior.
> 
> Not my area of expertise but it seems like it might be difficult
> because there would be no event loop.

I tried something like that:


----
busctl call \
    org.bluez /org/bluez org.bluez.ProfileManager1 RegisterProfile \
    'osa{sv}' \
    /bluez \
    "00001101-0000-1000-8000-00805f9b34fb" \
    3 'Role' s server 'Channel' u 1 Name s 'SerialPort'
----

I'm not 100% confident with the syntax. I also tried using
`bluetoothctl` for that, but I'm even less confident with the syntax:

----
bluetoothctl << EOF
register-profile 'osa{sv}' /bluez "00001101-0000-1000-8000-00805f9b34fb"
3 'Role' s server 'Channel' u 1 Name s 'SerialPort'
EOF
----


Nevertheless, as you suggested, each of these solutions seems doomed
since, according to the documentation:


(from https://github.com/pauloborges/bluez/blob/master/doc/profile-api.txt)
> If an application disconnects from the bus all
> its registered profiles will be removed.


If I understand it well, that means even if I was able to register a new
profile, it will be removed as soon as `busctl` or `bluetoothctl`
terminate. Or did I misunderstand the whole thing?


