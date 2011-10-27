Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCBC41E0@dnce01.ent.ti.com>
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
Date: Thu, 27 Oct 2011 11:29:46 -0400
Message-ID: <CAJdJm_NKmrx-qieUFMibPSL3L17=-nwKEjQrfvmf77HFsU8yaw@mail.gmail.com>
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

On Thu, Oct 27, 2011 at 11:06 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> Caching seems very wrong to me. A client expects the correct data from the server, and not something that is not correct. Why provide a cached value instead of notifying the client that the link is down ? What if the server changes the value, and the client keeps getting the wrong value ? I believe the client should be notified if the link is down and there is an error reading the correct value.

The value is not actually wrong, it is just old. But it is the best
data available while connection is not re-established. But as I said
before, there should be a way (e.g. specific D-Bus property) to the
user know that the value is stale, but it is not an error to have
"link down" temporarily.

For some data, the cached value is not bad. For others (e.g.
termomether measurements, timestamp information) it is. The API has to
be generic and allow to provide the latest available data, but still
allow user to know it is not "live" data.

Another point here is that we do not want to give to the D-Bus API use
the ability to control connections directly. In this scenario, what it
would do with a "link down" error?

If the BlueZ will try to reconnect on timeout anyway, why the user
needs to know about this temporary error? Of course the connection may
never be restored, in this case we can use a D-Bus "give up" signal to
notify this to the user.

> Regarding the multiple client scenario - Since dbus is still not my expertise, I would be happy to get some ideas here - currently the function is blocking. It means that it will not return until the server replies or the link is down. I assume that the dbus daemon will queue multiple requests to allow bluetoothd to handle each one at it's turn ? If this is not the case, I would be happy if someone could elaborate on this and highlight the correct usage in multiple client scenario.

Blocking D-Bus is not good as far as I know (Luiz and others may give
more details or ideas here, I'm newbie on d-bus as well).

Try to model the API on a way which is compatible with:

* high latency (e.g. 30 seconds)
* timeouts are common, but handled automatically by BlueZ.
* Not try to poll, or flood D-Bus with requests which cannot be
satisfied in real time.

>> > Create an array of string WriteMethods which represents the methods
>> > supported by the characteristic.
>>
>> Agreed. They are readonly anyway. and makes it easier to extend.
>>
>> I would just go with "SupportedWriteMethods" of something like that :)
>> (but it is a detail).
>>
> I also agree here. This property will be changed to writableMethods string array, with string>Boolean dictionary.

A dict is not needed here IMHO. If the string is on the array, it is
"true". If it is not, it is "false". I think this is how Luiz imagined
(right?).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
