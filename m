Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Tim Chick <chick@computergeek.freeserve.co.uk>
To: bluez-devel@lists.sourceforge.net
Date: Wed, 13 Jun 2007 10:22:35 +0100
References: <39D0ED4A56B05A409DB3C01F8DCEFB54F3281C@CORPAPPL021.corp.saab.se>
In-Reply-To: <39D0ED4A56B05A409DB3C01F8DCEFB54F3281C@CORPAPPL021.corp.saab.se>
MIME-Version: 1.0
Message-Id: <200706131022.35416.chick@computergeek.freeserve.co.uk>
Subject: Re: [Bluez-devel] SCO with BlueZ 2.15?
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

On Tuesday 12 June 2007 16:41, Bengtsson Mikael wrote:
> I'm developing an application on an Intel Xscale PXA 255 platform. I
> have installed BlueZ utils and libs 2.15 that was included on the
> software CD.
>
> The application opens some ACL connections and a few SCO connections.
> The ACL connections starts up fine, but the SCO connections doesn't
> start at all. When inspecting the loaded modules with lsmod, SCO is
> not loaded.
>
> The question is, is SCO working with version 2.15?

Sorry if you have already checked this, but did you enable SCO support 
in the hci_usb kernel module? The option is BT_HCIUSB_SCO.

When I was getting SCO going on my PXA270 based device I had this 
problem - that the hci_usb module was not compiled with SCO support.

Thanks,
Tim


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
