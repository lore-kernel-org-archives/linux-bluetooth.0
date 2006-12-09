Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 9 Dec 2006 09:29:37 +0800
From: amateur <ztl.post@gmail.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20061209012937.GA3119@163.com>
References: <969792183@web.de>
MIME-Version: 1.0
In-Reply-To: <969792183@web.de>
Subject: Re: [Bluez-users] latency problems
Reply-To: amateur <ztl.post@gmail.com>,
        BlueZ users <bluez-users@lists.sourceforge.net>
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

On Fri, Dec 08, 2006 at 01:47:15PM +0100, Christian Gebhard wrote:
> Good Afternoon
> 
> I have some problems concerning my round trip time using l2ping. I have two PCs(kernel 2.6.17) each with a Bluegiga WT11 module connected via USB. When I use l2ping the round trip time is between 14ms and up to sometimes 65ms. I also wrote  two programs that send and return numbers and count the time between sending and receiving a number. Here the times are similar. However when I reduce the time between the pings the round trip time is a bit shorter.
> 
> My questions:
>    - are these times normal (average of 20ms)?
>    - are the "extremely" varying times normal? 
>    - are the times dependent to the power management of the BT-module
> 

I can not give any help unless you give the output of  hcidump -x -V 
It sounds like that some retransmissions occured.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
