Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d66c3bdf0612020340r4b44e500i1a6c6ad6917875b7@mail.gmail.com>
Date: Sat, 2 Dec 2006 03:40:21 -0800
From: "Uichin (Eugene) Lee" <netssenger@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] data fragment
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

Hi All,

I have an urgent question. I'm sending a 2300B packet from one machine
to another machine through L2CAP. I used hcidump to see the
fragmentation in L2CAP.

I looked at the kernel code, and realized that L2CAP uses "ACL_MTU" to
do the fragmentation. hcidump at the sender side shows that

< ACL data: handle 1 flags 0x01 dlen: 120

However, hcidump at the receiver side shows like this:

> ACL data: handle 42 flags 0x01 dlen: 224
=> 10 times +
> ACL data: handle 42 flags 0x01 dlen: 64

Total 2304 (2300B payload + 4 bytes - CID/Length)

What's happening here? At the lower layer (i.e., LMP), pack those
packets and then create another ACL packet with length 224 (the size
of  DM5 packet). It seems like LMP packs uppper level data packets
into current baseband packet format. Is that true?

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
