Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Ruben Jenster <rjenster@web.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Connect button does not work anymore?
References: <200503301323.56682.rjenster@web.de> <424AF7E3.3060208@xmission.com>
In-Reply-To: <424AF7E3.3060208@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200503302154.41710.rjenster@web.de>
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
Date: Wed, 30 Mar 2005 21:54:41 +0000

On Wednesday 30 March 2005 19:02, Brad Midgley wrote:
> Ruben,
>
> Now, the SCO connection will be brought up on demand when the audio
> client tries to use it. Is there something you're trying to do that is
> not working with this new scheme?

No, everything is fine. Just want to make sure that I understod the new 
behaviour. 

>
> You can use the new stuff Fredrik Tolf added to invoke a program when
> the connect button is clicked. I haven't documented it yet--I need to
> dig up his explanation of it from the list.

That's a really cool feature. I looked for it in the mailing list archives 
because I'm interessted in this feature. I think this should be the right 
message: http://sourceforge.net/mailarchive/message.php?msg_id=11151435

It would be nice if Fredrik could provide an example how to invoke a programm.

Ruben

>
> Brad
>
> Ruben Jenster wrote:
> > Hi,
> >
> > connecting to my headset works with btsco v0.4 but the connect/disconnect
> > button does not work anymore. When starting btsco in verbose mode I get
> > displayed when the button was pressed but nothing happens.
> > Is this a wanted behaviour?
> >
> > tsco v0.4
> > Device is 0:0
> > Voice setting: 0x0060
> > RFCOMM channel 1 connected
> > speaker volume: 1 mic volume: 1
> > driver is in use
> > connected SCO channel
> > Done setting sco fd
> > recieved AT+VGS=01
> > Sending up speaker change 1
> > speaker volume: 1 mic volume: 1
> > driver is not in use
> > disconnected SCO channel
> > speaker volume: 1 mic volume: 1
> > driver is in use
> > connected SCO channel
> > Done setting sco fd
> > recieved AT+VGS=01
> > Sending up speaker change 1
> > recieved AT+CKPD=200		-> connect button pressed
> >
> >
> > Regards
> >
> > Ruben
> >
> >
> > -------------------------------------------------------
> > SF email is sponsored by - The IT Product Guide
> > Read honest & candid reviews on hundreds of IT Products from real users.
> > Discover which products truly live up to the hype. Start reading now.
> > http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
> -------------------------------------------------------
> This SF.net email is sponsored by Demarc:
> A global provider of Threat Management Solutions.
> Download our HomeAdmin security software for free today!
> http://www.demarc.com/Info/Sentarus/hamr30
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
