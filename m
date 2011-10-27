Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"bgix@codeaurora.org" <bgix@codeaurora.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Date: Thu, 27 Oct 2011 17:06:53 +0200
Subject: RE: GATT Dbus API on BlueZ - attirbute-api.txt modifications
Message-ID: <7769C83744F2C34A841232EF77AEA20C01DCBC41E0@dnce01.ent.ti.com>
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
In-Reply-To: <CAJdJm_Po7iAOoB673XW6D3gTsCn_ME8CHEo0VcWzi5FKX9xghA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Anderson,Luiz, 
 
> 
> Regarding caching reads and writes, the way LE works from my POV is
> that most devices (except ones which rely on Proximity Link Loss) will
> have Link Supervision Timeout of a few seconds at least. I have
> already seen devices with 30 seconds LSTO.
> 
> For these high latency devices (which use conservative connection
> parameters for saving battery) some caching is good. But we should
> provide ways to let the D-Bus API user know whether the data has
> effectively been written, or updated locally. This can be done by
> means of D-Bus signals. Which point us back to the reason why we have
> Value as a property in the first place.
> 
> Also imagine that the API might allow a couple of D-Bus clients
> talking to the same device, but using different services. In case of
> temporary link loss (or high latency), the values should be kept by
> BlueZ, which will then write the value once connection is restored.
> Otherwise, you would see many D-Bus clients trying to read/write data
> while the link is not ok.
> 
Caching seems very wrong to me. A client expects the correct data from the server, and not something that is not correct. Why provide a cached value instead of notifying the client that the link is down ? What if the server changes the value, and the client keeps getting the wrong value ? I believe the client should be notified if the link is down and there is an error reading the correct value.

Regarding the multiple client scenario - Since dbus is still not my expertise, I would be happy to get some ideas here - currently the function is blocking. It means that it will not return until the server replies or the link is down. I assume that the dbus daemon will queue multiple requests to allow bluetoothd to handle each one at it's turn ? If this is not the case, I would be happy if someone could elaborate on this and highlight the correct usage in multiple client scenario.


> 
> Luiz, while I totally agree with the D-Bus error instead of return
> value (and you know about this stuff better than me :), how could we
> pass the "custom"  ATT error codes to the client? Any profile can
> define their own ATT error codes, and BlueZ cannot know all of them.
> 
This is why I wanted it to be integer. 


> >
> > Create an array of string WriteMethods which represents the methods
> > supported by the characteristic.
> 
> Agreed. They are readonly anyway. and makes it easier to extend.
> 
> I would just go with "SupportedWriteMethods" of something like that :)
> (but it is a detail).
> 
I also agree here. This property will be changed to writableMethods string array, with string>Boolean dictionary.

Thanks for your comments so far.

Chen Ganir.

