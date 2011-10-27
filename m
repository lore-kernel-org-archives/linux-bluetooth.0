Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCBC41FC@dnce01.ent.ti.com>
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
	<7769C83744F2C34A841232EF77AEA20C01DCBC41FC@dnce01.ent.ti.com>
Date: Thu, 27 Oct 2011 11:35:51 -0400
Message-ID: <CAJdJm_O8gfXgj7Myk3Wnr7ypeTQ9ibctdk1xdeSUELtJyLWX_Q@mail.gmail.com>
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

On Thu, Oct 27, 2011 at 11:18 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
>> As a general suggestion, I propose you first get the API changes
>> "approved" and committed upstream, then proceed with code changes.
>> Unless you are comfortable with doing lots of rounds of patch
>> submissions (or you are planning only RFC to get early comments).
>>
> This is the purpose of this document. Early next week I'll send the modified API text with the changes made according to the comments, and get the approval. For now, my implementation is internal, and is mostly to support some other work I need to get done.

Once you are happy with the amount of comments, you should send your
changes in a format suitable for upstream submission (e.g. sent with
git send-email, no sign-off line, "[PATCH BlueZ]" as prefix etc.)

Thanks,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
