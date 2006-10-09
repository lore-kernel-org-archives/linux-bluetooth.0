Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
In-Reply-To: <452A2B45.5090200@palmsource.com>
References: <1160327171.13162.16.camel@grappa.nowhere.de>
	<452A2B45.5090200@palmsource.com>
Date: Mon, 09 Oct 2006 17:01:17 +0200
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
From: "pdq808@t-online.de" <pdq808@t-online.de>
Message-ID: <1GWwd3-0XrDMG0@fwd35.aul.t-online.de>
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


-----Original Message-----
Date: Mon, 09 Oct 2006 12:58:13 +0200
Subject: Re: [Bluez-devel] a2dpd not executing commands
From: Frederic DALLEAU <frederic.dalleau@palmsource.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>

Hi,
in fact the parsing of the command is very bad you should use only one 
cmd and one parameter with exactly one space separating them ...
so you command should be run but with only the first param
what exactly is your cmd like?
Fred

I am sure it is not a parsing problem. At first I had entered some dcop
calls but
then realized that can't work because they need more than one parameter.
I then
used the xmms commands exactly as given in the sample. When that didn't
work
I put a command directly into the program, using strings:
i = execlp("xmms", "xmms", NULL) 
this should have launched xmms but it didn't.
 
I was wondering whether there might be any security features compiled
into the
dapper kernel which prevent replacing the forked child process in that
particular case. 
Another reason might be that the environment which is passed from a2dpd
to
the replacement process is somehow invalid.

When I comment out the sigaction 
which you included to get rid of zombies I see one a2dpd zombie per
button press. Is that correct or should I see an xmms zombie?
 
One more thing: I use plug:pcm.headphone in my amarok configuration.
When used with the "old" plugin this seems to take care of sample rate
and mono/stereo conversion when listening to a podcast. With a2dpd I get
little chunks played back at the wrong pitch with pauses inbetween.
These findings are somewhat preliminary (i.e. late at night testing,
hehe), I'll investigate further.

Thanks for your input,
Reiner

Reiner Klenk wrote:
> Greetings,
> I've been playing with my new Jabra BT620s over the weekend and things
> were going quite well. I can have it connected to a2dpd (amarok) and
> btsco (ekiga) at the same time. Here's something I don't understand:
> pressing one of the keys on the headphone does nothing. I inserted a
> couple of printf in a2dp_ipc.c and could verify that the commands are
> indeed received and a child is forked. The execlp call is not
returning
> (as it should), nevertheless the specified command doesn't seem to get
> executed. I've double-checked my .a2dprc entries and verified that -
run
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
Join SourceForge.net's Techsay panel and you'll get the chance to share
your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
