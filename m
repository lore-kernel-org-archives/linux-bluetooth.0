Return-Path: <cyrus@holtmann.org>
From: Ajay Pillai <Ajay.Pillai@csr.com>
To: "Ganir, Chen" <chen.ganir@ti.com>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"bgix@codeaurora.org" <bgix@codeaurora.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Subject: RE: GATT Dbus API on BlueZ - attirbute-api.txt modifications
Date: Mon, 31 Oct 2011 08:04:58 +0000
Message-ID: <8DCFA6B89B9E70418E47A2348D55495A4790C014@banasiexm01.ASIA.ROOT.PRI>
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
 <7769C83744F2C34A841232EF77AEA20C01DCBC482A@dnce01.ent.ti.com>
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCBC482A@dnce01.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Chen,


>Can you please try and think of a situation where a client may need the old value, knowing that it may not be the correct one? Why would >anyone needing a value from the server need a cached value which has no meaning at the time of the "get_properties", knowing also that it >should wait for the "property_changed" event ? 

I am not sure if we should be making assumptions about if such a "lazy read" would be of use to DBUS Apps. What I am trying to convey is that a design that supports both "lazy reads"(current approach suggested by Anderson which can potentially lead to less over-the-air operations, in multi-App scenarios) and "precise reads" (as described by ReadValue method) would cater to a wider set of usecases.

This also has potential to simplify quite a lot of "Clients" while dealing with servers that do not require polling. The Client just need to write the Client Characteristics Config and just forget about handling notifications or Indications, but just go on reading the value property whenever it needs it, trusting BlueZ to handle the notifications or indications and keeping the "value" property updated. However this would require a change in the way connections are managed as the DBUS Apps would need to be given more control over connections (something like reference counting of connections).


>This design is totally wrong, and may cause problems. I really see no reason for keeping the cached value. The correct behavior can be one >of the two :
>1. ReadValue method, blocking if a connection is up, returning the value, or returning some kind of error to let the client know that a >value can not be read at the moment if the link is down or pending.
>2. ReadValue method invokes a procedure for reading the value. A ReadValueComplete signal/watcher method is then raised when the value was >actually read from the server (connection is successful).

>These should replace the "Value" property, removing it from the list.

>I would prefer method 1, since it's more straight forward, and allows the client to know exactly what is going on.

I see method 2 as just an extension of method 1 where the API behaves likes method1 if the connection persists and if the connection is not present, then it lets the client know (as method1) and then moves on to method2.


Tank you
ajay


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
