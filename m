Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Suspend BT Socket card on Zaurus
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Ruzicka <pavouk@pavouk.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200407210941.07765.pavouk@pavouk.org>
References: <200407210941.07765.pavouk@pavouk.org>
Content-Type: text/plain
Message-Id: <1090396076.21683.46.camel@pegasus>
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
Date: Wed, 21 Jul 2004 09:47:56 +0200

Hi Pavel,

> I have old Socket BT CF card (Nokia based) on Sharp Zaurus SL-C860.
> This card use module dtl1_cs on 2.4.18-rmk7-pxa3-embedix kernel.
> On every suspend/resume Zaurus makes cardctl eject/insert
> action, which takes many of time. I was tried to remove these actions
> from apm.d scripts and leave only cardctl suspend/resume.
> But after this modification card doesn't work ;-)
> 
> It's possible to do something for working card without cardctl eject/insert
> commands?
> 
> It's a problem of controller, card or kernel module?

the suspend/resume is not working with these cards and this is a known
problem. I have full suspend/resume support as a work item on my todo
list, but don't expect any of that work for a 2.4 kernel.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
