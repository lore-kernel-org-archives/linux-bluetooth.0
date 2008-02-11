Return-Path: <cyrus@holtmann.org>
Message-ID: <47AFA9A7.3030100@aircable.net>
Date: Sun, 10 Feb 2008 23:49:27 -0200
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] CreateBonding while periodic scanning
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

Hello List,

As I asked in the forums I'm trying to create a bonding to a device
while I'm running a periodic scanning.

Thing is that for some reason hcid is blocking me to do this, and Marcel
suggested removing the periodic inquiry check. But as he said, and I
think the same, that check was created for a reason.

The line that makes the conflict is this one (utils/hcid/adapter.c:

static DBusHandlerResult adapter_create_bonding(DBusConnection *conn,
                                                DBusMessage *msg, void
*data)
.....

if (adapter->discov_active || (adapter->pdiscov_active &&
!adapter->pinq_idle))
return error_discover_in_progress(conn, msg)

pinq_idle is 0 in my case, so then I get a discovery in progress exception.

Marcel suggested that I change the code to "if (adapter->discov_active
)" but still we would like to know what that check is made, so we can
get a better solution.

Thanks,
Manuel Naranjo
Wireless Cables Inc.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
