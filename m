Return-Path: <cyrus@holtmann.org>
Message-ID: <493CE4E7.9090400@powercraft.nl>
Date: Mon, 08 Dec 2008 10:12:07 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <000401c95911$b1b22cd0$15168670$@de>
In-Reply-To: <000401c95911$b1b22cd0$15168670$@de>
Cc: 'Brad Midgley' <bmidgley@xmission.com>
Subject: Re: [Bluez-devel] SBC debugging takes place here
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Christian Hoene wrote:
> Hello,
> 
> we are trying to fix the SBC bugs here:
> http://github.com/hoene/bluez-sbc/tree/sbc.debugging
> Question? Meet me at Skype "christian.hoene"
> 
> Regards,
>   Christian

Hi Christian,

Thank you for your great initiative. I would like to follow the process
and do some possible testing, but I have a few questions.

Is your git tree a branch from the original one, was it not possible to
enhance the original branch? You could have made a new configuration
flag to enable and test your code for compilation. I have had very bad
experiences with developers taking out code from the mainstream and then
trying to fix it, it provided a lot of resistance when merging the code
back. It is highly advisable to keep the code at one place for
everybody. I am also not possible to test two different code sources..

I am also not possible to use the proprietary skype, it is not possible
to use two streams at once when using bluetooth speakers, and the alsa
compliance of the skype program is not there at all. Could you please
use IRC and the #bluez channel on chat.freenode.org?

Maybe an other bluez developer can help out Christian, with commit
access and code reviewing for the original git repository, so we don't
have to branch the code repositories to different places and development
styles...

There is a good book about how to produce open source software and can
possibly give some guidelines how to do some things, the book can be
found here: http://producingoss.com/

When I reply to all your email address is replaced to an reply header of
Brad Midgley is this correct?

Just some few comments, I thing your initiative is great!

Best regards,

Jelle de Jong

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
