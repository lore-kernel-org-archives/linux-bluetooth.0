Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110316204004.GA2339@joana>
References: <AANLkTimP_XBFy58dMDZa69RQ9UKeZmh++jeuH073doLr@mail.gmail.com>
	<20110316204004.GA2339@joana>
Date: Wed, 16 Mar 2011 22:20:58 +0000
Message-ID: <AANLkTin-Tc4s76OuJ26ktQXT7n5f7yMZbYWpMiv-Dfc4@mail.gmail.com>
Subject: Re: [RFC] Auto Connections
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Ville Tervo <Ville.Tervo@nokia.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo/Jaikumar

On Wed, Mar 16, 2011 at 8:40 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Claudio,
>
> * Claudio Takahasi <claudio.takahasi@openbossa.org> [2011-03-11 21:30:09 +0000]:
>
>> Hi guys,
>>
>> It is time to get opinions from some gurus!
>>
>> We need to implement automatic connections to implement the Profiles.
>> At the moment BlueZ supports only dual mode adapters, as consequence
>> BlueZ needs to start the LE connection. IMHO, it is better to leave
>> the responsibility to the controller, implementing "selective"
>> connections will only introduce more code without concrete benefits.
>> Configuring the controller to autonomously establish connections seems
>> to be the right approach to proceed.
>>
>> This topic is NOT about StartDiscovery() + CreateDevice.
>> StartDiscovery uses active scanning and CreateDevice uses direct
>> connection establishment. We need a mechanism to automatically connect
>> to "trusted" devices or devices flagged as "AutoConnect".
>>
>>
>> My initial idea is: change the LE server socket to report
>> outgoing(host initiated) connections through the server socket.
>> Awkward?
>> To achieve that we need to manage the LE Create Connection(using
>> whitelist) in the kernel, extend the management interface to control
>> devices in the whitelist, change the LE Connection Complete Event
>> handling to get the Role properly.
>> Pros:
>> - Controller manage connections
>> - Flexible to support  connections to "trusted" resolvable address and
>> passive scanning
>> - Only one "flow" for the connections: LE server socket
>> - Maybe we could hide resolvable address from the userspace, mapping
>> it directly to public or static random
>
> This approach have a lot of advantages. It seems the best option to me.
>
>> Cons:
>> - Risky
>
> Define risky here.
More code in the kernel, more time to get the code upstream,
additional verification to avoid insufficient resources when scanning
and connecting, but to me it seems the best approach.

to Jaikumar:
The profiles will indirectly manage the connections providing
informations such as connection parameters(interval, window, ...) and
addresses, but the kernel needs to centralize/manage the connections.
We can't allow the profiles to control the connection directly, a
remote can implement more than one profile, maybe with different
constraints. The host can also provide inputs, for instance power
saving profile or maximum number of LE connections.

>
>> - Less control of the connection establishment process
>
> But do we need this control?
Yes, we need. It is not allowed to send more than one LE Create
Connection command to the controller or try to establish a connection
while scanning.
Some controller also doesn't support some state combination, see "LE
read supported states"

Claudio

>
> --
> Gustavo F. Padovan
> http://profusion.mobi
>
