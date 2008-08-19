Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <3e9cdced0808180622k6185e215k6017ce2ba0cadd15@mail.gmail.com>
References: <3e9cdced0808180622k6185e215k6017ce2ba0cadd15@mail.gmail.com>
Date: Tue, 19 Aug 2008 09:00:01 +0200
Message-Id: <1219129201.7591.73.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] old patches - where to get from?
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

Hi,

> I would like to get the patch to provide bluez bluetooth support for
> Kernel 2.4.21.
> Some weeks ago this patch was available at bluez.org or
> holtmann.org.Unfortunately it isn't anymore. 
> And can anybody tell me what this patch makes? I guess it provides
> support for additional bluetooth devices as far as I kown for the AVM
> bluefritz usb dongel?
> Any other changes?

the 2.4 kernel is no longer supported. That is an ancient kernel. You
should not be using that one.

> Another question: Why is the bluetooth bluez subsystem distributed in
> the two folders drivers/bluetooth and net/bluetooth?
> So at which location is what implemented?

I think that is quite clear. Protocols in net/bluetooth and drivers in
driver/bluetooth.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
