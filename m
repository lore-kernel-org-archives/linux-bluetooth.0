Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Piconet problems
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <IA9BDQ$E5979E3A6C8D2962359721362D0B163D@libero.it>
References: <IA9BDQ$E5979E3A6C8D2962359721362D0B163D@libero.it>
Content-Type: text/plain
Message-Id: <1105627179.7961.226.camel@pegasus>
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
Date: Thu, 13 Jan 2005 15:39:39 +0100

Hi Jers,

> hcid was not running. I've solved the inconsistency but no my problem.
> 
> Hi tried to create connection on slave1 side by
> # hcitool cc <master_addr>
> and so
> # hcitool con
> lists me the established connection.

send us the outputs of "hciconfig -a" for all of your devices. And don't
play with "hcitool cc". If you wanna test stuff then use l2test.

> After that, I tried to create the second connection on slave2 side by running the same command (hcitool cc <master_addr>) and I obtain the following error:
> # Can't create connectio: input/output error.

Run "hcidump -x" as root and show us the output.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
