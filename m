Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] get remote bt address
From: Erwin Authried <eauth@softsys.co.at>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de465760412230418552a4af6@mail.gmail.com>
References: <2de4657604122303546f813ecf@mail.gmail.com>
	 <1103803109.20258.79.camel@pegasus>
	 <2de465760412230418552a4af6@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1103822368.28433.187.camel@justakiss>
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
Date: Thu, 23 Dec 2004 18:19:28 +0100

Am Don, den 23.12.2004 schrieb Manjunath Prabhu um 13:18:

> Also, which would be the best Bluetooth PCMCIA card , the ones with
> linux drivers , for 2.6 kernels?
> 
the Conceptronic CBT100C is a class 1 card for < EUR 50,-.
I have used it with 2.4.20uc1 (uClinux) with success. With "regular"
Linux (2.4.22), the socket driver needed a small patch because the card
is encoded as a low voltage+3.3V card and wasn't powered up at all. 

Regards,
Erwin




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
