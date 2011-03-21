Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinVZEW7WrkTRP-cjxrgk8xy=QLgNE2WX0BF+aoC@mail.gmail.com>
References: <AANLkTimP_XBFy58dMDZa69RQ9UKeZmh++jeuH073doLr@mail.gmail.com>
	<20110316204004.GA2339@joana>
	<AANLkTin-Tc4s76OuJ26ktQXT7n5f7yMZbYWpMiv-Dfc4@mail.gmail.com>
	<AANLkTinVZEW7WrkTRP-cjxrgk8xy=QLgNE2WX0BF+aoC@mail.gmail.com>
Date: Mon, 21 Mar 2011 13:26:09 +0000
Message-ID: <AANLkTim-nh=eLVWUtbvCg-Rt9kaumEju_msNsAY=LBmT@mail.gmail.com>
Subject: Re: [RFC] Auto Connections
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: "Arun K. Singh" <arunkat@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Ville Tervo <Ville.Tervo@nokia.com>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arun,

On Mon, Mar 21, 2011 at 10:55 AM, Arun K. Singh <arunkat@gmail.com> wrote:
> Hi Claudio,
>
>
>>
>> >> It is time to get opinions from some gurus!
>> >>
>> >> We need to implement automatic connections to implement the Profiles.
>> >> At the moment BlueZ supports only dual mode adapters, as consequence
>> >> BlueZ needs to start the LE connection. IMHO, it is better to leave
>> >> the responsibility to the controller, implementing "selective"
>> >> connections will only introduce more code without concrete benefits.
>> >> Configuring the controller to autonomously establish connections seems
>> >> to be the right approach to proceed.
>> >>
>> >> This topic is NOT about StartDiscovery() + CreateDevice.
>> >> StartDiscovery uses active scanning and CreateDevice uses direct
>> >> connection establishment. We need a mechanism to automatically connect
>> >> to "trusted" devices or devices flagged as "AutoConnect".
>> >>
>> >>
>> >> My initial idea is: change the LE server socket to report
>> >> outgoing(host initiated) connections through the server socket.
>> >> Awkward?
>> >> To achieve that we need to manage the LE Create Connection(using
>> >> whitelist) in the kernel, extend the management interface to control
>> >> devices in the whitelist, change the LE Connection Complete Event
>> >> handling to get the Role properly.
>> >> Pros:
>> >> - Controller manage connections
>> >> - Flexible to support  connections to "trusted" resolvable address and
>> >> passive scanning
>> >> - Only one "flow" for the connections: LE server socket
>> >> - Maybe we could hide resolvable address from the userspace, mapping
>> >> it directly to public or static random
>> >
>> > This approach have a lot of advantages. It seems the best option to me.
>> >
>> >> Cons:
>> >> - Risky
>> >
>> > Define risky here.
>> More code in the kernel, more time to get the code upstream,
>> additional verification to avoid insufficient resources when scanning
>> and connecting, but to me it seems the best approach.
>>
>> to Jaikumar:
>> The profiles will indirectly manage the connections providing
>> informations such as connection parameters(interval, window, ...) and
>> addresses, but the kernel needs to centralize/manage the connections.
>
>
> As per section 9.3.8, a host can still perform direct connection
> establishment procedure
> by telling controller to "ignore the White List and process connectable
> advertising
> packets from a specific single device specified by the Host". Wouldn't this
> be same
> as letting the host[read profiles] directly manage connections?

There are four Connection Establishment Procedures: Auto, General,
Selective and Direct.
CreateDevice/CreatePairedDevice will use Direct. But after pairing or
create device("known" devices) we need a more transparent procedure. I
am not saying that we will implement straitly Auto procedure, we will
also need to handle the resolvable address, a hybrid approach seems to
be more appropriated.

 We could use Direct procedure, managing(serializing) the connection
establishment implementing logic in the kernel or userspace for the
"known" devices. However, I prefer to transfer the responsibility to
the controller. If I choose connections using whitelist, how the STE
controller prioritizes the advertises? Does directed advertises have a
higher priority?

>
>
>> We can't allow the profiles to control the connection directly, a
>> remote can implement more than one profile, maybe with different
>> constraints.
>
> under direct connection establishment procedure, it should be possible for a
> host
> to establish connection with a remote peer device with host selected
> connection
> configurable parameters. Why should we deprive a bluez host of establishing
> such a connection...
> Or did I miss something here?

At API level, what is the benefit of exposing this option to the API users?

Some profiles define the recommended connection parameters, there is
also the Slave Connection Interval Range AD type that may be used to
in the  connection establishment.

BR,
Claudio

>
>
>
> Thanks,
> Arun
>
>
