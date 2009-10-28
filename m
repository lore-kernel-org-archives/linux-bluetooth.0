Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1256730946.6820.14.camel@german-desktop>
References: <1256730946.6820.14.camel@german-desktop>
Date: Wed, 28 Oct 2009 11:21:56 -0200
Message-ID: <f9d4bd30910280621u2f2102afq4d363b5722ff285@mail.gmail.com>
Subject: Re: bluetooth-agent
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: =?UTF-8?Q?Germ=C3=A1n_Pedrosa?= <german.pedrosa@fundacionctic.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 28, 2009 at 9:55 AM, Germán Pedrosa
<german.pedrosa@fundacionctic.org> wrote:
> Hi,
>
> I am newbie with bluez and I'm developing a research project where I
> need to use various Bluetooth USB-dongles.
>
> I need to deploy an automatic bluetooth pairing by command line (it is a
> project requirement), but the problem is that bluetooth-agent does only
> listen to hci0 device (I mean, if in any case I need to pair with any
> other dongle, bluetooth-agent does not reply).
>
> Is there any possibility where bluetooth-agent could respond to the
> other devices? The man page for bluetooth-agent is missing, and I have
> not found any way to get it.
>
> Thanks a lot and best regards.
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Hi German,

you can register the same bluetooth-agent to handle requests for all dongles.

See simple-agent code under test directory, there is an example how to
register agent.
Basically you need to call:
adapter0.RegisterAgent(path, "DisplayYesNo")
adapter1.RegisterAgent(path, "DisplayYesNo")
...

There isn't man pages for bluetooth-agent, see agent-api.txt under doc
directory.

Cheers,
krau
