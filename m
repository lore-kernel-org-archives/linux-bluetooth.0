Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCBC4234@dnce01.ent.ti.com>
References: <1319497579-8859-1-git-send-email-pkrystad@codeaurora.org>
	<4EA6143E.4000606@googlemail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA8D28@dnce01.ent.ti.com>
	<CAKT1EBeJB2FDrv6Xp_bGV3eFDEe5ecvnBN0rKniYxw5++Q9NfA@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA8F85@dnce01.ent.ti.com>
	<CAKT1EBcd6dQq3bzOsW3Fuwv=d8J=yDvsJjbp_ELEAQUjfyRx9g@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA9265@dnce01.ent.ti.com>
	<alpine.DEB.2.02.1110270003090.30044@mathewm-linux>
	<7769C83744F2C34A841232EF77AEA20C01DCBC3F03@dnce01.ent.ti.com>
	<CABBYNZ+Hq4-AAg3TsLi-Vh0eC2p_ZtD2vthBfc3Unww+Km6-Mg@mail.gmail.com>
	<CAJdJm_Po7iAOoB673XW6D3gTsCn_ME8CHEo0VcWzi5FKX9xghA@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCBC41E0@dnce01.ent.ti.com>
	<CAJdJm_NKmrx-qieUFMibPSL3L17=-nwKEjQrfvmf77HFsU8yaw@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCBC4234@dnce01.ent.ti.com>
Date: Thu, 27 Oct 2011 12:29:09 -0400
Message-ID: <CAJdJm_M5LS6o4yiiG-7-KedUF6_dafYbLX=Vqj0QJ4rV926gpg@mail.gmail.com>
Subject: Re: GATT Dbus API on BlueZ - attirbute-api.txt modifications
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"bgix@codeaurora.org" <bgix@codeaurora.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Thu, Oct 27, 2011 at 11:48 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> Anderson,
>
>>
>> Hi Chen,
>>
>> On Thu, Oct 27, 2011 at 11:06 AM, Ganir, Chen <chen.ganir@ti.com>
>> wrote:
>> > Caching seems very wrong to me. A client expects the correct data
>> from the server, and not something that is not correct. Why provide a
>> cached value instead of notifying the client that the link is down ?
>> What if the server changes the value, and the client keeps getting the
>> wrong value ? I believe the client should be notified if the link is
>> down and there is an error reading the correct value.
>>
>> The value is not actually wrong, it is just old. But it is the best
>> data available while connection is not re-established. But as I said
>> before, there should be a way (e.g. specific D-Bus property) to the
>> user know that the value is stale, but it is not an error to have
>> "link down" temporarily.
>>
> If the link is down, value should be empty, not cached. There is no reason showing a false value. Think of the thermometer example - you can not show false information, just to keep the user away from the disconnection error.
> In addition - how will you control when the cached value is refreshed ? Will it be periodically? Upon use request ? Just wait for notification/indication?

If the user tried to read the Value property, it will return
immediately with "cached" value if not connected (which is an actual,
not invented value read before by this or some other application),
then attempt connection. After connection is done, the read request is
done, the value is updated, and a PropertyChanged signal is sent.

That is why we use Value as a property and not a method like you are
suggesting. Clients should be monitoring the PropertyChanged signals
all the time.

>> For some data, the cached value is not bad. For others (e.g.
>> termomether measurements, timestamp information) it is. The API has to
>> be generic and allow to provide the latest available data, but still
>> allow user to know it is not "live" data.
>>
>> Another point here is that we do not want to give to the D-Bus API use
>> the ability to control connections directly. In this scenario, what it
>> would do with a "link down" error?
>>
>> If the BlueZ will try to reconnect on timeout anyway, why the user
>> needs to know about this temporary error? Of course the connection may
>> never be restored, in this case we can use a D-Bus "give up" signal to
>> notify this to the user.
>>
> The bluez should know and prevent such a case. If the link is down, and auto-connection is in progress, no reconnection attempt shall be made in addition to that - and the returned value should be "connection error".

We already do that. The point (which I already mentioned before) is
that sending errors to the users, which are temporary (so it is under
debate if they are actually errors), and even if they get these
errors, they can't do nothing about it, because they can't control the
connection by themselves.

I suppose the end-user is not interested on seeing "Connection error"
or "connection in progress" dialog messages :)

>> Blocking D-Bus is not good as far as I know (Luiz and others may give
>> more details or ideas here, I'm newbie on d-bus as well).
>>
> The other way to do it is to send the command (read, write, discover) and wait for the callback to send back a dbus event. It's possible, but makes the whole thing much more complicated, forcing the application to handle states. This also means registering some kind of agent for generic gatt client, or per service/character, to allow receiving the read/write/discover callbacks, to prevent from broadcasting such events on the bus for everyone. Do we really want to complicate things like that ?

And another way is like it is currently :) a Value property for
read/writing,  and PropertyChanged signal for when the new value is
read/written. I fail to see a difference between what you suggest
above. BlueZ has this "Property" concept for quite some time.

The only limitation is that we can't control which operation is used
for write (write without response vs. write request). But... what if
we detect that by the characteristic properties (like we discussed for
notification/indication in another message). Again, if both are
supported, Write Request takes priority because it is more "reliable".

If by "discover" you mean service discovery, it is already done "for
free" during pairing. The core spec says that this information is
valid for the time of bonding, and if some service needs to be added,
the server shall implement Service Changed. (BTW we don't support
Service Changed yet, neither as client nor server).

>
> Thanks,
> Chen Ganir.
>

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
