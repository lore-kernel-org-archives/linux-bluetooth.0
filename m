Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <de33c8be0502160425215158ad@mail.gmail.com>
From: =?ISO-8859-1?Q?Fl=E1vio?= <flavio.henriques@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] TPL (transmit power level)
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
Date: Wed, 16 Feb 2005 12:25:51 +0000

Hi everbody,
I=B4m working with power control and i saw one thing that could be wrong:

Transmit power level (tpl) : _1octet (signed integer);
                                 _range: -30<=3D N<=3D20;
                                 _units: dBm.

In BlueZ the value of tpl is defined like unsigned int ( uint8_t level
) but i think that should be an int ( int8_t level ) like is defined
in core of bluetooth.

There is any particular reason for the level to be an unsigned int??

Regards Fl=E1vio!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
