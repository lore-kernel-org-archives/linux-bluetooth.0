Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] piconet..
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <00c901c4df6a$f8c11f70$6401000a@zool>
References: <00c901c4df6a$f8c11f70$6401000a@zool>
Content-Type: text/plain
Message-Id: <1102764489.19086.15.camel@pegasus>
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
Date: Sat, 11 Dec 2004 12:28:09 +0100

Hi Steffen,

> I am trying to form a piconet, consisting of one server and two
> clients. I have snaped the most of the code from l2test.c and also
> made an advertising service and all. My problem is just that one one
> client can connect and the other one fails (host is down, i belive) .
> I have implemented the server using fork(), so that the parent process
> is still listening for new connections and closing my sockets correct
> (as what I can see..).
> I have browsed this newsgroup for answers, and can see something about
> setting the master/slave switch should help. I have also tried this,
> but it dosn't help. Anyone that have a clue about, what could be
> wrong?? 

show us the output of "hciconfig -a" for your devices.
 
> PS. I belive that the PSM in the L2CAP layer can serve more than one
> client or am I totally wrong? otherwise I should update the PSM
> everytime a new client connect..

It can also serve multiple PSM on the same ACL link.

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
