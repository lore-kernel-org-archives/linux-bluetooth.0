Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"bgix@codeaurora.org" <bgix@codeaurora.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Date: Thu, 27 Oct 2011 17:48:48 +0200
Subject: RE: GATT Dbus API on BlueZ - attirbute-api.txt modifications
Message-ID: <7769C83744F2C34A841232EF77AEA20C01DCBC4234@dnce01.ent.ti.com>
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
In-Reply-To: <CAJdJm_NKmrx-qieUFMibPSL3L17=-nwKEjQrfvmf77HFsU8yaw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Anderson, 

> 
> Hi Chen,
> 
> On Thu, Oct 27, 2011 at 11:06 AM, Ganir, Chen <chen.ganir@ti.com>
> wrote:
> > Caching seems very wrong to me. A client expects the correct data
> from the server, and not something that is not correct. Why provide a
> cached value instead of notifying the client that the link is down ?
> What if the server changes the value, and the client keeps getting the
> wrong value ? I believe the client should be notified if the link is
> down and there is an error reading the correct value.
> 
> The value is not actually wrong, it is just old. But it is the best
> data available while connection is not re-established. But as I said
> before, there should be a way (e.g. specific D-Bus property) to the
> user know that the value is stale, but it is not an error to have
> "link down" temporarily.
> 
If the link is down, value should be empty, not cached. There is no reason showing a false value. Think of the thermometer example - you can not show false information, just to keep the user away from the disconnection error.
In addition - how will you control when the cached value is refreshed ? Will it be periodically? Upon use request ? Just wait for notification/indication?

> For some data, the cached value is not bad. For others (e.g.
> termomether measurements, timestamp information) it is. The API has to
> be generic and allow to provide the latest available data, but still
> allow user to know it is not "live" data.
> 
> Another point here is that we do not want to give to the D-Bus API use
> the ability to control connections directly. In this scenario, what it
> would do with a "link down" error?
> 
> If the BlueZ will try to reconnect on timeout anyway, why the user
> needs to know about this temporary error? Of course the connection may
> never be restored, in this case we can use a D-Bus "give up" signal to
> notify this to the user.
> 
The bluez should know and prevent such a case. If the link is down, and auto-connection is in progress, no reconnection attempt shall be made in addition to that - and the returned value should be "connection error".


> > Regarding the multiple client scenario - Since dbus is still not my
> expertise, I would be happy to get some ideas here - currently the
> function is blocking. It means that it will not return until the server
> replies or the link is down. I assume that the dbus daemon will queue
> multiple requests to allow bluetoothd to handle each one at it's turn ?
> If this is not the case, I would be happy if someone could elaborate on
> this and highlight the correct usage in multiple client scenario.
> 
> Blocking D-Bus is not good as far as I know (Luiz and others may give
> more details or ideas here, I'm newbie on d-bus as well).
> 
The other way to do it is to send the command (read, write, discover) and wait for the callback to send back a dbus event. It's possible, but makes the whole thing much more complicated, forcing the application to handle states. This also means registering some kind of agent for generic gatt client, or per service/character, to allow receiving the read/write/discover callbacks, to prevent from broadcasting such events on the bus for everyone. Do we really want to complicate things like that ?

Thanks,
Chen Ganir.
