Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] CVS doubles
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41B6D872.6050308@suche.org>
References: <20041206225609.GA1177@zeus.galaxy.org.uk>
	 <cp3mkk$m7t$1@sea.gmane.org> <1102407664.8447.20.camel@pegasus>
	 <cp3rr7$1vv$1@sea.gmane.org> <1102411047.8447.28.camel@pegasus>
	 <cp4a8v$959$1@sea.gmane.org> <1102425729.8447.41.camel@pegasus>
	 <cp4df4$i6l$1@sea.gmane.org> <1102439143.8447.47.camel@pegasus>
	 <cp6fpq$167$1@sea.gmane.org> <1102496771.9988.35.camel@pegasus>
	 <41B6CBDC.4010802@suche.org> <1102499338.9988.44.camel@pegasus>
	 <41B6D872.6050308@suche.org>
Content-Type: text/plain
Message-Id: <1102504121.9988.47.camel@pegasus>
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
Date: Wed, 08 Dec 2004 12:08:41 +0100

Hi Thomas,

> ok i done an error with libdsp installed i run configure and before 
> running make i delete the old.
> And so he seek for it. Maybe bluez-utils should remove the check for 
> libsdp ? Becasue as you say
> it in compleate in libbluez now.

the check will go away once I finished bluez.m4, but for now the check
must to show people how to deal with it if they don't need special
features from newer Bluetooth library versions.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
