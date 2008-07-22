Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Tue, 22 Jul 2008 03:21:35 +0000 (UTC)
Message-ID: <loom.20080722T031618-791@post.gmane.org>
References: <loom.20080714T020902-534@post.gmane.org>
	<loom.20080721T023453-583@post.gmane.org>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] =?utf-8?q?Questions_when_tracing_the_hci=5Fusb?=
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

 
> I have tried to setup three PCs, each with a bluetooth usb adapter.
> http://www.cyber-blue.com/products_info.asp?id=19&code=AC
> PC1 is configured as Master role, and PC2 is Slave.
> The scotest can be used to send one SCO voice traffic from PC2 to PC1.
> But when I use another PC3 to connect to PC1,
> there is no connection request event found in PC1.
> (tried alternative settings from 2 to 5)

I find out one weird condition.
Once we dynamically call usb_set_interface somewhere else.
(In Alok's patch, it adjust it when hci_notify is triggered,
and the new isoc alternative setting will depend on sco_num)
The resubmit status in hci_usb_rx_complete fail with status -90.
Afterwards, no resubmit will keep working.

Is there any problem to call usb_set_interface besides of the probe phase?




-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
