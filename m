Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4EAAD61B.60600@codeaurora.org>
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
	<4EAAD61B.60600@codeaurora.org>
Date: Fri, 28 Oct 2011 16:09:01 -0400
Message-ID: <CAJdJm_P3ghjJyZwoJn=c=yjseZ-CY=T7X31MVmu=NTAChq9+9A@mail.gmail.com>
Subject: Re: GATT Dbus API on BlueZ - attirbute-api.txt modifications
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: "Ganir, Chen" <chen.ganir@ti.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Fri, Oct 28, 2011 at 12:19 PM, Brian Gix <bgix@codeaurora.org> wrote:
> I am also of the opinion that caching is the wrong thing to do in
> bluez/bluetoothd.

I think you guys should take a look at how the GATT read/write on the
generic D-Bus API is currently implemented (apologies if you done that
already).

I only used the "caching" word in my emails because it appeared at
some point on this thread. What happens is not caching in the "CS"
sense. It is more like "holding on a buffer". The value the client
reads is the last read one, and he gets notified by means of
PropertyChanged signal when the fresh value is read (after connection
establishment). We should not block D-Bus calls where possible, as far
as I know.

For writes, the value is hold by BlueZ while is re-establishes
connection. After the write is effective, a PropertyChanged is emitted
(If I remember correctly). That way, the API is not blocking.

The spec does not forbid the implementation to hold data in a buffer
while the connection is being restored (please provide me reference if
I am mistaken).

> As to moving forward towards more characteristic definitions and profiles, a
> do not think that by not caching, we will create the "poll fest" situation
> that Luiz fears. Applications that have been written with LE in mind should
> be the place where characteristic specific knowledge, such as persistence of
> data over time, should be.  An App that repeatedly polls a persistent
> characteristic value would be poorly written (the App should do it's own
> caching). In the unlikely event that Multiple Apps are sharing the same
> remote server (which as a LE Use Case, I would consider Rare) you are only
> increasing the Reads of persistent data on a 1 per App basis.

Please take a look at Time, Phone Alert Status and Alert Notification
profiles (specially their UCRDDs). BT SIG usually avoids creating
dependencies between LE profiles, but these profiles are ones where it
makes a lot of sense to be present on the same LE single mode device
(and the corresponding support on the dual mode device).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
