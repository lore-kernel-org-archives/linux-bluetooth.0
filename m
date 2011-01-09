Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201101061946.04790.arnd@arndb.de>
References: <1292584829-28279-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
	<AANLkTikxnWZNwf7AO0XnD0Y59Sdk9DMCsGtmap=H_gNk@mail.gmail.com>
	<AFCDDB4A3EA003429EEF1E7B211FDBBA3348BA7DD2@EXDCVYMBSTM005.EQ1STM.local>
	<201101061946.04790.arnd@arndb.de>
Date: Sun, 9 Jan 2011 23:42:31 +0530
Message-ID: <AANLkTikJMx2QxYwXS_TrKK5hcnD3G0MNvEiDO+xAZrpo@mail.gmail.com>
Subject: Re: [PATCH 00/11] mfd and bluetooth: Add CG2900 support
From: Pavan Savoy <pavan_savoy@sify.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>,
	Vitaly Wool <vitalywool@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Samuel Ortiz <sameo@linux.intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>, Par-Gunnar Hjalmdahl <pghatwork@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jan 7, 2011 at 12:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 05 January 2011, Par-Gunnar HJALMDAHL wrote:
>
>> Sorry for not answering sooner. I've been on Christmas and New Year vaca=
tion.
>
> I'm also still catching up with email that has accumulated over my
> vacation, including your previous response.
>
> This sounds wrong for both TI and ST-E: AFAICT they are actually built
> around an HCI interface. It's unfortunate that the TI code actually got
> merged into the kernel like this.

I am not sure what does built around HCI Interface mean? Also yes, in TI- c=
ode
we do refer to Bluetooth headers.
However the fact that I wanted to point out to Par-Gunnar was, that we
don't want to use
hciattach and enable HCI-UART + HCI-H4 for enabling our driver or our
driver should not
depend on those modules as such...

The references to bluetooth headers in a certain way is inevitable
because as he pointed
out, firmware is downloaded as HCI-VS commands, too bad the firmware
doesn't have any other
means :(, But it sorts of allows violations, as in we can afford to
have HCI-VS commands sent after
disabling events, which would mean they need not be interpreted at all..

>> > instead of common-hci-module, why not create a algo-driver layer 'ala
>> > i2c ? where individual drivers can register their receive handlers for
>> > data interpretation ?
>
> That would be what I suggested ;-)

But even here too, the algos layer if you imagine which can be the
sort of the first
receiver of data from the transport would refer to BT headers to
interpret the data (not just BT, but FM/GPS)
and pass it onto other protocol/client drivers,
The only abstraction being that different adapter drivers can register
their own receive function
which the algo-driver can sort of call, (again all imagination....)


>> In some way you then run into the same problem has I had in previous pat=
ch
>> sets. The functionalities supported is really determined by each chip.
>> You might or might not have for example GPS in a certain chip. So you do=
 not
>> want a central module to expose all possible channels to the stacks on t=
op.
>>
>> You only want the actually supported features to be exposed to upper lay=
ers.
>> Then the MFD system is pretty nice. It's easy and modularized to expose =
the
>> different channels as MFD cells.
>
> But as soon as you have the concept of channels with a clearly defined
> interface, you have almost abstracted it enough to go all the way.

Something like this is what the recent RFC posted to
lkml/linux-bluetooth
http://www.spinics.net/lists/linux-bluetooth/msg09990.html,
it kinda looks clumsy
but what I feel is we shouldn't shy away from not referencing
Bluetooth, (or may be tomorrow GPS
with NMEA headers)....


>> Also note that the common-hci-module is only really used until the conne=
cted
>> chip has been detected. The chip handler will then set the callback func=
tions
>> so actual data transmissions never pass the common-hci-module. They go d=
irectly
>> from transport to chip handler. That is not really shown in the picture =
above.
>> Just imagine that common-hci-module is removed after a chip has been con=
nected
>> and a chip handler has been determined.
>>
>> I hope I haven't misunderstood your question. I do not know much about t=
he I2C
>> system, but I tried to understand your question as best as I could.
>
> I think there is a disconnect when talking about hierarchies, as it can b=
e applied
> to different areas:
>
> * module dependencies
> * device detection
> * sysfs object hierarchy
> * data flow

module dependecy-wise I agree,
I would want FM-V4L2 without BT or I might want GPS simplistic char
driver without BT or FM V4L2.

device detection wise, It is a problem, there is not "_probe"
mechanism for UART based transport as it is
understandable, and pretty much the driver would end up being platform
device driver ...

data flow is where I guess the abstraction has to lie in, for
different vendors...

> These are often the same or at least related, but we may be talking about=
 different
> aspects here. One issue that is often confusing is that from a module lay=
ering,
> you typically have a common module at the bottom and have both providers =
(e.g. hosts
> controller) and consumers of data (e.g. protocol drivers) on the top, whe=
re in a
> data flow chart, you typically have the provider below the common code an=
d the
> consumer above if (or the other way round, if you prefer).
>
> Since the HCI code in this case is the common component, it really needs =
to be the
> module that everything else registers with in some way. You can have mult=
iple
> modules providing HCIs to that, and I suppose a module that provides an H=
CI should
> also be the one that identifies the channels that are present.
>
> The consumers of those channels however should not interface with the mod=
ule that
> provides the channels, but use the HCI code or something on top of it as =
an
> abstraction.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Arnd

Thanks for the comments...
>
