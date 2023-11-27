Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="lDa+yf0n"
X-Greylist: delayed 256 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 05:54:51 PST
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43652689;
	Mon, 27 Nov 2023 05:54:51 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 2844060505;
	Mon, 27 Nov 2023 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1701093291;
	bh=EtIU+PEYgPCx3Mm2g0hJqVPScocVED+L9UPkdbOXz1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lDa+yf0nu24ZFF11mlVKDcQNxjjZPmQEpyhqhHgHNjBNXQ6bjrTCAbfaVOoz9XVYe
	 7NcUJewdhEbEs/TiJGYhz36LdF/qRdEKaUVbzHwDG6ISRuB00apByCCXVhYnXiKKUR
	 tSF4mAZQMKb+hb1QXElHSZBd3fS5hO4gftfKEfDivEPvvEeLBCOzrLgnlHZRpQAnbH
	 L1w+T8TV0Bh3G4r9iuChudd0L066qawGN4U3c2mxbsagLdbw+WFYs8V4fq9OPBisLd
	 DprrwpQksmevBSGlYy7aKr/Zlp7vkhCyE8Ehdadyc1I9XUkJBkWM0NsFNB8oC/L9h/
	 SYyU2Zj0R8Awg==
Date: Mon, 27 Nov 2023 15:54:24 +0200
From: Tony Lindgren <tony@atomide.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
	johan@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	tomi.valkeinen@ideasonboard.com,
	=?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>,
	robh@kernel.org
Subject: Re: [RFC PATCH 0/3] bluetooth/gnss: GNSS support for TiWi chips
Message-ID: <20231127135424.GO5169@atomide.com>
References: <20231126191840.110564-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126191840.110564-1-andreas@kemnade.info>

* Andreas Kemnade <andreas@kemnade.info> [231126 19:18]:
> So the main questions I see:
> - is the approach right to abandon drivers/misc/ti-st?

Yes.

> - Output at /dev/gnssX:
>   AI2 vs. NMEA
>   The chip can be configured into sending AI2-encapsulated NMEA,
>   or proving data in a binary format.
>   Some research has to be done yet for the details.
>   A pile of logs is waiting for further analysis...
> 
>   Arguments for/against NMEA:
>   + Userspace is prepared to handle it
>   + Power management can be easily done by the kernel
>   - Less functionality can be used.

I'd go with NMEA format as the default setting :)

>   Arguments for/against AI2:
>   + Full functionality can be accessed from userspace (incl. A-GPS,
>     maybe raw satellite data)
>   - Userspace has to behave to have proper power management
>   - No freely (not even as in beer) tool available to fully use AI2,
>     so there will be only a real advantage after long "French Cafe"
>     sessions.

Seems AI2 could be optionally enabled as needed with some writes
to /dev/gnss0 to change the mode?

Regards,

Tony
