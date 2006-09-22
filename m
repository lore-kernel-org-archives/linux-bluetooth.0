Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45139BBC.8050606@palmsource.com>
Date: Fri, 22 Sep 2006 10:15:56 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <m33bapwl0u.fsf@kurono.home>
	<450F208F.4080204@xmission.com>	<m34pv4ux3e.fsf@kurono.home>
	<m3venkt9uk.fsf@kurono.home>	<450FDFC9.6060804@palmsource.com>
	<m3eju8t4f2.fsf@kurono.home>	<m3ac4wt3qf.fsf@kurono.home>
	<450FEBAA.1060005@palmsource.com>	<m3venjsx1h.fsf@kurono.home>
	<m364fisp92.fsf@kurono.home>
In-Reply-To: <m364fisp92.fsf@kurono.home>
Subject: Re: [Bluez-users] a2play and btsco questions
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

Hi,
> It seems I can get the AVRCP commands to work "sometimes"(for some
> unknown definition of "sometimes"), so my headset appear to support
> it.
>
> so , current problems are:
> - I dont know how to make AVRCP commands work reliably, or how to
> debug it. I think maybe some command has to produce output to the
> a2dpd daemon for AVRCP commands to be received.
>   
A2DPD can run some commands to control a mediaplayer remotly.
Xmms provide such features. It is player dependent and can be customized 
in .a2dprc.

My old headset behave differently depending whether it was receiving 
sound or not :
When not receiving sound, it did not do AVRCP at all, but it tried to 
establish an A2DP connection. So the daemon received this incoming A2DP 
connection, close it and  launch the media player, wich in turn will 
make a new outgoing A2DP connection to the headset.

When playing, the headset will send normal AVRCP commands.

> - xmms output is really choppy, whereas mplayer output is ok.
> I tried fiddling about with xmms alsa settings, like mmap and buffer
> settings and whatnot, but no real breakthrough.
>   
Do you send 44100 Hz stereo? It's the only supported format. Other 
format need conversion.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
