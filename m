Return-Path: <cyrus@holtmann.org>
Message-ID: <013201c8cb5c$d507ff40$0132a8c0@Raymondpc>
From: "colorant" <colorant@163.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
References: <793776.37171.qm@web57914.mail.re3.yahoo.com><484EFFCF.90708@earthlink.net>
	<3e9cdced0806101527n7d1489fbme492c29ddf394e0b@mail.gmail.com>
Date: Wed, 11 Jun 2008 08:48:14 +0800
MIME-Version: 1.0
Subject: [Bluez-users] How to use Bluez with CSR chip ?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi

    I am not sure is this the proper place to put up this question, if not , 
please correct me.

    I was trying to run bluez on our board with bc4 chip. This chip need to 
set pskey before it can run

    I use hciattach and hciconfig to bring up the hci0 interface.

    Then I try hcitool hci0 scan with my earphone open.

    Nothing happend.

    while, if I using CSR's bchs a2dp demo , it's ok, I can play music. say 
hardware is ok.

    My question is :

    1. To enable bluez with csr chip, is there anything need to do vs the 
standard kernel and bluez package ? Some config need?

    2. Did I need to place the bootrap init sequence for the bc4 chip in 
some place if I using bluez ? say in kernel or in the bluez user space 
scripts? Or , the standard kernel and bluez utility already hand it, But I 
just do the wrong way ?


Many thanks.
Raymond




-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
