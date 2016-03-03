Return-Path: <tore@fud.no>
Date: Thu, 3 Mar 2016 21:44:19 +0100
From: Tore Anderson <tore@fud.no>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
 <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org
Subject: Re: PROBLEM: Bluetooth mouse not working after resume since commit
 2ff1389
Message-ID: <20160303214419.6ac7558a@envy.w5.y.home>
In-Reply-To: <20160303084229.GA15622@t440s.ger.corp.intel.com>
References: <20160220181259.1e28f8da@envy.w5.y.home>
	<20160220182339.GA1648@t440s.P-661HNU-F1>
	<20160220182919.GA2620@t440s.P-661HNU-F1>
	<20160220213028.35760428@envy.w5.y.home>
	<20160221070226.GA12780@t440s.P-661HNU-F1>
	<20160221121322.6a19b1d4@envy.w5.y.home>
	<20160303085116.0567712b@echo.ms.redpill-linpro.com>
	<20160303084229.GA15622@t440s.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

* Johan Hedberg

> One thing you could still try is use an even newer kernel, such as the
> bluetooth-next tree or the latest 4.5-rc release, and see if the issue
> still persists.

I did with fresh git pulls:

bluetooth-next @ 9dbadc0: Works
linux (torvalds) @ f983cd3: Broken

If you'd like I can try to bisect it this weekend to figure out exactly
where it got fixed, if not I'll just content myself with the knowledge
that it'll probably get fixed in the mainline kernel eventually.

Tore
