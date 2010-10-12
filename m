Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101012093531.GA22165@jh-x301>
References: <AANLkTi=Ogzb3kUX7O4fz-w9gNpU9PCyTFo0GnhfePjC6@mail.gmail.com>
 <20101011213154.GA12131@jh-x301> <AANLkTik8k84qwMM3nHc4z2gVWm6Vo0HaLME2PEcwMyeg@mail.gmail.com>
 <20101012093531.GA22165@jh-x301>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Tue, 12 Oct 2010 11:57:00 +0200
Message-ID: <AANLkTikfAtEJrqrMr3HvZo+Wgv-CzWgkAAT4MB6TxmCf@mail.gmail.com>
Subject: Re: Pull request git://gitorious.org/bluez-mcap-hdp/mcap-hdp.git for_upstream
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2010/10/12 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Jose,
>
> On Tue, Oct 12, 2010, Jose Antonio Santos Cadenas wrote:
>> I'm sorry but I can't connect to the IRC rigth now. Nevertheless, I
>> think that I've found the issues:
>>
>> - The iochannel should be unrefereed when the watcher is explicitly removed
>
> Yes, though do you need to have a reference at all? As long as you have
> the GLib watch callback GLib itself holds a reference, so if you don't
> need one just remove chan->echo_chan and do an unref after calling
> add_watch.
>
>> - The commit message s/paramter/parameter
>>
>> Are there any more?
>
> s/Imcoming/Incoming/

Solved this one

> s/DBus/D-Bus/
>
> And the following doesn't make much sense to me:
>
> "Delete all channels DBus interface when the instance is removed"
>
> Could you rephrase it somehow, maybe by putting most of it in the
> message body instead of the summary line. Is it trying to say "Delete
> the D-Bus interfaces of all channels"? The summary line shouldn't be too
> complex. You can just say "Fix D-Bus channel removal when removing
> instances" and then in the message body do the more detailed
> explanation.

I've changed the commit message and added an explanation. I hope now is clearer.

>
> Johan
>

Regards.

Jose.
