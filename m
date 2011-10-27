Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"bgix@codeaurora.org" <bgix@codeaurora.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Date: Thu, 27 Oct 2011 17:18:54 +0200
Subject: RE: GATT Dbus API on BlueZ - attirbute-api.txt modifications
Message-ID: <7769C83744F2C34A841232EF77AEA20C01DCBC41FC@dnce01.ent.ti.com>
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
	<7769C83744F2C34A841232EF77AEA20C01DCBC41CE@dnce01.ent.ti.com>
 <CAJdJm_O8eUWZ3HPXWXyXb0=iRiKSWnBzGGmmMVWTTGaQv+WVbw@mail.gmail.com>
In-Reply-To: <CAJdJm_O8eUWZ3HPXWXyXb0=iRiKSWnBzGGmmMVWTTGaQv+WVbw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Anderson
> 
> Yes, I think read-only property is better. This way, it will mostly be
> used to decide whether  RegisterCharacteristicsWatcher() is supported
> or not. Also see the Luiz suggestion of using a list of strings. It
> allows easily extending these GATT properties on future.
> 

I will add a string list called ValueChangeMethods and add Notify and Indicate as possible strings.

> Regarding a new RegisterCharacteristicsWatcher() argument, I would
> avoid it if we can for now. We could implicitly have a priority inside
> BlueZ:
> 
Ok, I'm good with this as well.

> * if characteristic supports indication, use indication (usually, this
> means the server needs to make sure the value was received, so it can
> e.g. free that value from its internal memory).
> * if characteristic supports notification, use notification
> * else, make RegisterCharacteristicsWatcher() returns a D-Bus error.
> 
> That way, if a characteristic happens to support both indication and
> notification, it will always use indication. If in future we find that
> unsuitable for some profile, this can be changed, but let's try to not
> make things too complex now :)
> 
I'll do that as well.

> As a general suggestion, I propose you first get the API changes
> "approved" and committed upstream, then proceed with code changes.
> Unless you are comfortable with doing lots of rounds of patch
> submissions (or you are planning only RFC to get early comments).
> 
This is the purpose of this document. Early next week I'll send the modified API text with the changes made according to the comments, and get the approval. For now, my implementation is internal, and is mostly to support some other work I need to get done.

Thanks,
Chen Ganir.

