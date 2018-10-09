Return-Path: <SRS0=otBP=MV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1C5C64EB0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Oct 2018 21:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE3020C0A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Oct 2018 21:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE3020C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chicoree.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeJJExP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:53:15 -0400
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:34790 "EHLO
        9.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJExP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Oct 2018 00:53:15 -0400
X-Greylist: delayed 2261 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Oct 2018 00:53:14 EDT
Received: from player789.ha.ovh.net (unknown [10.109.143.249])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id 5DDB4DC34F
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Oct 2018 22:56:46 +0200 (CEST)
Received: from [10.129.36.18] (reverse-177-9.fdn.fr [80.67.177.9])
        (Authenticated sender: sylvain@chicoree.fr)
        by player789.ha.ovh.net (Postfix) with ESMTPSA id D8AF02600A7;
        Tue,  9 Oct 2018 22:56:43 +0200 (CEST)
Subject: Re: Serial communication over BT using the DBus API
To:     Barry Byford <31baz66@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
References: <7246fd0d-022f-0d7b-ab09-1030ac06e0fa@chicoree.fr>
 <CAAu3APYwnuB+XTuo3jOX=HFsFLWd2X-HW6YdfYnmn51fah=_ag@mail.gmail.com>
From:   Sylvain Leroux <sylvain@chicoree.fr>
Message-ID: <6a77b228-2603-3413-7ffb-fb8f178a09f1@chicoree.fr>
Date:   Tue, 9 Oct 2018 22:56:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAu3APYwnuB+XTuo3jOX=HFsFLWd2X-HW6YdfYnmn51fah=_ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1589207720549518990
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrudeggdduheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenuc
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Barry,

Thanks for the reply:

On 10/09/2018 10:30 PM, Barry Byford wrote:
> You might want to take a look at the Bluedot library that has used the
> DBus API to communicate over the Serial Port Profile.
> Server:
> https://github.com/martinohanlon/BlueDot/blob/master/bluedot/btcomm.py#L141
> Client:
> https://github.com/martinohanlon/BlueDot/blob/master/bluedot/btcomm.py#L466
> 
> The main section using DBus is in:
> https://github.com/martinohanlon/BlueDot/blob/master/bluedot/utils.py

I started to explore the bluedot sources. From what I understand, I need
in the shell something like the `register_spp` function
(https://github.com/martinohanlon/BlueDot/blob/master/bluedot/utils.py#L101)


I'm currently investigating how I could use `busctl` to reproduce that
behavior.

I noticed the function mostly send some XML description to the
`org.bluez.ProfileManager1` interface (see code below). There are a
couple of hard coded constants in the code, including the UUID
"00001101-0000-1000-8000-00805f9b34fb". Are those "well known" values I
can blindly use?


- Sylvain


----
def register_spp(port):

    service_record = """
    <?xml version="1.0" encoding="UTF-8" ?>
    <record>
      <attribute id="0x0001">
        <sequence>
          <uuid value="0x1101"/>
        </sequence>
      </attribute>
      <attribute id="0x0004">
        <sequence>
          <sequence>
            <uuid value="0x0100"/>
          </sequence>
          <sequence>
            <uuid value="0x0003"/>
            <uint8 value="{}" name="channel"/>
          </sequence>
        </sequence>
      </attribute>
      <attribute id="0x0100">
        <text value="Serial Port" name="name"/>
      </attribute>
    </record>
    """.format(port)

    bus = dbus.SystemBus()

    manager = dbus.Interface(bus.get_object(SERVICE_NAME, "/org/bluez"),
PROFILE_MANAGER)

    path = "/bluez"
    uuid = "00001101-0000-1000-8000-00805f9b34fb"
    opts = {
#        "AutoConnect" : True,
        "ServiceRecord" : service_record
    }

    try:
        manager.RegisterProfile(path, uuid, opts)
    except dbus.exceptions.DBusException as e:
        #the spp profile has already been registered, ignore
        if str(e) != "org.bluez.Error.AlreadyExists: Already Exists":
            raise(e)
----
