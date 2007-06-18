Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1182021864.30934.5.camel@aeonflux.inter-touch.com>
References: <1181925876.31424.326.camel@cookie.hadess.net>
	<1181978755.6846.46.camel@aeonflux.inter-touch.com>
	<1182012252.31424.353.camel@cookie.hadess.net>
	<1182021864.30934.5.camel@aeonflux.inter-touch.com>
Date: Mon, 18 Jun 2007 17:08:02 +0100
Message-Id: <1182182882.3161.59.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] HID initiated connections and input service
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

On Sat, 2007-06-16 at 21:24 +0200, Marcel Holtmann wrote:
<snip>
> something like that and I have no idea how to do that for Logitech
> devices. I have strange code for pure CSR dongles, but it is so ugly
> that I am not going to share it. It is mostly CSR vendor stuff.

Shame. Is there any reason to run hid2hci by default then? As in,
shouldn't be opt-in, rather than opt-out?

> > > Getting the HID report descriptor over USB makes always the assumption
> > > that it is exactly the same as on Bluetooth. This should be checked.
> > 
> > How can I verify that?
> 
> I don't have code for that. Need to write a tool that does this.

My version of sixpair gets the report descriptor over usb, and stuff it
in a hci_connadd_req, but the point is moot for HCI proxy dongles, and I
don't know how to get the Bluetooth one for the sixaxis.

-- 
Bastien Nocera <hadess@hadess.net> 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
