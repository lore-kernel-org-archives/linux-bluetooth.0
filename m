Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] error about rctest
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <310528459.09297@bjut.edu.cn>
References: <310528459.09297@bjut.edu.cn>
Content-Type: text/plain
Message-Id: <1110577407.8511.6.camel@pegasus>
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
Date: Fri, 11 Mar 2005 22:43:27 +0100

Hi,

>   I have run the rctest,but I got the following messages:
> 
> root@EDK root]# rctest -n -i hci0 -P 1 00:02:5B:00:A5:A5
> 
> rctest[1324]: Can't get RFCOMM connection information: Protocol not available (92)
>              ~~~~~~~the error is born at the call to getsockopt(sk, SOL_RFCOMM, RFCOMM_CONNINFO, &conn, &optlen) in rctest.c
> 
> rctest[1324]: Connected [handle 0, class 0x000000]
>              ~~~~~~~Dose this indicate that  rfcomm connection is completed successfully?
> rctest[1324]: Receiving ...
> 
>                     Could you give me a clue to avoid this error?

install a Linux 2.6.11 kernel.

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
