Return-Path: <cyrus@holtmann.org>
Message-ID: <47EA7502.0@access-company.com>
Date: Wed, 26 Mar 2008 17:08:34 +0100
From: Frederic Danis <frederic.danis@access-company.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] HID certification using PTS
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

Hello,

I am testing HID (BlueZ utils 3.22) using latest PTS (2.3.1) and I got 
some problems with it :

- currently, when performing a CreateDevice, input service connects then 
disconnects from remote device. This makes some tests failed.
What do you think if this does not disconnect (and create classic device 
connection) ?

- when kernel (2.6.22) receives a VIRTUAL_CABLE_UNPLUG from PTS (tests 
TC_HOS_HCR_BV_02_I and TC_HOS_HCR_BV_04_I) it does not close the L2CAP 
channels as PTS waits for.
I take a look in 2.6.22 sources, and it seems to me this disconnection 
should happen, am I right ?
Is it fixed in later kernel ?

Regards

Fred

-- 
-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic                   Access Company
Software engineer
Mail : mailto:frederic.danis@access-company.com
-----------------------------------------------


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
