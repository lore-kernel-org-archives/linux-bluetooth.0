Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ58=w_A6KULNO9n8VWCmnbyPOj2w1OAJbQRhWX5BexVA@mail.gmail.com>
References: <1437319871-3004-1-git-send-email-dh79.pyun@samsung.com>
	<CABBYNZJ58=w_A6KULNO9n8VWCmnbyPOj2w1OAJbQRhWX5BexVA@mail.gmail.com>
Date: Thu, 23 Jul 2015 22:58:09 +0900
Message-ID: <CAFUUc2Ft2C=A9Ba2XeXHv0OxHfFYGbT5Y7vcSt=khjoqh4cNPg@mail.gmail.com>
Subject: Re: [PATCH BLUEZ 0/4] Modify Health profile signals for ObjectManager
From: DoHyun Pyun <re20sfree@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

2015-07-22 21:50 GMT+09:00, Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> Hi Dohyun,
>
> On Sun, Jul 19, 2015 at 6:31 PM, Dohyun Pyun <re20sfree@gmail.com> wrote:
>> From: DoHyun Pyun <dh79.pyun@samsung.com>
>>
>> Since BlueZ has ObjectManager interface, ChannelConnected and
>> ChannelDeleted
>> Signals of HealthDevice interface was not available. ObjectManager reports
>> the
>> HealthChannel D-Bus interface when g_dbus_emit_signal function is called,
>> and generates "InterfaceAdded" signal. But ChannelConnected and
>> ChannelDeleted
>> Siganls was not generated. If health-api document contains these signals,
>> application or service using Bluez Dbus API will get the unexpected
>> result.
>>
>> If we just remove g_dbus_emit_signal for ChannelConnected and
>> ChannelDeleted,
>> InterfaceAdded signal will not sent. Because InterfaceAdded signal is
>> pending
>> before sending a dbus signal. These patches include new property in
>> HealthChannel
>> interfacem, and this PropertiesChanged signal can be used to replace the
>> previous
>> ChannelConnected and ChannelDeleted signals.
>
> Seems like a good idea, but from the logs it looks like the channel
> lifetime is tied with the connection in that case
> InterfacesAdded/InterfacesRemoved can be used directly instead of
> having another property or Im missing something?
>

  When I re-test the possible senarios without "PropertiesChanged" Signal
  after removing the ChannelConnected and ChannelRemoved signals.
  It looks no problem. As you said, we can use InterfacesAdded /
  InterfacesRemoved event directly. After verifying the operations, I will
  re-make the patchsets - only include remove the previous signals
  (ChannelConnected/ ChannelRemoved)


Thanks,
Pyun
