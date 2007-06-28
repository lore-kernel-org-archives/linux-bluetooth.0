Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2EB6297382462046A9427D7324788A4801F55370@MCLNEXVS06.resource.ds.bah.com>
References: <2EB6297382462046A9427D7324788A4801F55370@MCLNEXVS06.resource.ds.bah.com>
Date: Thu, 28 Jun 2007 16:57:35 +0200
Message-Id: <1183042655.9499.22.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hcidump with multiple dongles
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

Hi Richard,

> I've been working on a project that requires multiple Bluetooth
> dongles on a single PC. I have a USB 2.0 hub with two dongles. I can
> create my problem in the following manner:
>  
> - window 1     l2ping xx:xx:xx:xx:xx:xx  - so this command is running
> constantly.
> - window 2     hcidump -i hci0               - this command is dumping
> the output correctly.
> - window 3     hcitool scan -i hci1

this must be hcitool -i hci1 scan.

> - window 4     hcidump -i hci1
>  
> After a little while ( sometimes immediately ) the hcitool scan in
> window 3 will fail:
>  
> # hcitool scan -i hci1
> Scanning...
>  
> Inquiry failed. Connection timed out.
> #
> #
>  
> The test works fine if I do NOT use hcidump. That is, I can run window
> 1 and 3 all day with no problem. When I add hcidump, the "hcitool scan
> -i hci1" will then begin to fail to connect to the hci device.

Does using "hcitool inq" helps?

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
