Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTim=DVTzgBXDp4Rsed8LNwfrY47ACg@mail.gmail.com>
References: <BANLkTim=DVTzgBXDp4Rsed8LNwfrY47ACg@mail.gmail.com>
Date: Wed, 8 Jun 2011 14:53:54 +0200
Message-ID: <BANLkTimboYUW4v=tHmVKiCKELqbGfAxegg@mail.gmail.com>
Subject: Re: Read clock not implemented in management
From: Santiago Carot <sancane@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Claudio.

2011/6/8 Claudio Takahasi <claudio.takahasi@openbossa.org>:
> Hi Santiago and Elvis,
>
> Read clock is not implemented in the management interface. Does it
> break something important in the health plug-in?
>

Read clock is only required for Clock Shynchronization Protocol (CSP)
in MCAP, but  CSP is not mandatory for HDP and although this feature
was implemented in MCAP is not used in the Health Plugin so it won't
break the API.

> I am not aware when hciops will be dropped, but the fact is: if the
> system uses mgmtops instead of hciops health will not work properly.
>

Well, as far as I know, only MCAP uses it for CSP and it's an optional
part in the specification so it won't a severe problem for health
applications.

> BR,
> Claudio.
>
