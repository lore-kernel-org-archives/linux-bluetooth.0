Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <cvh9lh$2b0$1@sea.gmane.org>
References: <7aa80ced0502222239dd01830@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <7aa80ced0502222239dd01830@mail.gmail.com>
Subject: [Bluez-users] Re: Can't able to send data in both direction
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
Date: Wed, 23 Feb 2005 08:03:43 +0100

Hi,

>              I am trying to send data at L2CAP level.  I am using
> "Silicon Wave (11)" USB dongle in one PC and "Cambridge Silicon Radio
> (10)" USB dongle in another PC. Using my program I can able to send
> data from "Cambridge Silicon Radio" dongle side PC to "Silicon Wave"
> dongle side PC. But, vice-versa is not working. I am getting the
> following error when I try to send data from "Silicon Wave dongle".
>              Can any one tell me why this is happenning.            
You've forgotten to paste the error message. I think no one will be
able to help you without it. Please capture the packets using
`hcidump -X' when trying to connect from SiW to CSR dongle and post it
including the error message(s) you see.

Best regards,
Sebastian



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
