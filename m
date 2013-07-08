Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANT-zCUJkBDoxJKX4c00d3MhQgLZMOVHRLWo01rfLtq8_7fF1A@mail.gmail.com>
References: <1373033022-11180-1-git-send-email-luiz.dentz@gmail.com>
	<CANT-zCUN8L_iVyPmXchmunoKwxt72KR7ZYhbQYtCBwUpxSWbJQ@mail.gmail.com>
	<CABBYNZ+Ab=rPfE5HaW1c3+n=wEF3=x2UQ2_+-JPwSvXgbTcYBg@mail.gmail.com>
	<CANT-zCUJkBDoxJKX4c00d3MhQgLZMOVHRLWo01rfLtq8_7fF1A@mail.gmail.com>
Date: Mon, 8 Jul 2013 17:52:05 +0300
Message-ID: <CABBYNZKOdWNkPwdcYcLX29xfV5KscwKWgdJZYeWEBE3mD-BLzA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] core/service: Make sure service is disconnected
 before shutdown
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Jul 8, 2013 at 5:13 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>>> Adding one more side effect to service_shutdown() is IMO undesirable,
>>> where the transitional DISCONNECTED state would be artificially
>>> introduced. Think about an external profile being unregistered while
>>> connected devices exist: not only calling
>>> Profile.RequestDisconnection() doesn't make any sense, but a
>>> transition such as STATE_CONNECTED->STATE_UNAVAILABLE is probably what
>>> you want to observe. This can be different from a graceful
>>> disconnection, and a policy module could use this distinction to
>>> reconnect the service once the external profile gets registered.
>>
>> While I agree that could be useful for tracking thinks like link loss
>> this would be initiated by the profile/service themselves somehow not
>> by device_remove code path that should never trigger any link loss
>> policy, it is a cleanup path btw so nothing should be pending after
>> that so your argument actually works against having this type of
>> transition from connected directly to unavailable.
>
> I was not referring to link-loss cases here but for example a crash in
> oFono, which would presumably restart immediately afterwards. A policy
> module could remember that the profile was disconnected due to a crash
> and reconnect automatically.

Well that can be considered a profile link loss, anyway what we are
discussing here is related to device_remove path and the effects of
having service_shutdown to do btd_service_disconnect, it seems that
when we do DeviceRemove we actually do disconnect before so that is
okay to no do it again on device_remove in the other hand if we are
quitting we perhaps don't really need to disconnect after all it could
be restarting for some reason like the device would reboot so it
doesn't necessarily need to disconnect to avoid reconnection strategy
to take place, so perhaps there is no real use of disconnecting after
all.

So I will do the following:

rename service_shutdown to service_remove which does btd_service_unref
internally similarly to what device_remove does so we keep similar
APIs for this matter, service_remove will not disconnect.

--
Luiz Augusto von Dentz
