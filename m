Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Adresse resolution in BlueZ
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050317161431.45633.qmail@web26607.mail.ukl.yahoo.com>
References: <20050317161431.45633.qmail@web26607.mail.ukl.yahoo.com>
Content-Type: text/plain
Message-Id: <1111078607.9741.7.camel@pegasus>
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
Date: Thu, 17 Mar 2005 17:56:47 +0100

Hi,

> Am I not undertandbale ?
> Is there someone who can understand me? 
> 
> I know that BNEP know the BD_ADDR of the peer device.
> But BNEP need to make a coresspondance beteewn the
> peer BD_ADDR address and the peer IP adress. This
> corespondance is made by ARP? how did bnep ask it from
> ARP.
> If you read all my example in my last mail you will
> understand my question.

you don't understand the working of ARP. Like IP and ICMP, the ARP
protocol is on the same layer and thus only a different transport
channel over BNEP is used. Inside the Linux kernel the network subsystem
has enough information to handle the complete ARP stuff after you
registered a new network device.

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
