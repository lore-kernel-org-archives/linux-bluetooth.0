Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4239A289.4080204@futurlink.com>
From: Pedro Monjo Florit <pedro.monjo@futurlink.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] obex howto
References: <423992C8.8000309@prim-time.fr>
In-Reply-To: <423992C8.8000309@prim-time.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 17 Mar 2005 16:30:17 +0100

Xavier Garreau wrote:
> Hi,
>
> Is there somewhere a bluez/obex HOWTO ?
>
> I'm about to write a tutorial for python on Symbian/Series60. An 
> Application from nokia allows to execute python scripts on a Series60 
> phone via a Bluetooth remote python console (this works using spp).
>
> Actually, to complete my _linux_ tutorial, i need do transfer a .sis 
> to the phone (via obex) and have not yet played with this on linux ...
>
> Any hints ?
>
> Thanks in advance

Hi Xavier,

AFAIK, the only implementation running under Linux is OpenOBEX 
(http://openobex.sourceforge.net/). There is not much documentation in 
it, but, as with BlueZ, if you follow the applications, you can (more or 
less) understand how it works.

If you want to send a file via OBEX over Bluetooth, I use KBluetooth, 
that works pretty well.

Regards,

Pedro


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
