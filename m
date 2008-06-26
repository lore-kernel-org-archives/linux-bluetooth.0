Return-Path: <cyrus@holtmann.org>
Message-ID: <52cf60ee0806261127r15b88ccod1bdba8d42ed4e59@mail.gmail.com>
Date: Thu, 26 Jun 2008 14:27:57 -0400
From: "Jui-Hao Chiang" <windtracekimo@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Meaning of hcitool -i dev con
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

Hi, dear all:
I am currently using Cyber-Blue Bluetooth USB adapter and Motorola
Razr V3 for experiments.
My goal is to use one adapter to open 3 SCO connections with 3 V3 cell phones.
The chan_mobile in Asterisk gives me the way to connect the adapter to
one phone. But when I use hcitool -i hci1 con to show the connections,
I don't know how to explain the output (00:19:2C:D5:90:DF is cell
phone's address):

Connections:
	> SCO 00:19:2C:D5:90:DF handle 2 state 1 lm SLAVE
	< ACL 00:19:2C:D5:90:DF handle 1 state 1 lm MASTER ENCRYPT

Does this mean that the USB adapter is playing TWO roles (master and
slave) at the same moment??

Hope some one can give some hint.
Best regards

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
