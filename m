Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100507120859.GD12461@vigoh>
References: <201005071302.36198.jcaden@libresoft.es> <20100507120859.GD12461@vigoh>
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date: Fri, 7 May 2010 15:25:17 -0300
Message-ID: <k2taa32413d1005071125ob7ce6505q8bb2cc57a77f1c8f@mail.gmail.com>
Subject: Re: Data transmission and reconnections in HDP
To: =?UTF-8?Q?Jos=C3=A9_Antonio_Santos_Cadenas?= <jcaden@libresoft.es>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Jose!

On Fri, May 7, 2010 at 09:08, Gustavo F. Padovan <gustavo@padovan.org> wrote:
> Hi José,
>
> * José Antonio Santos Cadenas <jcaden@libresoft.es> [2010-05-07 13:02:36 +0200]:
>
>> Hi all,
>>
>> I start this thread to discuss the alternatives to move the data from the
>> application to the l2cap socket in HDP. Till now we have the following
>> alternatives (please, add more if we missed something)
>>
>> Reconnections options:
>>
>>  Option 1: Implicit reconnections: The application is not concern about the
>> disconnections or reconnections of the data channel until it is deleted.
>>
>>       We prefer this option because fixes more with a manager philosophy. A
>> 20601 manager sould not perceive temporal disconnections because this way can
>> hold it state if it perceives a disconnection, next time it reconnects it will
>> need to exchange again apdus for association.
>>
>>  Option 2: Reconnections by the application. The applications are notified when
>> a data channel is disconnected and should perform a reconnection before using
>> it again.
>>

The HDP Implementation Guidance Whitepaper clearly states that
transport (HDP) disconnection / reconnection should be transparent for
the data layer (IEEE 11073-20601), so I guess option 2 here would
break the spec.

>> Data transmission options:
>>
>>  Option 1: Fd_passing the l2cap socket of the data channel to the client. The
>> problem with this is that some data can be lost by d-bus if the channel is
>> disconnected. (We have to check how fd-passing works).
>
> DBus just pass the fd and then don't touch the fd anymore, data can't be
> lost by DBus.
>

I guess the problem Jose tried to address here is the case that HDP
had temporarily disconnected the data channel and then the application
try to write to the FD (which will be closed). Some data may be lost
by the application on this process.

>>
>>  Option 2: Fd_passing a pipe and HDP will write the data in the l2cap data
>> chanel socket. The problem with this is that we need 2 pipes for each data
>> channel, but no data will be lost because HDP controls the data flow with the
>> sockets and resend data not correctly sent.
>>
>>       We think that the easier way for implicit reconnections is option 2.
>> Because the application can always write on the socket it have (the pipe).
>> Once written, the HDP layer tries to write it in the l2cap socket, if it
>> fails, perform a reconnection operation over the data channel.
>>

Considering the drawbacks of the other alternatives and taking into
account that implicit reconnection is the right approach, this seems
the better option. I can't see any problems on having 2 pipes per data
channel, but I personally have never worked with splice directly so I
can't address much issues of this approach.

>>  Option 3: Transmiting the data by d-bus. We think that this option is bad for
>> d-bus, because of the overload of the system bus.
>
> Pretty bad ;)
>

As Gustavo said, transmitting data over d-bus would be very bad. On
some embedded platforms d-bus can be really slow and even for the
desktop case this is unnecessary overhead.

>>
>>  Option 4: Other IPC alternatives (more alternative here?)
>>

-- 
João Paulo Rechi Vita
http://jprvita.wordpress.com/
