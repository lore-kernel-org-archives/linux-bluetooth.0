Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4B61DFAD.2090605@gmx.de>
References: <4B5C554D.4030702@gmx.de> <1264346020.11653.1.camel@violet>
	 <2d5a2c101001241309u6e292a12hfc5c67011d6b77ba@mail.gmail.com>
	 <4B5EA94B.1000204@gmx.de>
	 <2d5a2c101001260236v506b53dcl9d948722f7926329@mail.gmail.com>
	 <4B5F29E2.2010906@gmx.net>
	 <2d5a2c101001261401l5424c174qaaee6351c4435a03@mail.gmail.com>
	 <4B6091DD.8040409@gmx.de>
	 <2d5a2c101001271300yd5e9adcr606e969a81874d68@mail.gmail.com>
	 <4B61DFAD.2090605@gmx.de>
Date: Thu, 28 Jan 2010 22:01:48 +0200
Message-ID: <2d5a2c101001281201i75851257w985c689942513127@mail.gmail.com>
Subject: Re: [PATCH 1/1] add configurable support for bridge forward delay
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Thomas Egerer <hakke_007@gmx.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jan 28, 2010 at 9:04 PM, Thomas Egerer <hakke_007@gmx.de> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> Luiz
>
> Luiz Augusto von Dentz wrote:
>> Hi.
>>
>> On Wed, Jan 27, 2010 at 9:19 PM, Thomas Egerer <hakke_007@gmx.de> wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA512
>>>
>>> Luiz,
>>>
>>> Luiz Augusto von Dentz wrote:
>>>> Hi Thomas,
>>>>
>>>> On Tue, Jan 26, 2010 at 7:44 PM, Thomas Egerer
> <thomas.washeim@gmx.net> wrote:
>>>>> Luiz,
>>>>>
>>>>> I disagree. On page 31 the specification states that a NAP/GN performs
>>>>> the following (in regard to packet forwarding operations):
>>>>> 'Automatically learn and maintain the information required to make
>>>>> frame-filtering decisions as described in [3] section 7.1 and specified
>>>>> in [3] sections 7.8 and 7.9, for the support of Basic Filtering
> Services.'
>>>>> and even if it says in the next paragraph:
>>>>> 'The NAP/GN is not required to perform any of the following aspects of
>>>>> the 802.1D standard.'
>>>>> footnote 4 mentions:
>>>>> 'Sophisticated Bluetooth NAP devices may choose to implement some
> or all
>>>>> of the 802.1D features.'
>>>>> In my eyes this supports my point of view since the forward delay as
>>>>> part of the learning process should be a subject of configuration.
>>>>> Could I convince you?
>>>> You almost convince me, but after some googling it seems
>>> :D
>>>>
> http://www.linuxfoundation.org/collaborate/workgroups/networking/bridge#Spanning_Tree_Protocol
>>>> contradicts what you are saying:
>>>>
>>>> "The Spanning Tree Protocol has no authentication; all participants
>>>> are assumed to be trustworthy and correct. This assumption is not true
>>>> if bridging between a hostile environment like the Internet and a
>>>> private network. For this reason, STP is turned off by default on the
>>>> recent versions of Linux."
>>>>
>>>> And even the spec itself seem to support my argument:
>>>>
>>>> "2004 — Revised version (802.1D-2004), incorporating the extensions
>>>> 802.11c, 802.1t and 802.1w, which were separately published in 2001,
>>>> and removing the original Spanning tree protocol, instead
>>>> incorporating the Rapid Spanning Tree Protocol (RSTP) from 802.1w."
>>>>
>>>> Naturally someone else also notice that this arbitrary delay during
>>>> the learning phase is a bad idea after all and invented the RSTP and I
>>>> guess PAN spec was released after 2004 so that would explain why we
>>>> don't see anything about how to handle forwarding delay.
>>> That's at least an explanation why one cannot find how to configure the
>>> forward delay for the bridge.
>>> This is where the use case comes into play. You allow the user to
>>> configure the bridge to use (which by the way is only created for GN and
>>> not for NAP, is that correct?). If you do so one might (for various
>>> reasons) want to choose an existing bridge (which results in a simple
>>> error message without giving the actual reason). But if the user picks a
>>> bridge that already exists and you use a fix, not configurable delay one
>>> has to reset the delay -- if necessary -- to something -ne 0 after
>>> bluetoothd was started.
>>> If one doesn't specify the value it's set to the default, zero seconds,
>>> no harm done, if one does specify the value this one is used. I can't
>>> see where the problem is.
> First of all, I'm feeling a bit like an idiot here. The only thing I
> tried to do was improving bluez. And I'd give a rats ass about it if I
> didn't use it every day. So I have personal interest to make the
> software as good and usable as possible for me as well as other people.

Don't fell bad about this, discussions as we are having now are quite
normal in open source, actually I would say it is part of the
development process. So again, don't feel bad.

>>
>> You probably didn't read this documentation:
>>
>>
> http://www.linuxfoundation.org/collaborate/workgroups/networking/bridge_stp
> I indeed read that documentation.
>
>> "STP is turned off by default on the recent versions of Linux"
> And I sure know that. I'm using bridges quite often and 'brctl show'
> lists a field called 'STP enabled' which is set to off unless you change
> it manually.
>
>> afaik it will be pretty hard to convince Marcel about adding something
>> that is not enabled by default anymore
> This must be a misunderstanding. I'm don't want to enable STP by default
> or whatever. My intention is (see me 'foreword' from above) to make the
> bluetoothd as user-friendly as even possible. And this includes for me
> to check for an existing bridge (this means honoring the EEXIST return
> code in bridge_create) first off. Then secondly leaving the bridge's
> settings untouched or setting it to the user-defined values from
> network.conf.

My argument is basically against Delay Forward as part of
network.conf, period. Honoring bridge_create return and leave the
bridge setting untouched are good ideas, as for the user defined
values that is not BlueZ business, actually I would expect that coming
for network specific daemons such as NetworkManager and connman
options for tethering.

>> And again STP is _obsolete_ according to 802.1D-2004 (we are in 2010),
>> I don't know why you are spending time trying to use STP in the first
>> place, If I were you I would spend my time implementing RSTP or MSTP
>> that would be great not only for bluetooth but also for networking in
>> general.
> Again, I don't want to enable STP by default, I want people to be able
> to use bluetooth in a fashion they want (which includes honoring that an
> existing bridge keeps using its existing settings/set user defined
> values for a newly created bridge).
> I know RSTP would be great, but it's not in the kernel. Support would be
> available via user-space lib, but all the project to find in this
> direction seem to be dead.
> So as a compromise, do you think it would be possible to 'convince'
> Marcel to leave a bridge's settings untouched as long as it exists and
> use the (reasonable) default values like a forward delay of zero seconds
> for newly created bridges?

After this discussion I should say we should not mess with forward
delay at all, if BlueZ is to create a bridge itself than it should not
bother enabling STP, but if a bridge configured is already using it
than we simple don't touch it.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
