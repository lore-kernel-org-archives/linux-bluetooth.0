Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] questions about BT audio headset support...
Message-ID: <20040507141928.GA4058@gmx.net>
References: <409AD45D.6080102@dark-reality.de> <20040507113025.GA23044@gmx.net> <409B833B.8070203@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <409B833B.8070203@superbug.demon.co.uk>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 7 May 2004 16:19:28 +0200

On  0, James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
> Nicholas A. Preyss wrote:
> >In my opinion, the whole connection handling should be done in
> >user-space. In kernel-space only a generic "sco channel" - "alsa device" 
> >binding interface should stay. 
> 
> I think it might be worth trying to find out if one can get alsa-lib to 
> use a user-space device driver. Then everything will stay in user space 
> until it reaches the bluez code.

This means alot of rather useless kernelspace-userspace-kernelspace 
copying. Looking at Marcels hstest program, there is a quiet large lag,
i am not sure, how much you could reduce this with an optimized direct
alsa interface.

nicholas


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
