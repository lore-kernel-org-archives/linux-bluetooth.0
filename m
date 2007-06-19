Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1181668619.31424.28.camel@cookie.hadess.net>
References: <1181668619.31424.28.camel@cookie.hadess.net>
Date: Tue, 19 Jun 2007 23:10:27 +0200
Message-Id: <1182287428.3135.0.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] More bluez-gnome patches
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

Hi Bastien,

> This updated monster patch:
> - Default to use_hal = FALSE, only enable it if it's available and
> support is compiled in
> - Remember the old operating mode in the adapter struct
> - Only show notification popups if we're not showing the icon only when
> a device is present (the icon appearing/disappearing is enough to see
> that the device is connected/disconnected)
> - Make all the strings more translator friendly
> - Split the adapter_setup to avoid HAL round-trips getting the
> formfactor multiple times
> - Simplify the GConf callbacks
> - Don't translate command-line warnings
> - Misc UI changes (mostly frame and borders sizes)

I applied some of these patches and I am going to release a 0.9 version
in a few minutes. Please re-sync and send separate patches for the stuff
that I left out.

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
