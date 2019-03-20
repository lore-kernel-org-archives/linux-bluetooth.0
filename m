Return-Path: <SRS0=+K9s=RX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0846BC43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Mar 2019 21:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2761218AE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Mar 2019 21:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfCTV1x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:27:53 -0400
Received: from mailfilter03-out40.webhostingserver.nl ([195.211.72.99]:50304
        "EHLO mailfilter03-out40.webhostingserver.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726907AbfCTV1x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Mar 2019 17:27:53 -0400
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Mar 2019 17:27:51 EDT
X-Halon-ID: c4cd11e9-4b54-11e9-9365-001a4a4cb955
Received: from s198.webhostingserver.nl (unknown [195.211.72.171])
        by mailfilter03.webhostingserver.nl (Halon) with ESMTPSA
        id c4cd11e9-4b54-11e9-9365-001a4a4cb955;
        Wed, 20 Mar 2019 22:11:46 +0100 (CET)
Received: from [145.132.48.198] (helo=[192.168.188.20])
        by s198.webhostingserver.nl with esmtpa (Exim 4.90_1)
        (envelope-from <ftoth@exalondelft.nl>)
        id 1h6iUz-0093a5-Og; Wed, 20 Mar 2019 22:11:45 +0100
Subject: Re: [PATCH 2/2] Bluetooth: btbcm: Add default address for BCM2076B1
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20190305130901.56660-1-stephan@gerhold.net>
 <20190305130901.56660-2-stephan@gerhold.net>
 <7b48753f-f103-f522-68c5-38479feb4552@exalondelft.nl>
 <20190319140356.GA1076@gerhold.net>
From:   Ferry Toth <ftoth@exalondelft.nl>
Message-ID: <0898b45c-b59a-0873-d8fc-1755e5c5e23b@exalondelft.nl>
Date:   Wed, 20 Mar 2019 22:11:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319140356.GA1076@gerhold.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-SendingUser: hidden
X-SendingServer: hidden
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: hidden
X-SendingUser: hidden
X-SendingServer: hidden
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Op 19-03-19 om 15:03 schreef Stephan Gerhold:
> Hi,
>
> Sorry for the late response. I've been quite busy lately...
Thanks for responding anyway!
>
> On Tue, Mar 05, 2019 at 07:26:14PM +0100, Ferry Toth wrote:
>> Op 05-03-19 om 14:09 schreef Stephan Gerhold:
>>> BCM2076B1 appears to use 20:76:A0:00:56:79 as default address.
>>> This address is used by at least 5 devices with the AMPAK AP6476
>>> module and is also suspicious because it starts with the chip name
>>> 2076 (followed by a different revision A0 for some reason).
>> With BCM43340 (Edison) it's the same principle. With the fake address I
>> found everything (in user space) seems to work except PAN/NAP (bnep) and no
>> decent error message anywhere making this quite hard to debug.
> Not familiar with PAN/NAP, but the main reason to avoid default
> addresses is that they will cause issues as soon as you have two of
> those devices next to each other.

That might be the main issue with other services, but if you have only a 
single device you won't see this.

With PAN/NAP I found bnep network device is created and immediately 
removed, which confuses connman and give no other message than 'I/O 
error'. Even with only one device.

>>> Add it to the list of default addresses and leave it up to the
>>> user to configure a valid one.
>> Which way is the user supposed to configure the valid one?
>>
> It took me a while to figure this out - there is not much
> documentation for this. The following is only based on my own
> investigations:
>
> As far as the kernel is concerned, HCI_QUIRK_INVALID_BDADDR is exposed
> through the btmgmt API [1]. With the quirk, the BT controller will
> appear as "unconfigured" controller to userspace, and will have the
> public address as missing option. As soon as the address is configured
> with the "Set Public Address Command", the unconfigured controller is
> removed and replaced with a regular controller.
>    Only then it will be usable through bluetoothd.
Yes, Andy Shevchenko already discovered we are missing to put the device 
on the blacklist. I was all ready worried I would get a unconfigured 
controller. Now I see, that is a good thing. Thanks, this is really useful.
> The btmgmt API has to be controlled from user space.
> As far as I know, the only tool in bluez to set the public address
> is the "btmgmt" tool:
>
>    btmgmt -i hci0 public-addr xx:xx:xx:xx:xx:xx
>
> ... will run the "Set Public Address Command" described above.
Especially in combination with this. I will be documenting this for 
Edison, so hopefully other can benefit.
> However, it was mentioned several times that "btmgmt" is not
> a "stable" tool. In other words, it is not installed by default
> and is only intended for debugging. It may change any time.
>
> There was a related discussion on IRC recently: (I was not involved)
>
>    10:50 <Mis012[m]> sjanc: do I need to convince my distro to package
>          btmgmt, or will you revert that commit?
>    10:51 <sjanc> Mis012[m]: I'd ask holtmann about this :) but btmgmt
>          was more like testing tool than real end user tool
>          (ie, no manpages, rather ad-hoc design and command set etc
>    10:53 <sjanc> Mis012[m]: but if you really need this feature,
>          I'd consider starting discussion on mailing list
>          on how this could be handled by bluetoothd
>    10:53 <sjanc> as mentioned, this could be in plugin,
>          either common plugin or maybe platform specific,
>          which would set public address via mgmt api
>    10:54 <sjanc> open point is how bluetootd would extract public address,
>          which is always platform specific
>    10:55 <holtmann> Mis012[m]: btmgmt is not a stable tool.
>    10:55 <Mis012[m]> holtmann: but it's the only one which can do this
>    10:56 <holtmann> Then add support to bluetoothd for it or do it via an
>          external tool / daemon. I wrote a long post to the mailing list
>          about that.
>
> I have such an external daemon for Android (since it does not use bluez)
> at [2]. It would be easy to refactor it to something more portable.
Do I understand correct: support needs to go into bluetoothd first and 
then into bluetoothctl?
>
> [1]: https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/mgmt-api.txt
> [2]: https://github.com/me176c-dev/android_device_asus_K013/blob/lineage-16.0/bluetooth/bdaddr.c
>
>> The only way I found is bd_addr (tool from bluez that is not normally
>> built/installed).
>>
>> Using this tool requires hci0 to be up and bluetoothd to be restarted if
>> that was already running, which is quite inconvenient.
>>
> bdaddr does not use the btmgmt API. It sends vendor-specific commands to
> the HCI interface. This might be the reason why you need to restart
> bluetoothd.
I see.
>
> With HCI_QUIRK_INVALID_BDADDR set, the BT controller should not show up
> at all in bluetoothctl until its public address is configured.
> It does not matter if bluetoothd is started too early.
>
>> I also saw there was a patch to put the address in dt.
>>
>> But nowhere did I find a kernel parameter to pass the address. Did I miss
>> something?
>>
> I'm not familiar with setting the address from DT/kernel parameters.
> Sorry :(
To me sounds like reading from a configuration file on disk would make 
more sense.
