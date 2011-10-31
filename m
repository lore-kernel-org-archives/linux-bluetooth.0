Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8DCFA6B89B9E70418E47A2348D55495A4790C33B@banasiexm01.ASIA.ROOT.PRI>
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
	<7769C83744F2C34A841232EF77AEA20C01DCBC483B@dnce01.ent.ti.com>
	<CAJdJm_M0cK5YzpHeWhjLdm+Tekej3nGue_Dc44nT-Ba6Fo7S+A@mail.gmail.com>
	<8DCFA6B89B9E70418E47A2348D55495A4790C33B@banasiexm01.ASIA.ROOT.PRI>
Date: Mon, 31 Oct 2011 16:53:29 +0200
Message-ID: <CABBYNZJN=HarjUS_mTHGgUEYmetr7UG1nvOdhxe-dxnY_HCn5g@mail.gmail.com>
Subject: Re: GATT Dbus API on BlueZ - attirbute-api.txt modifications
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ajay Pillai <Ajay.Pillai@csr.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	"Ganir, Chen" <chen.ganir@ti.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"bgix@codeaurora.org" <bgix@codeaurora.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 31, 2011 at 3:35 PM, Ajay Pillai <Ajay.Pillai@csr.com> wrote:
> Hi Anderson,
> Hello Chen,
>
>> What about writing the value? Should we allow the user to set the value with either Write request/Write Command/Write signed or do we >really want to keep that internal (like read/read blob) ?
>
>>Again, If I were to implement it, I would stick with the core spec requirements, and checking Characteristic Properties and the link >encryption status for deciding which operation to use. But if you really think it is useful to allow D-Bus clients "break" spec >requirements some times, you can provide this control. This particular detail is not my main concern :).
>
>
> Can we detail out the "write" API design once again, please? There has been too much discussion and hence I am not sure, which way it is going.
>
> There are two main aspects to write"
>
> 1) The write mechanism -
>        a) Do we do a setproperty() or do we add a new API writeValue()?
>        b) Is the method blocking or non-blocking?
>        c) If non-blocking,what is the mechanism like?
> My understanding - if the write is called while the connection is not active, then the value is going to be buffered in BlueZ while BlueZ tries to get the connection up. When the connection comes up, after the write operation is complete, BlueZ will emit a signal indicating that it is written.

Do you guys really know what you are talking about? D-Bus does not
support blocking calls, it basically waits the reply to return but it
can get other messages while waiting which will be reorder to be
dispatched after, so using pseudo blocking calls on production
software is _not_ recommended. Besides we will always have to signal
if there are multiple application watching the same characteristic,
the user of SetProperty can use that to catch when the value was
finally written but if an error occur then it is better to handle the
return of SetProperty, or actually a method like Write would be better
in this case so that a method can be given and an error can be
returned. (btw this was part of Chen's initial suggestion).

> 2) The choice of write operation - Does it lie within BlueZ or is it given to DBUS Apps. I guess Anderson is okay with giving some control to the DBUS App.
>        a) write without response, write with response, signed write without response -
> I believe the DBUS App must be allowed to indicate its preference among these to BlueZ. BlueZ must be able to meet this preference in most of the cases, but in cases where it cannot, BlueZ must throw an error. It would in most cases be a wrong request from App (using signed write on a long characteristic, for instance)
>        b) Write long characteristics value
> This, I believe, is a value add to Apps, if done autonomously within BlueZ.
>        c) reliable write of one characteristic
> Not covered in this discussion so far. But worth having a separate API like writeReliable(offset, value, {"prepare","execute"})?
>        d) reliable write used for atomic write of multiple characteristics
> Not covered in this discussion so far. Same API as above. But an "execute" operation on any char object will do complete the reliable write operation.
>
> Regarding reliable writes, we will need to figure out a state machine within BlueZ that blocks out other operations on a remote server during a prepare-execute cycle and also an exit criteria from that "block-other-operations" state to cater to Aps that disappear after doing a "prepare".

You guys do realize D-Bus is an IPC so that round trips are expensive
and does follow some standards when defining API, also blocking
operations/returning errors is probably a bad idea we should probably
queue the operation and send when the server is no longer busy.

So IMO we basically need Read/Write methods, those need a connection
and do not access the cache but they do always need to update the
cache and emit PropertyChanged when the value has changed so Value
property must stay so that GetProperties can be used as a lazy read
which is very useful in case the characteristic doesn't change or the
server notify its updates. Read method can be use to keep values in
sync with the server, but keep in mind that polling will always have a
interval where the value is not in sync so notification should be
always preferable.

-- 
Luiz Augusto von Dentz
