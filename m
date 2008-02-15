Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Feb 2008 08:29:34 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <279946.95245.qm@web8404.mail.in.yahoo.com>
Message-ID: <alpine.LNX.1.00.0802150353420.19485@nge2.ngu.pk>
References: <279946.95245.qm@web8404.mail.in.yahoo.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Headset not playing audio HELP PLEASE
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


On Fri, 15 Feb 2008, pramod gurav wrote:

-> will you please send me the conf files So that I can rectify mines.

Your configs look OK, but if you want them:

wget --no-check-certificate https://atr2.ath.cx/~jayjwa/download/bt-configs.zip
or
curl -O -v -k https://atr2.ath.cx/~jayjwa/download/bt-configs.zip


-> Also I want to tell you that I have installed bt-sco but later on I read somewhere that this is older method to do. Is it write?
-> So I stoped there. Can I try btsco way?
-> But i dont have module snd_bt_sco.
-> please enlighten me on btsco .

It's old and probably obsolete. It might not even be possible to use it 
without installing old bluez libs/utilz and an old (possibly insecure) kernel. 
Even doing all that work, there's no garentee that it will work any better. 
You might still hit the same issue. I'd stay current, and make sure to see the 
link in my last-to-this post about sco mtu.

There's only so many configuration options you can try, and by now you've 
tried just about all of them. At this point, you may be looking at an 
incompatibility in one or both of your hardware components, or a bug in 
either/both. That's why it would be helpful if you could try other hardware, 
or try to find accounts of someone getting a working example using your 
hardware on a similar setup. Then you could say either way if it's really a 
hardware issue or not. Could be that it's not, but in searching for the cause 
of an error/reason something's not working, it's one of the things you have to 
consider. Because if it is the case, then no amount of config changes or 
updates will help.

By what you've posted, it looks correct and should be working, only it isn't. 
The fact sound does work one way and not the other is very odd too. If it was 
a config error, seems like neither would work.




-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
