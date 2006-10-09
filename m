Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <452A2B45.5090200@palmsource.com>
Date: Mon, 09 Oct 2006 12:58:13 +0200
From: Frederic DALLEAU <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <1160327171.13162.16.camel@grappa.nowhere.de>
In-Reply-To: <1160327171.13162.16.camel@grappa.nowhere.de>
Subject: Re: [Bluez-devel] a2dpd not executing commands
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

Hi,
in fact the parsing of the command is very bad you should use only one 
cmd and one parameter with exactly one space separating them ...
so you command should be run but with only the first param
what exactly is your cmd like?
Fred

Reiner Klenk wrote:
> Greetings,
> I've been playing with my new Jabra BT620s over the weekend and things
> were going quite well. I can have it connected to a2dpd (amarok) and
> btsco (ekiga) at the same time. Here's something I don't understand:
> pressing one of the keys on the headphone does nothing. I inserted a
> couple of printf in a2dp_ipc.c and could verify that the commands are
> indeed received and a child is forked. The execlp call is not returning
> (as it should), nevertheless the specified command doesn't seem to get
> executed. I've double-checked my .a2dprc entries and verified that - run
> from a shell - they behave as expected. I put system(cmd); exit(0);
> instead of the execlp call and the buttons started to work. 
>
> Any idea why the execlp doesn't work? I'm on Ubuntu Dapper AMD64.
>
> Thanks,
> Reiner
>  
>   


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
