Return-Path: <cyrus@holtmann.org>
Message-ID: <4796A192.8000308@aircable.net>
Date: Wed, 23 Jan 2008 00:08:18 -0200
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Bug in SDP example?
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

Hello guys,
I've been tracing a bug in part of Tadas work (obex-data-server), and I
finally found it, it was related to sdp records calls, the dbus
interface specifies to use array of byte, while he was using array of
int. So I replaced
DBUS_TYPE_G_UINT_ARRAY for DBUS_TYPE_G_UCHAR_ARRAY, and valgrind stopped
blaming about bugs.

Strange is that the example at this page:
http://wiki.bluez.org/wiki/HOWTO/DiscoveringServices

Seems to have exactly the same problem in the D-Bus glib example. The
D-Bus function call that has an error is this one:
dbus_g_proxy_call (adapter_proxy,
"GetRemoteServiceRecord", &error,
G_TYPE_STRING, address,
G_TYPE_UINT, *((guint32 *)handle_array->data),
G_TYPE_INVALID,
DBUS_TYPE_G_UINT_ARRAY, &record_array,
G_TYPE_INVALID)

I'm not 100% sure, but I've been through both hcid and sdpd sources from
the latest bluez libs and seems like I'm right. It should say:
DBUS_TYPE_G_UCHAR_ARRAY, &record_array,
Instead of:
DBUS_TYPE_G_UINT_ARRAY, &record_array,

Any of the gurus out there can confirm this? I don't want to fix the
example if it's all ready all right.

Thanks,
Manuel Naranjo
Wireless Cables Inc. www.aircable.net


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
