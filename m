Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] DUND features
From: Marcel Holtmann <marcel@holtmann.org>
To: Edouard Lafargue <ELafargue@montrouge.sns.slb.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1080560568.1688.24.camel@gryffindor>
References: <1080560568.1688.24.camel@gryffindor>
Content-Type: text/plain
Message-Id: <1080561385.2281.231.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 29 Mar 2004 13:56:25 +0200

Hi Edouard,

>    I have read the Bluetooth DUN specifications, and it appears that
> devices supporting DUN are supposed to implement a set of
> AT-compatible commands in order to fully support this profile: so far
> it does not seem that DUND is supporting anything in particular.
> 
>    When using Palm-compatible devices as clients, this is not a
> problem because it is possible to configure them to start PPP link
> negotiation independently from link establishment. But in the case of
> Windows clients, it creates problems because the Windows computer
> sends AT commands and tries to dial a number to connect to the Linux
> server offering DUN...
> 
>    Are there plans to correct this at the moment? Alternatively, are
> there known workarounds to enable windows-based clients to connect to
> Linux servers running dund ? Apparently the option called "msdun" is
> not enough...

there is a difference between the DUN and LAN profile on the server side
even if our program for LAN access using PPP is called dund. For the DUN
profile you need a modem emulation (the AT command parser) on the server
side.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
