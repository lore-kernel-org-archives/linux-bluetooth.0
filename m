Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Mr Jie Liu <s4048156@student.uq.edu.au>
To: bluez-users@lists.sourceforge.net
Message-ID: <1858c9181d18.181d181858c9@uq.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] permission denied
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 13 May 2004 19:59:08 +1000

I am trying to send audio files to my HBH-35 headset. But I found a problem with using bluez. When I try to send packets to the headset,like l2ping x:x:x:x, it works fine. After I use hciconfig or hcitool to do any operation about the headset,including just "hcitool info x:x:x:x", I can't connect with the headset again unless I restart my computer. I always got a error message:"permission denied". But I am running l2ping as root. Sometimes i
f I restart the hci interface by "hcitool down" and "hcitool up", it works again. But sometimes it just refueses to work anymore. Here is the hcidump when it stopes to work:
[root@tom cuanyu]# l2ping 00:0E:07:31:5C:5B
Ping: 00:0E:07:31:5C:5B from 00:0B:0D:21:9E:81 (data size 20) ...
Recv failed: Permission denied
[root@tom sbin]# ./hcidump -r=bt.txt
HCIDump - HCI packet analyzer ver 1.5
< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Link Key Request(0x17) plen 6
< HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
> HCI Event: Command Complete(0x0e) plen 10
> HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
< ACL data: handle 0x0001 flags 0x02 dlen 28
    L2CAP(s): Echo req: dlen 20
> HCI Event: Command Complete(0x0e) plen 6
> HCI Event: Disconn Complete(0x05) plen 4





-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
