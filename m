Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jonathan Paisley <jp-www@dcs.gla.ac.uk>
To: Rainer Jochem <rainer@graphics.cs.uni-sb.de>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <20030927113440.GA23684@graphics.cs.uni-sb.de>
Message-ID: <Pine.LNX.4.54.999.0309271358130.11280@sibu.dcs.gla.ac.uk>
References: <20030927113440.GA23684@graphics.cs.uni-sb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] Re: snd-bluez-sco
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 27 Sep 2003 13:58:49 +0100 (BST)

On Sat, 27 Sep 2003 1:34pm +0200, Rainer Jochem wrote:

> then I do:
> root@marvin:# bluezsco  xx:xx:xx:xx:xx:xx 6
> Error: control open (hw:2): No such device
> Error: Can't find device. Bail

This error is coming from the bluezsco tool, when it's trying to open
hwdep ALSA interface for the snd-bluez-sco driver.

It cycles through the ALSA devices (hw:0, hw:1, hw:2, etc) trying to
identify a device which has an hwdep interface of type
SND_HWDEP_IFACE_BLUEZ_SCO. The error you're seeing is the loop bailing
because it didn't find the device, and you only have ALSA device hw:0 and
hw:1 (presumably your real audio card and the snd-bluez-sco driver).

Perhaps you could try adding some debugging printf()s to the
find_hwdep_device() function to try to identify whether it is finding the
snd-bluez-sco device, and if so, what hwdep interface type it is
reporting.

I haven't yet tried the code against alsa 0.9.7, so it's possible there
may be some incompatabilities.

Thanks.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
