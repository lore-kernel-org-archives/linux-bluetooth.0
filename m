Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A6E434.3030107@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] a2play and Toshiba SR-1 Bluetooth Headset
References: <20041125091124.GA19805@snoopy.src.ricoh.co.jp>	 <20041125112509.75347786.henryk@ploetzli.ch>	 <20041125105615.GA19821@snoopy.src.ricoh.co.jp> <1101440449.6465.64.camel@pegasus>
In-Reply-To: <1101440449.6465.64.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 26 Nov 2004 01:07:16 -0700

hey

>       AVDTP(s): Discover rsp: transaction 0
>         ACP SEID 1 - Audio Sink
>         ACP SEID 3 - Audio Sink
>         ACP SEID 4 - Audio Source

i made a whack at receiving multiple seid records but it's wrong... the 
seid part got put in the part of the packet that doesn't get repeated.

i will give this the once-over tomorrow and hopefully have something 
that will discover seid 3 on the toshiba.

brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
