Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] How to configure a 723kbps connection?
From: Marcel Holtmann <marcel@holtmann.org>
To: grpmind+bluez.users@boromir.vpop.net
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040215000300.0C48932D37@mail.rvs.uni-bielefeld.de>
References: <20040215000300.0C48932D37@mail.rvs.uni-bielefeld.de>
Content-Type: text/plain
Message-Id: <1076855596.14758.52.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 15 Feb 2004 15:33:16 +0100

Hi,

> I'd like to configure a linux box using a USB bt dongle to talk to an ipaq    
> at 723kbps for streaming video. So two questions:

what iPAQ is this?

> 1. How can I tell at what rate the two bluetooth devices are talking? I could   
> use l2test if I could run linux on the ipaq, but I can't (yet).

Buy a protocol analyser ;)

> 2. How can I configure the two to talk at the assymetric 723kbps rate? 

In general this is not needed, because the link manager should choose
the best package types for you.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
