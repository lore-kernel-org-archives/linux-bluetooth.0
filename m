Return-Path: <cyrus@holtmann.org>
Message-ID: <47CE30CF.2080405@srijan.in>
Date: Wed, 05 Mar 2008 11:04:07 +0530
From: Chetan Thapliyal <chetan@srijan.in>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] pand[6444] protocol error(71)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

I am trying to connect my ubuntu laptop with my windows desktop that has 
a bluetooth dongle using `pand` when I am getting the below mentioned 
error. The following  is the way  I am proceeding.

$ hcitool scan
Scanning ...
        00:06:C9:90:02:1D       BLACK
$
$ sudo l2ping 00:06:C9:90:02:1D
Ping: 00:06:C9:90:02:1D from 00:1A:6B:20:29:A5 (data size 44) ...
44 bytes from 00:06:C9:90:02:1D id 0 time 32.96ms
44 bytes from 00:06:C9:90:02:1D id 1 time 9.08ms
44 bytes from 00:06:C9:90:02:1D id 2 time 27.08ms
3 sent, 3 received, 0% loss
$
$ pand --connect 00:06:C9:90:02:1D

The following are the details of the messages I am getting in `syslog`.

Mar  5 11:00:27 localhost pand[8103]: Bluetooth PAN daemon version 3.9
Mar  5 11:00:27 localhost pand[8103]: Connecting to 00:06:C9:90:02:1D
Mar  5 11:00:30 localhost hcid[6376]: link_key_request 
(sba=00:1A:6B:20:29:A5, dba=00:06:C9:90:02:1D)
Mar  5 11:00:30 localhost pand[8103]: Connect to 00:06:C9:90:02:1D 
failed. Protocol error(71)

I searched a lot on google for this but didn't get any solution. As a 
result any help in this regard would be highly appreciable.

Regards,
Chetan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
