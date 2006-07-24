Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060724155621.02cd5e11@localhost.localdomain>
References: <44BE5DB3.7090406@gmail.com>
	<1153356539.4094.9.camel@aeonflux.holtmann.net>
	<2172AACE-61A5-4D43-90E2-059D659D8830@infitsrl.com>
	<20060724103824.1ff98fa6@McGee-XPC> <44C4CC37.1060308@infitsrl.com>
	<20060724155621.02cd5e11@localhost.localdomain>
Date: Mon, 24 Jul 2006 18:35:12 +0200
Message-Id: <1153758912.25058.3.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] It's rfcomm connect problem
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Andreas,

> thank your for that information. I guess your problem is just the same
> you had with sdp some while ago. A single BT Device can not *start*
> connecting to two different remote devices at the same time. 
> 
> To solve this you have to find a way to:
> 
> 1. Create Connection to device A 
> 2. Wait until Connect Complete for A's bdaddr happens (no matter if failed or succ.)
> 3. Then continue with other Create Connection Commands

we have a plan to make the L2CAP layer handle multiple ACL connects and
try again if one attempt fails. However the last patch I wrote for it
got lost somehow and it was broken anyway. The mailing list should
contain a thread where I proposed how this must be handled. I don't have
time to look at it at the moment. So if anybody wants to work on it,
please do so and send in a patch.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
