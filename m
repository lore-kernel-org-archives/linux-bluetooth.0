Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alain Volmat <avolmat@src.ricoh.co.jp>
To: bluez-devel@lists.sourceforge.net
Cc: Henryk =?iso-8859-1?Q?Pl=F6tz?= <henryk@ploetzli.ch>
Subject: Re: [Bluez-devel] a2play and Toshiba SR-1 Bluetooth Headset
Message-ID: <20041126045730.GJ27879@snoopy.src.ricoh.co.jp>
References: <20041125091124.GA19805@snoopy.src.ricoh.co.jp> <20041125112509.75347786.henryk@ploetzli.ch> <20041125105615.GA19821@snoopy.src.ricoh.co.jp> <1101440449.6465.64.camel@pegasus> <20041126041158.GF27879@snoopy.src.ricoh.co.jp> <20041126042705.GH27879@snoopy.src.ricoh.co.jp> <1101444102.6465.89.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1101444102.6465.89.camel@pegasus>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 26 Nov 2004 13:57:30 +0900

Hi Marcel,

* Marcel Holtmann [Fri, 26 Nov 2004 at 05:41 +0100]
<quote>
> Hi Alain,
> 
> > I remember now that this headset can also be used (using some tools from
> > toshiba) for speech recognization. Based on the toshiba windows tools,
> > the settings for this voice recognition mode and audio mode is different,
> > so there is a chance that this 2nd SEID is used for that purpose, using
> > a Toshiba specific codec.
> 
> but if you wanna record something from a headphone this must be a audio
> source.

Oups sorry you're right, I missed that point.

> However this makes somekind of sense, because the SEID 2 is
> missing in their list and they maybe use SEID 3 and SEID 4 together. So
> for SEID 4 the same capabilities should be expected as for SEID 3.

You're 100% right .. (see my previous email).

Alain
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now. 
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
</quote>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
