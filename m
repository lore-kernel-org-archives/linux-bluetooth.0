Return-Path: <cyrus@holtmann.org>
From: christopher reder <creder@digitalcpt.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300712260703n6c0ca1b6h66d212f9dcd36377@mail.gmail.com>
References: <1198681112.4336.1.camel@linuxserver.digital>
	<d89ddf300712260703n6c0ca1b6h66d212f9dcd36377@mail.gmail.com>
Date: Wed, 26 Dec 2007 09:45:03 -0600
Message-Id: <1198683903.3637.1.camel@linuxserver.digital>
Mime-Version: 1.0
Subject: Re: [Bluez-users] installed bluez, can't use regular sound now!
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

On Wed, 2007-12-26 at 08:03 -0700, Brad Midgley wrote:
> Christopher
> 
> check /etc/asound.conf and ~/.asoundrc
> 
> Brad
> 
> On Dec 26, 2007 7:58 AM, christopher reder <creder@digitalcpt.com> wrote:
> > Hi all.  After trying to get Bluez working on my debian linux pc
> > (2.18.5), I would like to go back to using the regular sound card in the
> > computer but it is not working!  I am not sure where to check so that it
> > will point to the hardware and not to the bluez stack.  I've searched
> > for a asound or alsa.conf file, but haven't found anything that looks
> > like it is pointing to one or the other.
> >
> > Can someone tell me where I need to look to have the onboard hardware
> > work?
> >
> > Thanks
> >
> >

Brad - Thanks.  I checked and before I sent the email, I removed
the .asoundrc file which had a pcm.bluetooth reference and there wasn't
a /etc/asound.conf file.  Then, i restarted.  Nothing changed.  I also
tried, while the computer was up, by reloading alsa but haven't seen any
help there.   I also tried using mplayer with the 'mplayer -ao
alsa:device=hw=0.0 file.mp3 and 0.1 file.mp3 without success.  Is there
anything else or should I remove and reinstall alsa in the hopes that
may help?


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
