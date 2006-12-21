Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <458A2914.1060800@idlum.be>
Date: Thu, 21 Dec 2006 07:26:28 +0100
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45896C24.2070106@pracucci.com> <1166631806.17802.10.camel@violet>
In-Reply-To: <1166631806.17802.10.camel@violet>
Subject: Re: [Bluez-devel] Inquiry cache management (clock offset)
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

Hi Marcel,

> the main disadvantage is that it gives you nothing. You can't move the
> clock offset around from adapter A to adapter B. As the word says, it is
> a clock _offset_ and this means it depends on the local clock on the
> chip. So a received clock offset on adapter A is invalid on adapter B
> and it might happen that the connection establishment takes longer than
> if you would have used no clock offset at all.

And what about computing the clock offset between local adapters, and 
then based on this information compute the proper clock offset with the 
remote device for the adapter actually used to connect it?

Regards,
Pierre-Yves

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
