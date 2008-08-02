Return-Path: <cyrus@holtmann.org>
Message-Id: <2029612C-ECB0-4D32-80CB-1CC731F04E3D@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20080802T123158-266@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Date: Sat, 2 Aug 2008 18:20:07 +0200
References: <loom.20080802T123158-266@post.gmane.org>
Subject: Re: [Bluez-devel] [Share] dynamic alternative setting needs usb
	core change
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

Hi Jui-Hao,

>  After working on this subject for one month. (no matter on old  
> hci_usb.c or on
> btusb.c), eventually I found that if we want to change the  
> alternative setting
> of a usb interface, the only way is to use "Set Interface" in  
> "Standard Device
> Request" defined by usb specification. In usb core message.c, the  
> corresponding
> is usb_set_interface() function. Besides, there is no additional  
> behavior
> definition after the "Set Interface" request.
>  From my current experiment, it seems that once the interface is  
> set, the
> reserved bandwidth will be reset, which means the adapter may find  
> out "oh! my
> bandwidth is reset, what should I do to my current voice link ?"
>  Anyway, maybe I am too pessimistic, maybe it just needs to change  
> the usb core
> driver to support some asynchronous action instead of brutal force  
> to reset the
> bandwidth of all current connections. I will look into it later.
> The following is a update to Alok's patch, which tries to resubmit a  
> new urb
> request after usb_set_interface()

actually Oliver posted the first attempt for the btusb changes and  
that is what you should be working on. The hci_usb driver is really  
unfixable and not even worth to bother since once btusb gets full SCO  
support, we are going to remove it.

Also create unified diffs. I am never gonna twist my brain to read  
context diffs.

Regards

Marcel


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
