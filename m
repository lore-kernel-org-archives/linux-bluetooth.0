Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Do bnep and obex work simultaneously?
From: Marcel Holtmann <marcel@holtmann.org>
To: Taneli =?ISO-8859-1?Q?V=E4h=E4kangas?= <taneli.vahakangas@netsonic.fi>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1088782104.22055.7.camel@jumbo228.adsl.netsonic.fi>
References: <1088782104.22055.7.camel@jumbo228.adsl.netsonic.fi>
Content-Type: text/plain
Message-Id: <1088782788.2803.32.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 02 Jul 2004 17:39:48 +0200

Hi Taneli,

> I have a computer running kernel 2.6.7-mh1 and it is acting as a
> PANU (pand --connect ...), which works very well. The GN on the other end
> is a similarly configured computer. However, now I can't use ussp-push's
> obextool on the PANU computer to send files to the mobile phone. Is this
> expected or did I do something wrong? obextool push ... complains:
> Can't connect. Too many links (31)
> and fair enough, the connect() system call receives EMLINK. 

from the Bluetooth stack this is possible, but maybe your local device
won't support it. What does "hciconfig -a" say?

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
