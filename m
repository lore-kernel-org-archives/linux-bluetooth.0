Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] compiling hciconfig for ARM
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY104-F3387CCB50D8B5E0CA2C7DAC1A50@phx.gbl>
References: <BAY104-F3387CCB50D8B5E0CA2C7DAC1A50@phx.gbl>
Content-Type: text/plain
Message-Id: <1103892070.20258.87.camel@pegasus>
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
Date: Fri, 24 Dec 2004 13:41:10 +0100

Hi,

> I have compiled the Bluez Utils and Libs 2.11 for a ARM platform,
> concretly for the CPU ARM7TDMI.
> I have done the compilation with uClibc-0.9.19 and in "hciconfig" tool
> I have a problem when I make"hciconfig -a" or "hciconfig hci0 name" or
> "hciconfig hci0 class" and other.
> All this problems occurs in file "hci.c", in function "int
> hci_send_req(int dd, struct hci_request *r, int to)".
> In this function when the program execute "n = poll(&p, 1, to)" I
> obtain a kernel panic like this (executing hciconfig -a):

what kernel and what Bluetooth hardware do you use?

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
