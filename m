Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] piconet..
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <01ae01c4e0f9$b64b1930$6401000a@zool>
References: <00c901c4df6a$f8c11f70$6401000a@zool>
	 <1102764489.19086.15.camel@pegasus>  <016d01c4df70$a8e297d0$6401000a@zool>
	 <1102767035.19086.18.camel@pegasus> <01a901c4df7a$666d4da0$6401000a@zool>
	 <002d01c4df96$cc2e2080$6401000a@zool> <1102783440.19086.28.camel@pegasus>
	 <003901c4df9e$a3fead20$6401000a@zool> <1102786636.19086.34.camel@pegasus>
	 <00b001c4dfa9$f3bc0870$6401000a@zool> <018c01c4e0f8$de417700$6401000a@zool>
	 <01ae01c4e0f9$b64b1930$6401000a@zool>
Content-Type: text/plain
Message-Id: <1102935905.8750.120.camel@pegasus>
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
Date: Mon, 13 Dec 2004 12:05:05 +0100

Hi Steffen,

> My problem was that I used the:
> 
> bacpy(&loc_addr.l2_bdaddr, local_bdaddr);
> 
> instead of :
> bacpy(&loc_addr.l2_bdaddr, BDADDR_ANY);
> 
> Before I bind my address and PSM..
> 
> Thus binding my PSM and all to a hardcoded address instead of BDADDR_ANY..
> My mistake! doh!..

I don't see a problem here as long as you put in the local address of
your Bluetooth dongle (hci0) in there. If this is not working correctly
then we might have a kernel bug.

> Well sorry for all the fuss and mail spam I caused.. But thanks for all your
> answers anyways. It is cool that a mailing list is functioning the way this
> do: quick and good answers! :-)

You are welcome.

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
