Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Philip Langdale <philipl@mail.utexas.edu>
In-Reply-To: <44867199.2000409@mail.utexas.edu>
References: <44867199.2000409@mail.utexas.edu>
Date: Wed, 07 Jun 2006 09:15:31 +0200
Message-Id: <1149664531.22472.4.camel@localhost>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Latest 2.6.16-mh1 patch.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Philip,

> I just tried out the 2.6.16-mh1 patch and I'm seeing very laggy
> behaviour with my mx5000 mouse. With the 2.6.15-mh2 modified to
> remove the changes already in 2.6.16, I do not see this behaviour.
> 
> The interdiff is not huge but it's large enough that I can't
> see the culprit at a glance.

so it seems that I messed up when porting the HID report mode. Please
send me your modified 2.6.15-mh2 patch and I am going to take a look at
it.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
