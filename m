Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: command tx timeout and continuous inquiry.
From: Marcel Holtmann <marcel@holtmann.org>
To: Rene Mayrhofer <rene@soft.uni-linz.ac.at>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3F950E33.3070303@soft.uni-linz.ac.at>
References: 
	<3F86784F.9050608@soft.uni-linz.ac.at>	<1065778372.14923.336.camel@baroque.r
			ococosoft.com>		<3F86A88E.4090106@soft.uni-linz.ac.at>	<1065790691.14513.1
	73.camel@pegasus>	 
	<3F86AF96.7000904@soft.uni-linz.ac.at>	<1065791594.14514.179.camel@pegasus>
	 <3F8FB6D9.8030000@soft.uni-linz.ac.at> <1066636708.902.5.camel@pegasus>
	<3F950E33.3070303@soft.uni-linz.ac.at>
Content-Type: text/plain
Message-Id: <1066735933.1005.114.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 21 Oct 2003 13:32:07 +0200

Hi Rene,

> Sorry to bother you again, but it still doesn't work as expected....

this must be a problem with your code. I checked it with two l2ping
commands and an inquiry from the command line and it works as expect. I
have used my Microsoft USB adapter for testing.

	hci0:   Type: USB 
	        BD Address: 00:50:xx:xx:xx:xx ACL MTU: 192:8  SCO MTU: 64:8
	        HCI 16.1.1
	        Chip version: BlueCore02
	        Max key size: 128 bit
	        SCO mapping:  HCI

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
