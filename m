Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <468A94D1.7050107@am.sony.com>
Date: Tue, 03 Jul 2007 11:26:25 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>,
        cbe-oss-dev@ozlabs.org, bluez-devel@lists.sf.net
Subject: Re: [Cbe-oss-dev] [Bluez-devel] [PATCH] bluetooth: reset unexpected
 connections
References: <18a15270707021204o3ffc0021pc3f0d4b0ec278c39@mail.gmail.com> <1183433306.6351.19.camel@aeonflux.holtmann.net>
In-Reply-To: <1183433306.6351.19.camel@aeonflux.holtmann.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi Ranulf,
> 
>> Send a reset command to any device that sends us data when there is no
>> active
>> connection to that device. This hopefully discourages the device from
>> sending 
>> any more data which causes the syslog to fill up rapidly otherwise.
>> 
>> Signed-off-by: Ranulf Doswell <ralf@ranulf.net>
>> 
>> ---
>> 
>> An example device which causes this problem is the Sony Playstation
>> six-axis 
>> controller which continues sending data even after the host is
>> rebooted as
>> the linux kernel stack returns before the controller's stack times
>> out.
> 
> this is not a proper fix for this problem. And you only reset the local
> host controller. There is no way to send a reset to the remote device.
> 
> Did you ever used hcidump and try to find out, why the other side still
> things that we are connected. Especially why the local controller things
> that we are still connected.
> 
> The PS3 remote controller (and the PS3 itself) have special hacked up
> version of Bluetooth firmware to play nice with remote wakeup. So it
> might simply be an issue with them and it might be better we declare
> them broken instead of adding nasty crap in a clean Bluetooth core. Your
> patch is nasty crap since I haven't seen any real argument why we should
> reset our local controller in that case. It is wild guessing.

I'll look at this in more detail when I have some time, maybe in a month or so.

-Geoff
