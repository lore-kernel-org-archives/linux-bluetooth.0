Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] position of multiple bluetooth dongles
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200502101825.15870.cijoml@volny.cz>
References: <420B9635.6020701@gmx.ch>  <200502101825.15870.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1108057316.15974.93.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 10 Feb 2005 18:41:56 +0100

Hi Michal,

> BT 1.1 dongles may interference...
> BT 1.2 only when comunication with 1.1 devices - 1.2 devices can never 
> interference

let me correct this. AFH is not for detecting used frequencies of other
Bluetooth piconets. It only detects other wireless technologies, because
for itself it is already protected by the hopping sequence itself. If it
is the same hopping sequence it is the same piconet and thus it really
wants to listen to its traffic.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
