Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA23F187;
	Mon, 27 Nov 2023 12:51:13 -0800 (PST)
Received: from p200301077700a9001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:a900:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1r7iZR-006mqW-Ju; Mon, 27 Nov 2023 21:51:09 +0100
Date: Mon, 27 Nov 2023 21:51:08 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Tony Lindgren <tony@atomide.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 johan@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 tomi.valkeinen@ideasonboard.com, =?UTF-8?B?UMOpdGVy?= Ujfalusi
 <peter.ujfalusi@gmail.com>, robh@kernel.org
Subject: Re: [RFC PATCH 0/3] bluetooth/gnss: GNSS support for TiWi chips
Message-ID: <20231127215108.6e985819@aktux>
In-Reply-To: <20231127135424.GO5169@atomide.com>
References: <20231126191840.110564-1-andreas@kemnade.info>
	<20231127135424.GO5169@atomide.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 27 Nov 2023 15:54:24 +0200
Tony Lindgren <tony@atomide.com> wrote:

[...]
> > - Output at /dev/gnssX:
> >   AI2 vs. NMEA
> >   The chip can be configured into sending AI2-encapsulated NMEA,
> >   or proving data in a binary format.
> >   Some research has to be done yet for the details.
> >   A pile of logs is waiting for further analysis...
> > 
> >   Arguments for/against NMEA:
> >   + Userspace is prepared to handle it
> >   + Power management can be easily done by the kernel
> >   - Less functionality can be used.  
> 
> I'd go with NMEA format as the default setting :)
> 
yes, that would also be my preference.

> >   Arguments for/against AI2:
> >   + Full functionality can be accessed from userspace (incl. A-GPS,
> >     maybe raw satellite data)
> >   - Userspace has to behave to have proper power management
> >   - No freely (not even as in beer) tool available to fully use AI2,
> >     so there will be only a real advantage after long "French Cafe"
> >     sessions.  
> 
> Seems AI2 could be optionally enabled as needed with some writes
> to /dev/gnss0 to change the mode?

Hmm, we have
/sys/class/gnss/gnss0/type to get the mode, maybe we add some file
to change the mode? Or having it hidden behing a module parameter
and implement something better accessible if any need arrives?

If we want NMEA output, probably some init commands will be sent at
open(), but userspace doing something with AI2 probably does not want
the device touched, so it should probably be already be set before open().

Regards,
Andreas
