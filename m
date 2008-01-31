Return-Path: <cyrus@holtmann.org>
From: Guillaume Bedot <littletux@zarb.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <741609.62275.qm@web8404.mail.in.yahoo.com>
References: <741609.62275.qm@web8404.mail.in.yahoo.com>
Date: Thu, 31 Jan 2008 19:25:49 +0100
Message-Id: <1201803949.18849.7.camel@littletux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] trouble in headset connection
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


On jeu, 2008-01-31 at 17:16 +0530, pramod gurav wrote:
> hi
> thanks for reply
> yes i am trying to pair my system to BT headset and want to play audio
> on it thrugh BT.
> i am using bluez-libs-3.24, bluez-utils-3.24, bluez-hcidump-1.40
> 
> i am usind a broadcom BCM2035 dongle, Sony Erricson HBH-600 headset
> and 2.6.15 kernel..

There is a bug that was corrected in early January in cvs that affected
headset connections. You can try to compile the current cvs or wait
until 3.25 is released...

bt-sco and other tools from bluetooth-alsa are the old way-to-do, but
that can work better for you.

Regards,

Guillaume B.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
