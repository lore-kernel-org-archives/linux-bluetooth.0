Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <cp3s24$2il$1@sea.gmane.org>
References: <41AD2B86.6010002@avantwave.com>	 <1101973471.15615.81.camel@pegasus> <41AFDAAB.8010101@avantwave.com>	 <1102043750.7350.41.camel@pegasus> <41B40C4B.90002@avantwave.com>	 <1102318698.8510.69.camel@pegasus> <41B44296.40805@avantwave.com>	 <1102332461.9644.13.camel@pegasus>	 <1ffb4b0704120605174bda678@mail.gmail.com>	 <1102339636.9644.18.camel@pegasus>	 <1ffb4b0704120606046b7bbfae@mail.gmail.com> <1102342812.9644.26.camel@pegasus> <41B57456.3080103@avantwave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <41B57456.3080103@avantwave.com>
Subject: [Bluez-devel] Re: About rfcomm socket
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
Date: Tue, 07 Dec 2004 10:10:28 +0100

Hi Mike!

>    After i make install bluez-lib-2.12 , i found that there is no sdp 
> lib. Does it combine to bluetooth lib? or i need to enable it in 
> configuration.

# ls bluez-libs-2.12/src
bluetooth.c  hci.c  Makefile.am  Makefile.in  sdp.c

So I guess libbluetooth contains sdp.

Best regards,
Sebastian



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
