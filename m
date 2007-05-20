Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46507A79.5010409@doerges.net>
References: <46505989.3090103@doerges.net>
	<1179674825.23757.12.camel@violet>  <46507A79.5010409@doerges.net>
Date: Sun, 20 May 2007 18:56:39 +0200
Message-Id: <1179680199.24761.0.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hcid.conf: device section
	with	specific	bt	address is ignored
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

Hi Till,

> >> in hcid.conf a device section with a bluetooth address specified apparently is
> >> ignored. The following should work according to the man-page:
> >>
> >>> # *not* working
> >>> device 00:09:DD:10:42:C4 {
> >>>        name "%h (dongle 1)";
> >>> [...]
> >> The default device section is working as expected.
> > 
> > should be solved with bluez-utils-3.10.1.
> 
> That's nice to hear. :-)
> 
> Then out of curiosity: For bluez-utils-3.10.1 I get this for hcid:
> 
> --- snip ---
> May 19 18:33:38 myhost hcid[1942]: Can't open system message bus connection: Failed
> to connect to socket /var/run/ dbus/system_bus_socket: No such file or directory
> May 19 18:33:38 myhost hcid[1942]: Unable to get on D-Bus
> --- snip ---
> 
> Was there a dbus related change? Or is it due to a missing bluez-hcid.conf file
> (present in 3.7 but not in 3.10.1)?

the file is called bluetooth.conf now.

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
