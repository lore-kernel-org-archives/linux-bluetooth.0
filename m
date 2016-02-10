Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAMmcSSVJ_mgKjhOWO5Y_Y0FhBRefT+bFshf3hcg2Wtoe5K-qg@mail.gmail.com>
References: <CAAMmcSSVJ_mgKjhOWO5Y_Y0FhBRefT+bFshf3hcg2Wtoe5K-qg@mail.gmail.com>
Date: Wed, 10 Feb 2016 13:08:20 +0200
Message-ID: <CABBYNZK0MYD6qedxBOwAD3f1-G-jUhFS2jNvF4H6Qpg=VtmVsA@mail.gmail.com>
Subject: Re: GATT server
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?Mikl=C3=B3s_Fazekas?= <mfazekas@szemafor.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Miklós,



On Tue, Feb 9, 2016 at 11:03 PM, Miklós Fazekas <mfazekas@szemafor.com> wrote:
> Hi
>
> I'm trying to develop a GATT server with bluez on a raspberry to
> communicate with iOS via BLE.
>
> I've managed to get one working with bluez 5.28 based on
> plugins/gatt-example.c (gatt_service_add). But i have some weird
> issues when sending more 70 bytes in a packet to iOS devices - not
> always but sometimes.
>
> So i try to upgrade bluez to investigate on the latest version. My
> understanding is that while the plugins/gatt_service_add is still in
> 5.37 repo, and they compile fine, they are now depreacted, and dbus is
> the replacement.
>
> I'm a dbus newby. I configured/running with experimental. Moreover
> python example (../test/example-gatt-server) seems to work fine. But
> running C example (tools/gatt-service) gives me this error:
>
>    RegisterService: Method "RegisterService" with signature "oa{sv}"
> on interface "org.bluez.GattManager1" doesn't exist
>
> But my limited dbus fu on python showed this signature for the method.
> Does the example tools/gatt-service works? Can anyone give me pointer
> to figure out the RegisterService issue above?

The API has changed to RegisterApplication, apparently I forgot to
update all the tools, I will fix it asap. Btw, do you have any logs
regarding the iOS problem?
