Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d66c3bdf0611260122j7ed7ca07lec61326f8432f9a3@mail.gmail.com>
Date: Sun, 26 Nov 2006 01:22:22 -0800
From: "Uichin (Eugene) Lee" <netssenger@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] l2cap connection timeout
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Dear All,

I just realized from the spec that BT has C-Plane (for device control
service, i.e., HCI functions) and U-Plane (transport control and data
services, etc.). I thought I could use HCI functions not only for
device discovery, but also for connection and data transfer instead of
using L2CAP. But according to this, although we can create a
connection through hci_create_connection(), this connection can't be
used for data transfer, thus useless. (is it true?)

When we call L2CAP connection, it does in fact just create a L2CAP
connection request message and send it via hci_send_acl() to the lower
layer (i.e., LMP??). BlueZ kernel simply manages this L2CAP connection
information as far as I understand correctly.

When I try to connect to a remote device after inquiry step, how can I
choose a RIGHT timeout value to the remote device? I tried various
values from 1s to 5s: sometimes, it works well with 2s, but sometimes
it doesn't. Spec. talks about SR mode, R0 (<1.28s), R1(<1.28s),
R2(<2.56s) for page scan and thus accordingly, page for asynchronous
link should be N_page>1, >128, >256 respectively. Will it be pretty
much the same as the inquiry procedure, or should it be faster than
that since we've already got the clock offset from inquiry?

Thank you.

-- 
Uichin (Eugene) Lee
Ph.D. Student UCLA CS Dept.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
