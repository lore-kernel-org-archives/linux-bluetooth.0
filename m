Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <016701c40ffc$8a07f8d0$b67ba8c0@zaz1>
From: "Xavier Garreau" <x.garreau@prim-time.fr>
To: "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
References: <405E6C9E.1030600@india.hp.com> <1079937432.2663.78.camel@pegasus>  <405EBCDD.3090402@india.hp.com> <1079951177.2663.90.camel@pegasus>
Subject: Re: [Bluez-users] l2test problem
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Mon, 22 Mar 2004 11:57:54 +0100

> yes, they are the uint16 numbers besides the uuid16 protocol UUID for
> L2CAP, but why do you want them? You asked about a mobile phone and most
> of them are based on the higher layer RFCOMM. So far I haven't seen any
> phone that support BNEP, HID or HCRP. And this means that in your case
> only two PSM's are supported. PSM 1 for the SDP requests and PSM 3 for
> the RFCOMM protocol.

Symbian Phones like Nokia 3650 allows you to use an L2CAP (or higher) api
for application programming.

But as with other bluetooth applications, you of course must have a server
llistening on a given PSM for it to answer "Connection accepted" (0).

mohalik, you should have a look at development papers from Sony Ericcson
(and maybe nokia) on symbian bluetooth programming (Basically, they also
provide a socket interface).

http://developer.sonyericsson.com/ (you'll have to create an account first)

BR,
-- 
Xavier Garreau <x.garreau@prim-time.fr>
Prim'Time Technology
http://www.prim-time.fr/



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
