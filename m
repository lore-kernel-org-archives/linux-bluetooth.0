Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm socket and rfcomm tty
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <41D12158.6020206@avantwave.com>
References: <41D12158.6020206@avantwave.com>
Content-Type: text/plain
Message-Id: <1104315958.6319.13.camel@notepaq>
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
Date: Wed, 29 Dec 2004 11:25:58 +0100

Hi Mike,

>     I have little knowledge on tty structure, so i want to clarify 
> something is that, if i want to connect to a rfcomm enabled phone. Are 
> there any difference when i sending raw data to the phone with tty 
> rfcomm and socket rfcomm? I ask this question because i see that from 
> bluez-util rfcomm source code, tty connection is built up from socket 
> first and then set the tty attr. So if i do not need tty functions, only 
> read/write from/to external device is needed, socket rfcomm will be more 
> simple. Am i right?

this is right. The RFCOMM socket is the native interface and the TTY is
only there for legacy reasons.

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
