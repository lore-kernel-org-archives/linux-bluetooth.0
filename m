Return-Path: <cyrus@holtmann.org>
Message-ID: <47AFAE50.1040508@aircable.net>
Date: Mon, 11 Feb 2008 00:09:20 -0200
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <47AFA9A7.3030100@aircable.net>
In-Reply-To: <47AFA9A7.3030100@aircable.net>
Content-Type: multipart/mixed; boundary="------------010509000209050402000706"
Subject: Re: [Bluez-devel] CreateBonding while periodic scanning
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010509000209050402000706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Sorry I forgot the patch.

I confirmed the patch worked for an old Broadcom based dongle (D-Link
BT122) and for a CSR Bluecore 4 based dongle (AIRcable Host XR).

The patch should apply against the bluez-utils-3.26 vanilla package
> Hello List,
>
> As I asked in the forums I'm trying to create a bonding to a device
> while I'm running a periodic scanning.
>
> Thing is that for some reason hcid is blocking me to do this, and Marcel
> suggested removing the periodic inquiry check. But as he said, and I
> think the same, that check was created for a reason.
>
> The line that makes the conflict is this one (utils/hcid/adapter.c:
>
> static DBusHandlerResult adapter_create_bonding(DBusConnection *conn,
>                                                 DBusMessage *msg, void
> *data)
> .....
>
> if (adapter->discov_active || (adapter->pdiscov_active &&
> !adapter->pinq_idle))
> return error_discover_in_progress(conn, msg)
>
> pinq_idle is 0 in my case, so then I get a discovery in progress exception.
>
> Marcel suggested that I change the code to "if (adapter->discov_active
> )" but still we would like to know what that check is made, so we can
> get a better solution.
>
> Thanks,
> Manuel Naranjo
> Wireless Cables Inc.
>
>
>   


--------------010509000209050402000706
Content-Type: text/x-patch;
 name="adapter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adapter.patch"

--- adapter.c.orig	2008-02-01 21:16:31.000000000 -0200
+++ adapter.c	2008-02-10 23:50:31.000000000 -0200
@@ -2216,7 +2216,7 @@
 	str2ba(peer_addr, &peer_bdaddr);
 
 	/* check if there is a pending discover: requested by D-Bus/non clients */
-	if (adapter->discov_active || (adapter->pdiscov_active && !adapter->pinq_idle))
+	if (adapter->discov_active)
 		return error_discover_in_progress(conn, msg);
 
 	pending_remote_name_cancel(adapter);

--------------010509000209050402000706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------010509000209050402000706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------010509000209050402000706--
