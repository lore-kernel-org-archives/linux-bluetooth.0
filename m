Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AFCDDB4A3EA003429EEF1E7B211FDBBA334C4DE29C@EXDCVYMBSTM005.EQ1STM.local>
References: <AANLkTimP_XBFy58dMDZa69RQ9UKeZmh++jeuH073doLr@mail.gmail.com>
	<20110316204004.GA2339@joana>
	<AANLkTin-Tc4s76OuJ26ktQXT7n5f7yMZbYWpMiv-Dfc4@mail.gmail.com>
	<AANLkTinVZEW7WrkTRP-cjxrgk8xy=QLgNE2WX0BF+aoC@mail.gmail.com>
	<AANLkTim-nh=eLVWUtbvCg-Rt9kaumEju_msNsAY=LBmT@mail.gmail.com>
	<AFCDDB4A3EA003429EEF1E7B211FDBBA334C4DE29C@EXDCVYMBSTM005.EQ1STM.local>
Date: Wed, 23 Mar 2011 19:11:14 +0000
Message-ID: <AANLkTimfLFAK7q+W0Tsj=aZ2=gSumfRCOtCeAwOVC1vq@mail.gmail.com>
Subject: Re: [RFC] Auto Connections
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Arun Kumar SINGH <arunkr.singh@stericsson.com>
Cc: "Arun K. Singh" <arunkat@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Ville Tervo <Ville.Tervo@nokia.com>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	Andre Guedes <andre.guedes@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arun,

On Wed, Mar 23, 2011 at 7:37 AM, Arun Kumar SINGH
<arunkr.singh@stericsson.com> wrote:
> Hi Claudio,
>
>
>>There are four Connection
>>Establishment Procedures:
>>Auto, General,
>>Selective and Direct.
>>CreateDevice/CreatePairedDev
>>ice will use Direct. But
>>after pairing or
>>create device("known"
>>devices) we need a more
>>transparent procedure. I
>>am not saying that we will
>>implement straitly Auto
>>procedure, we will
>>also need to handle the
>>resolvable address, a hybrid
>>approach seems to
>>be more appropriated.
>>
>> We could use Direct
>>procedure,
>>managing(serializing) the
>>connection
>>establishment implementing
>>logic in the kernel or
>>userspace for the
>>"known" devices. However, I
>>prefer to transfer the
>>responsibility to
>>the controller. If I choose
>>connections using whitelist,
>>how the STE
>>controller prioritizes the
>>advertises? Does directed
>>advertises have a
>>higher priority?
>>
>
> Agreed but not sure whether we have a choice to use both a)auto connection via white-lists and b)direct connection ignoring white-lists - at the same time?
> In my opinion for doing either a) or b) you need to set the intitiator filter plicy to either use white-list or ignore it for direct connection. So, if you eventually implement auto-connection, you may not be able to do direct connect at all unless of course if you change the filter policy everytime. STE controller behaves the same way as per controller spec requirements letting the host decide on the filter policy and act suitably.

Not at the same time, controllers don't allow a second LE Create
Connection command if there is a pending command.
My question about your controller was how it decides in the case that
it receives connectable advertises from more than one remote. Does it
use RSSI(included in the advertise) and/or direct advertises has
higher priority?

>
> Coming back to the connection policy debate, we can as well have this as configurable option in bluetoothd to give a choice whether to use auto connection or direct connect policy by default?
>
> Also all the seven steps you need[9.3.5] for auto connection could either be done from user-space itself. And doing same from user-space would make more sense once the connection policy is configurable in bluetoothd?
>
> Please excuse if these sound too wild ...
Your comments are being very useful! No worries.

We have been discussing internally how to implement the connection
management and new facts came up:
1. If we wanna support GATT over BR/EDR, manage automatically
connections in the kernel will be hard to keep a similar approach for
LE and basic rate.
2. Change the server socket to "notify" local host initiated
connections is also breaking the socket API and requires some nasty
code changes in the kernel.
3. There are a lot of LE kernel patches pending(SM, cache and MTU)

After that we decided to start our first shot managing the connection
is the usespace(as you suggested). Hide the resolvable address is
still possible to be implemented in the kernel if we manage the
advertise kernel cache and passive scanning properly in the kernel.


>
>
>>At API level, what is the
>>benefit of exposing this
>>option to the API users?
>>
>>Some profiles define the
>>recommended connection
>>parameters, there is
>>also the Slave Connection
>>Interval Range AD type that
>>may be used to
>>in the  connection
>>establishment.
>>
>
>
> I don’t have a strong reason to give this option as an API to profiles but considering that a profile may have more flexibiltiy to set the connection parameters etc while initiating a new connection etc. As if this is done by Auto- Connection policy, you may have to set same connection parameters for all devices --something which be undesirable from profile point of view ...
>

At the moment the values are hardcoded in the kernel. Ville sent last
year a proposal to allow changing the connection parameters. We didn't
decide yet we we will use management interface or extend the socket to
pass the connection parameters.

BR,
Claudio.

>
> Thanks,
> Arun
>
