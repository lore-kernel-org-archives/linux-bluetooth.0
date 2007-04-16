Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200704162036.15543.Volker.Christian@fh-hagenberg.at>
References: <200704162036.15543.Volker.Christian@fh-hagenberg.at>
Date: Mon, 16 Apr 2007 22:54:27 +0200
Message-Id: <1176756867.30191.6.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Bug in hcid prevents naming of devices by
	means	of the bluetooth-address of a device
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

Hi Volker,

> the man-page of hcid.conf describes how to configure more than one bluetooth 
> devices installed on one machine.
> It says:
> ----------------------
> nn:nn:nn:nn:nn:nn
> 
>               Parameters  specified  within  this  section  will  be
>               applied  to  the  device  with  this  device bluetooth
>               address. All other parameters  are  applied  from  the
>               default section.
> ----------------------
> This is broken in the current (3.9) and previous version of the bluez-utils. 
> The current debian-package is also affected.
> 
> Following patch to main.c of the hcid fixis this problem:
> 
> --- main.c-orig 2007-04-16 20:23:41.000000000 +0200
> +++ main.c      2007-04-16 20:22:30.000000000 +0200
> @@ -124,7 +124,7 @@
>         struct hci_dev_info di;
> 
>         /* First try to get BD_ADDR based settings ... */
> -       if (!hci_devinfo(hdev, &di) < 0) {
> +       if (!(hci_devinfo(hdev, &di) < 0)) {
>                 char addr[18];
>                 ba2str(&di.bdaddr, addr);
>                 device_opts = find_device_opts(addr);

does "if (hci_devinfo(hdev, &di) == 0) {" also work for you?

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
