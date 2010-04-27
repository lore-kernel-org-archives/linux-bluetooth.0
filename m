Return-Path: <cyrus@holtmann.org>
From: Kalle Valo <kalle.valo@canonical.com>
To: ofono@ofono.org
Cc: "linux-bluetooth\@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: DUN client for oFono and BlueZ
References: <20100427012059.GG12813@vigoh>
Date: Tue, 27 Apr 2010 09:03:05 +0300
In-Reply-To: <20100427012059.GG12813@vigoh> (Gustavo F. Padovan's message of
	"Mon, 26 Apr 2010 22:20:59 -0300")
Message-ID: <8739yhsa92.fsf@potku.valot.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

"Gustavo F. Padovan" <gustavo@padovan.org> writes:

> Hi all,

Hello Gustavo,

> I'm starting the DUN Client implementation for the Linux Stack. DUN is
> the Bluetooth dial-up network profile. It makes possible share internet
> connection between two Bluetooth devices. That is my Google Summer of Code
> project for this year.

Excellent, I'm eagerly waiting for this. I hate cables =)

As soon as you have something working, please do send patches so that
people can test it.

> 4. Agent server on BlueZ. This one is very similar to the HFP Agent server. At
> the end of the DUN agent project I plan to merge the both agent servers. SAP
> will take advantage of that merge too.
>
> 5. oFono DUN agent. Implement the agent handling for DUN.

Sorry, I'm not familiar with HFP Agent, but what will this agent
actually do on a DUN connection?

> 6. AT command parser and PPP stack integration with DUN. The biggest task,
> where the core of the project is.
>
> 7. ConnMan integration. Setup of the NAT and Internet Connections.

Why NAT is needed? I guess only for connection sharing.

-- 
Kalle Valo
