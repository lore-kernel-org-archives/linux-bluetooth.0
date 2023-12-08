Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBBA37173
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC+BiU9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C57C433C9;
	Fri,  8 Dec 2023 16:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702052678;
	bh=gykiqYtc4k3IIgq0rB2Qqi/i6sr8CFwAMkaTgwLZCaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LC+BiU9KOsLc7DDJe/HQilCeW5KGpfwDI7EHKQbzrIu/+TQuJdIAalhad0VByrU3A
	 0w6++h3e9aM0yPpmhhLL2g0ZoGxdBMwYtmllD6QVKB+R2oe4oPGzSs7+MQcfqlWZk9
	 VcwBdwf2ab2MW310u+dlix4jGulx3l4ZzSfxNGTXVyWCFKdi5LQFWHwtlSwpVncR32
	 nHntqJBVCyScpH9vwYA78Rmovru5AWX8OgkIUp9POW302tOsdjx1gDOwsj37QY3gk0
	 xLMFELWl8xVCMMEK4UbRuWAvaofUUX9KlAh96d95qFDbarK3bT3rvNjZH1/Hl9SfPi
	 jz8NcUvLUzpGw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rBdfL-0004nG-2C;
	Fri, 08 Dec 2023 17:25:28 +0100
Date: Fri, 8 Dec 2023 17:25:27 +0100
From: Johan Hovold <johan@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Tony Lindgren <tony@atomide.com>, marcel@holtmann.org,
	johan.hedberg@gmail.com, luiz.dentz@gmail.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
	=?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>,
	robh@kernel.org
Subject: Re: [RFC PATCH 0/3] bluetooth/gnss: GNSS support for TiWi chips
Message-ID: <ZXNDd57ImXjelBf4@hovoldconsulting.com>
References: <20231126191840.110564-1-andreas@kemnade.info>
 <20231127135424.GO5169@atomide.com>
 <20231127215108.6e985819@aktux>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127215108.6e985819@aktux>

On Mon, Nov 27, 2023 at 09:51:08PM +0100, Andreas Kemnade wrote:
> On Mon, 27 Nov 2023 15:54:24 +0200
> Tony Lindgren <tony@atomide.com> wrote:

> > > - Output at /dev/gnssX:
> > >   AI2 vs. NMEA
> > >   The chip can be configured into sending AI2-encapsulated NMEA,
> > >   or proving data in a binary format.
> > >   Some research has to be done yet for the details.
> > >   A pile of logs is waiting for further analysis...

Can you say something more about what the protocol looks like? Is there
some common framing that can/should be stripped by the driver in both
modes?

> > > 
> > >   Arguments for/against NMEA:
> > >   + Userspace is prepared to handle it
> > >   + Power management can be easily done by the kernel
> > >   - Less functionality can be used.  
> > 
> > I'd go with NMEA format as the default setting :)
> > 
> yes, that would also be my preference.
> 
> > >   Arguments for/against AI2:
> > >   + Full functionality can be accessed from userspace (incl. A-GPS,
> > >     maybe raw satellite data)
> > >   - Userspace has to behave to have proper power management
> > >   - No freely (not even as in beer) tool available to fully use AI2,
> > >     so there will be only a real advantage after long "French Cafe"
> > >     sessions.  
> > 
> > Seems AI2 could be optionally enabled as needed with some writes
> > to /dev/gnss0 to change the mode?
> 
> Hmm, we have
> /sys/class/gnss/gnss0/type to get the mode, maybe we add some file
> to change the mode? Or having it hidden behing a module parameter
> and implement something better accessible if any need arrives?

The 'type' attribute is intended to reveal the GNSS receiver type
(class) as a hint to user space to avoid having to detect it at runtime
using heuristics.

It does not reflect which mode is currently active for receivers that
provide both a vendor specific protocol and NMEA (e.g. u-blox
receivers).

User space can currently switch modes at will by writing to /dev/gnss0
as Tony mentioned.

It may or may not make sense to make sure a particular mode is set
during probe, for example, if there's no real use for the proprietary
protocol and everyone would just switch away from it immediately.

Johan
