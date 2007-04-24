Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <fc27e74b0704240413v5b6e2e80h7b2feb40d27de686@mail.gmail.com>
References: <fc27e74b0704240413v5b6e2e80h7b2feb40d27de686@mail.gmail.com>
Date: Tue, 24 Apr 2007 20:38:43 +0200
Message-Id: <1177439923.14980.14.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH]Dynamic Alternate Setting patch	(hci_usb.c)
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

Hi,

> As per the discussion on #bluez channel , I am attaching a patch which
> dynamically manages the the alternate settings for SCO channels.
> The patch includes the following :
> 
> 1. It declares a work queue(config_work), which is scheduled when
>              1. There is a change in number of SCO channels OR 
>              2. There is a change in the Voice setting. 
> 
> 2. On invocation it determines the alternate setting based on the
> table given in HCI - usb spec docs. The  table is also mentioned  in
> the patch. 
> 
> 3. It then empties all the queued isochronous URBs , except those
> which are already submitted. 
> 
> 4. It then sets the alternate setting by calling
> usb_set_interface().
> 
> I have tested this patch using "scotest". 
> I am using 2.6.21-rc7 with sco-flowcontrol-v4.2.diff patch. 
> 
> Let me know if  any changes are necessary. 

having global static variables doesn't work. It will break horrible in
case you attach a second Bluetooth dongle. Also the voice setting is
stored in hci_dev and always present. So no need to copy these
information. What you need to store is the current alternate setting and
then calculate the new one. Change the setting and then store it.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
