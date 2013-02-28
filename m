Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: Bluez 5.2 A2DP: "Unable to select SEP"
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHZ1yCnWf0mamOLk9n9q4CfbXqhGhxG7H2tXmxLus3-keFM51g@mail.gmail.com>
Date: Thu, 28 Feb 2013 12:49:29 -0800
Cc: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <CD0EF9D5-67A4-4D64-9F81-9E494E879B7B@holtmann.org>
References: <CAHZ1yC=FkUt=ESbZ+OnfSXKrN0+XHVgcMxqOjQq-EaJU+TPf-w@mail.gmail.com> <CACumGOK+rmNt8xb6Ee-vkWRMoCDR0q-LQ-rPNsRwteKOpadJTQ@mail.gmail.com> <CAHZ1yCnWf0mamOLk9n9q4CfbXqhGhxG7H2tXmxLus3-keFM51g@mail.gmail.com>
To: Scott James Remnant <keybuk@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,


>> On Thu, Feb 28, 2013 at 9:51 PM, Scott James Remnant <keybuk@google.com> wrote:
>>> I'm having some difficulties connecting up A2DP in BlueZ 5.2, and I'm
>>> sure I'm just missing something obvious so would appreciate a second
>>> set of eyes.
>>> 
>>> I had thought that to send to an A2DP Sink on a device, I needed an
>>> A2DP Source endpoint at my end, but when I try and register that
>>> endpoint I just get org.bluez.Error.NotSupported
>> 
>> Check your /etc/bluetooth/audio.conf, you must have disabled it for some reason.
>> 
> 
> There isn't an audio.conf shipped with BlueZ 5.2; checking
> profiles/audio/manager.c it has:
> 
> static struct enabled_interfaces enabled = {
>        .sink           = TRUE,
>        .source         = FALSE,
>        .control        = TRUE,
> };
> 
> This seems bizarre that registering audio sinks (which I read as
> sending A2DP from the device to the host) is enabled by default, but
> not the more usual registering of an audio source (to send to an A2DP
> sink on the device).

we want to move to a state where BlueZ works out-of-the-box with no extra config files needed. So I think we should just fix this and always have at least one sink and one source present.

Or if that causes issues, then at least have this depend on PA (or some other audio manager) making that call for us. The default behaviour needs to just work.

Regards

Marcel

