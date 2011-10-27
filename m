Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"bgix@codeaurora.org" <bgix@codeaurora.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Date: Thu, 27 Oct 2011 16:58:42 +0200
Subject: RE: GATT Dbus API on BlueZ - attirbute-api.txt modifications
Message-ID: <7769C83744F2C34A841232EF77AEA20C01DCBC41CE@dnce01.ent.ti.com>
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
 <CAJdJm_O8s6=tgq-e09xqfL6fq9ytDEKds0LCgPpT0H_KAtY=Sg@mail.gmail.com>
In-Reply-To: <CAJdJm_O8s6=tgq-e09xqfL6fq9ytDEKds0LCgPpT0H_KAtY=Sg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Anderson,

> -----Original Message-----
> From: Anderson Lizardo [mailto:anderson.lizardo@openbossa.org]
> Sent: Thursday, October 27, 2011 4:03 PM
> To: Luiz Augusto von Dentz
> Cc: Ganir, Chen; Mat Martineau; Claudio Takahasi; linux-
> bluetooth@vger.kernel.org; bgix@codeaurora.org; ingas@codeaurora.org
> Subject: Re: GATT Dbus API on BlueZ - attirbute-api.txt modifications
> 
> Hi,
> 
> On Thu, Oct 27, 2011 at 9:57 AM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
> > But, I don't see why have these (writable?) D-Bus properties if we
> > already have RegisterCharacteristicsWatcher(). Are you suggesting
> that
> > confirmations (for indications) should be sent manually by each D-Bus
> > client? Too error-prone IMHO.
> 
> To clarify, the question above was to Chen, not to Luiz.
> 

Characteristics have the ability to be notified or indicated, according to the profile requirements. We need to reflect those capabilities to the user, which can decide whether the characteristic will be notified or indicated. The bluetoothd will take care of the indication return code, and the watcher will be signaled with the existing mechanism.

Would you rather see the register watcher get a second parameter to tell it the correct method, and change the properties to CanNotify, CanBroadcast to indicate the characteristic capability only (according to the char properties and availability of client char config descriptor)? If this is the case, than we may implicitly force notify or indicate only, not both of them, although the spec does not prohibit such behavior, and manage the watcher method internally.

Chen Ganir.
