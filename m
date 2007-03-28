Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1175074119.5815.118.camel@violet>
References: <1175073408.15698.97.camel@cookie.hadess.net>
	<1175074119.5815.118.camel@violet>
Content-Type: multipart/mixed; boundary="=-Lzun0TnIe4tQqdaxHS3Q"
Date: Wed, 28 Mar 2007 10:56:06 +0100
Message-Id: <1175075766.15698.107.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hcid returning "Device or resource busy"?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-Lzun0TnIe4tQqdaxHS3Q
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2007-03-28 at 11:28 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > I've been wondering why my devices weren't showing up in
> > nautilus-sendto, and it looks like DiscoverDevices doesn't work. Here's
> > the snippet of code:
> > 
> >         dbus_g_proxy_call (object, "DiscoverDevices", &e,
> >                            G_TYPE_INVALID, G_TYPE_INVALID);
> >         if (e != NULL) {
> >                 g_warning ("Couldn't start discovery: %s: %s",
> >                            dbus_g_error_get_name (e), e->message);
> >                 g_error_free (e);
> >         }
> > 
> > I do a list ListBondings before that on the same object, so I know that
> > it works. But I still get that error:
> > Couldn't start discovery: org.bluez.Error.Failed: Device or resource busy
> 
> please run "hcidump -X -V" to see what happens on the HCI layer. Do you
> have running anything else at the same time.

Nope, not doing anything else, apart from having the applet running, let
me attach the hcidump output.

-- 
Bastien Nocera <hadess@hadess.net> 

--=-Lzun0TnIe4tQqdaxHS3Q
Content-Disposition: attachment; filename=hcidump-nst.log
Content-Type: text/x-log; name=hcidump-nst.log; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

HCI sniffer - Bluetooth packet analyzer ver 1.33
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:0D:93:19:8F:82 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
< HCI Command: Remote Name Request Cancel (0x01|0x001a) plen 6
    bdaddr 00:0D:93:19:8F:82
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request Cancel (0x01|0x001a) status 0x01 ncmd 1
    Error: Unknown HCI Command
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x0c ncmd 1
    Error: Command Disallowed

--=-Lzun0TnIe4tQqdaxHS3Q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-Lzun0TnIe4tQqdaxHS3Q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-Lzun0TnIe4tQqdaxHS3Q--
