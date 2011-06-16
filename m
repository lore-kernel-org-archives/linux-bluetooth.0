Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4DF9E9FA.7050403@tieto.com>
References: <1308059827-15095-1-git-send-email-andrzej.kaczmarek@tieto.com>
	<1308136088.2518.3.camel@aeonflux>
	<4DF8B976.3060804@tieto.com>
	<1308147904.2196.5.camel@aeonflux>
	<4DF9E9FA.7050403@tieto.com>
Date: Thu, 16 Jun 2011 17:00:34 +0300
Message-ID: <BANLkTikZ41m2rMGSGCrOpYXEFFtfnfzv=Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add support for custom (e)SCO parameters
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com" <par-gunnar.p.hjalmdahl@stericsson.com>,
	"ulrik.lauren@stericsson.com" <ulrik.lauren@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 16, 2011 at 2:33 PM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> Why do you think re-creating the socket is not going to work? How it is
> different than second attempt to connect SCO when eSCO failed, which is n=
ow
> handled inside kernel? The same could be done by user-space but in more
> sophisticated way which suits specific requirements. And this is how
> negotiation is solved.

Well the socket API is not meant to do this type of negotiation while
connecting, you basically have connect/accept and in case you fail to
configure you have to give up this socket and create a new one, also
the error reported by the socket may not be enough to you to figure
out what went wrong the first time to retry.

> And what qualification testing will it break?
>
>
> Could you please elaborate a little bit more on the above questions so I =
can
> understand your point of view better.
>
> BR,
> Andrzej
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Luiz Augusto von Dentz
