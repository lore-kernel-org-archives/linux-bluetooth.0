Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCBC41CE@dnce01.ent.ti.com>
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
Date: Thu, 27 Oct 2011 11:13:44 -0400
Message-ID: <CAJdJm_O8eUWZ3HPXWXyXb0=iRiKSWnBzGGmmMVWTTGaQv+WVbw@mail.gmail.com>
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

On Thu, Oct 27, 2011 at 10:58 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> Characteristics have the ability to be notified or indicated, according to the profile requirements. We need to reflect those capabilities to the user, which can decide whether the characteristic will be notified or indicated. The bluetoothd will take care of the indication return code, and the watcher will be signaled with the existing mechanism.
>
> Would you rather see the register watcher get a second parameter to tell it the correct method, and change the properties to CanNotify, CanBroadcast to indicate the characteristic capability only (according to the char properties and availability of client char config descriptor)? If this is the case, than we may implicitly force notify or indicate only, not both of them, although the spec does not prohibit such behavior, and manage the watcher method internally.

Yes, I think read-only property is better. This way, it will mostly be
used to decide whether  RegisterCharacteristicsWatcher() is supported
or not. Also see the Luiz suggestion of using a list of strings. It
allows easily extending these GATT properties on future.

Regarding a new RegisterCharacteristicsWatcher() argument, I would
avoid it if we can for now. We could implicitly have a priority inside
BlueZ:

* if characteristic supports indication, use indication (usually, this
means the server needs to make sure the value was received, so it can
e.g. free that value from its internal memory).
* if characteristic supports notification, use notification
* else, make RegisterCharacteristicsWatcher() returns a D-Bus error.

That way, if a characteristic happens to support both indication and
notification, it will always use indication. If in future we find that
unsuitable for some profile, this can be changed, but let's try to not
make things too complex now :)

As a general suggestion, I propose you first get the API changes
"approved" and committed upstream, then proceed with code changes.
Unless you are comfortable with doing lots of rounds of patch
submissions (or you are planning only RFC to get early comments).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
