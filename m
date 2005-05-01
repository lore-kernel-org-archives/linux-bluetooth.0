Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SBC Decoder with /dev/dsp
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1114952271.21785.13.camel@pegasus>
References: <20050501124348.24307.qmail@web8310.mail.in.yahoo.com>
	 <1114952271.21785.13.camel@pegasus>
Content-Type: text/plain
Message-Id: <1114965624.21785.71.camel@pegasus>
Mime-Version: 1.0
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
Date: Sun, 01 May 2005 18:40:24 +0200

Hi Mayank,

> > This is the improved version for the sbcdec.c file
> > which you asked for.
> > 
> > It uses /dev/dsp to play the decoded samples.
> > 
> > The output is pretty well if we incorporate the proper
> > endian type.
> > 
> > I suggest that you keep it as a separate file incase
> > someone wants to use the AO Libraries.
> 
> I will move the version using AO to sbcdec_ao and use your version
> instead. However first I must cleanup your coding style a litte bit.

I had to change a lot more and so I started over. Please take a look at
the end result in the CVS.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
