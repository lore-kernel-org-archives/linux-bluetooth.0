Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] About rfcomm socket
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41AE995F.7030107@avantwave.com>
References: <41AD2B86.6010002@avantwave.com>
	 <1101882506.18840.18.camel@pegasus>  <41AD867D.2060609@avantwave.com>
	 <1101894514.18840.50.camel@pegasus>  <41AE995F.7030107@avantwave.com>
Content-Type: text/plain
Message-Id: <1101973471.15615.81.camel@pegasus>
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
Date: Thu, 02 Dec 2004 08:44:31 +0100

Hi Mike,

> There are 3 device, Target device, computer A, computer B. Target device 
> is running the code below i.e. connect to computer A through channel 3 
> and listen at channel 2. It supposed that computer B can connect to 
> target device when target device is connecting others, but it fails. And 
> when target stop connecting computer A, computer B can then connect to 
> target with channel 2!

what are the outputs of "hciconfig -a" for these three devices?

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
