Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Creating more than one instance of BlueZ
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050520075738.73600.qmail@web8308.mail.in.yahoo.com>
References: <20050520075738.73600.qmail@web8308.mail.in.yahoo.com>
Content-Type: text/plain
Message-Id: <1116577042.24921.63.camel@pegasus>
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
Date: Fri, 20 May 2005 10:17:22 +0200

Hi Mayank,

> > I think the best you can expect is for bluez to see
> > hci0 and hci1. then 
> > you've got to make sure your apps choose the right
> > adapter.
> 
> That is not possible since we have only one set of
> modules for l2cap, rfcomm, bnep etc.
> 
> So even if I tell my app to use which adapter, only
> one app will have exclusive access to the modules.
> And the other app will be waiting for the first app to
> free the modules.
> 
> A deadlock!

this is simply wrong. No application will ever have exclusive access to
a kernel module. Or do you have to wait for your HTTP connection while
you are doing SMTP?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
