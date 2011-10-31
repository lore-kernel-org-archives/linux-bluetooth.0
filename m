Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8DCFA6B89B9E70418E47A2348D55495A4790BF0B@banasiexm01.ASIA.ROOT.PRI>
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
Date: Mon, 31 Oct 2011 06:47:54 -0400
Message-ID: <CAJdJm_OByAp-wyfZLOQ4mbSE5v6z_ZQDoiUr9mHCsHL0exqkRA@mail.gmail.com>
Subject: Re: GATT Dbus API on BlueZ - attirbute-api.txt modifications
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ajay Pillai <Ajay.Pillai@csr.com>
Cc: "Ganir, Chen" <chen.ganir@ti.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"bgix@codeaurora.org" <bgix@codeaurora.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ajay,

On Mon, Oct 31, 2011 at 2:38 AM, Ajay Pillai <Ajay.Pillai@csr.com> wrote:
> Hi Anderson,
>
>> What if this value changes on the server itself, and notification is not enabled? The client will need a way to poll the real time >values, and not use a stale or cached value which is a big mistake here.
>
>>(This is not how it works on current implementation, but we already
> know that right?) You just keep reading the Value property in some
> loop in your code:
>
>>while <blah>:
>>    read-Value-property
>
>>If the connection is up, the ATT commands will be sent as soon as
>>possible. If not, connection is triggered, and then the ATT read
>>request/command is sent, and then PropertyChanged signal (should be)
>>sent.
>
> The problem I see with this approach is that the DBUS client does not get to know that the value that it got while doing a getProperty() is
> the value remembered by BlueZ and not the one directly read from the server at that time and hence potentially a stale value. I think it is important because some DBUS clients may just want to ignore any potentially stale value and not process it until it gets a "Property changed" signal. Now in that case, the DBUS client may have to handle the situation where it may never get a "Property Changed" signal (because the connection did not go through), but there would be app specific ways of handling it and it may or may not involve just letting the user know the hard truth.
> Hence I think it is crucial to let the DBUS App know what kind of value it is getting inorder to empower it to make decisions.

You are absolutely right here.

> One alternative would be to let the "value" property always read from cache and a "readValue" API always read from a connection, so that the DBUS application can decide which DBUS operation to use based on its usecase. The "readValue" API must return the value if the connection is active, or else return a status code indicating that connection procedure has been triggered and later (once connection and read procedures are over) emit a signal (maybe "propertyChanged") to signal the read value.

Looks a sane option to me. And it would allow the problem of doing
potentially unnecessary ATT requests while issuing GetProperties(). I
think a Value property is still useful for "read once on every
connection." values such as Tx Power. But both can work without
conflict.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
