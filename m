Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42DBF85E.8040407@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SCO in BlueZ
References: <20050718180329.52966.qmail@web26909.mail.ukl.yahoo.com>
In-Reply-To: <20050718180329.52966.qmail@web26909.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Mon, 18 Jul 2005 12:43:42 -0600

Javi,

sco/esco is passed directly through the hci layer.

l2cap is only involved in handsfree/headset profiles for negotiating the 
connection via the separate rfcomm connection. this rfcomm connection 
uses AT commands.

brad

javier labella wrote:
> Hi,
> I'm thinking to develop a profile on BlueZ, but even I'm not sure that 
> with bluez I could implement a profile that uses SCO links, that is to 
> say, I don't know if the SCO links are implemented in the l2cap.
>  
> Thanks for reading,
> Javi.
> 
> ------------------------------------------------------------------------
> 
> Correo Yahoo!
> Comprueba qué es nuevo, aquí 
> <http://us.rd.yahoo.com/mail/es/whatsnew/*http://es.whatsnew.mail.yahoo.com/>
> http://correo.yahoo.es


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
