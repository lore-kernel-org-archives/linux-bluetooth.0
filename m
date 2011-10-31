Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Ajay Pillai <Ajay.Pillai@csr.com>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"bgix@codeaurora.org" <bgix@codeaurora.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Date: Mon, 31 Oct 2011 07:57:37 +0100
Subject: RE: GATT Dbus API on BlueZ - attirbute-api.txt modifications
Message-ID: <7769C83744F2C34A841232EF77AEA20C01DCBC482A@dnce01.ent.ti.com>
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
	<CAJdJm_M5LS6o4yiiG-7-KedUF6_dafYbLX=Vqj0QJ4rV926gpg@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCBC4275@dnce01.ent.ti.com>
	<CAJdJm_Pjn=7DWPES9fdZJntSfi_h14WxWfORuoRa+tWwnk9Dfw@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCBC472E@dnce01.ent.ti.com>
	<CAJdJm_P2X+rMH1Apo7Z_TjwR4WCtdeQZL2Mq3f73xkgy1=UpJw@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCBC47E3@dnce01.ent.ti.com>
 <CAJdJm_MWFbfwZ6LGdUnJV6LzT4XRLFC17rsKXV4jMwSAOd5PSQ@mail.gmail.com>
 <8DCFA6B89B9E70418E47A2348D55495A4790BF0B@banasiexm01.ASIA.ROOT.PRI>
In-Reply-To: <8DCFA6B89B9E70418E47A2348D55495A4790BF0B@banasiexm01.ASIA.ROOT.PRI>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ajay,
 
> The problem I see with this approach is that the DBUS client does not
> get to know that the value that it got while doing a getProperty() is
> the value remembered by BlueZ and not the one directly read from the
> server at that time and hence potentially a stale value. I think it is
> important because some DBUS clients may just want to ignore any
> potentially stale value and not process it until it gets a "Property
> changed" signal. Now in that case, the DBUS client may have to handle
> the situation where it may never get a "Property Changed" signal
> (because the connection did not go through), but there would be app
> specific ways of handling it and it may or may not involve just letting
> the user know the hard truth.
> Hence I think it is crucial to let the DBUS App know what kind of value
> it is getting inorder to empower it to make decisions.
> 
> One alternative would be to let the "value" property always read from
> cache and a "readValue" API always read from a connection, so that the
> DBUS application can decide which DBUS operation to use based on its
> usecase. The "readValue" API must return the value if the connection is
> active, or else return a status code indicating that connection
> procedure has been triggered and later (once connection and read
> procedures are over) emit a signal (maybe "propertyChanged") to signal
> the read value.
> 

Can you please try and think of a situation where a client may need the old value, knowing that it may not be the correct one? Why would anyone needing a value from the server need a cached value which has no meaning at the time of the "get_properties", knowing also that it should wait for the "property_changed" event ? This design is totally wrong, and may cause problems. I really see no reason for keeping the cached value. The correct behavior can be one of the two :
1. ReadValue method, blocking if a connection is up, returning the value, or returning some kind of error to let the client know that a value can not be read at the moment if the link is down or pending.
2. ReadValue method invokes a procedure for reading the value. A ReadValueComplete signal/watcher method is then raised when the value was actually read from the server (connection is successful).

These should replace the "Value" property, removing it from the list.

I would prefer method 1, since it's more straight forward, and allows the client to know exactly what is going on.

BR
Chen Ganir.
