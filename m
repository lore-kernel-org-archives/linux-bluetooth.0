Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050116230927.87008.qmail@web50202.mail.yahoo.com>
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
To: Fred Schaettgen <kde-bluetooth@schaettgen.de>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <200501162201.57611.kde-bluetooth@schaettgen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Re: [kde-bluetooth] Re: Re: How can I add a new bluetooth service ?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 16 Jan 2005 15:09:27 -0800 (PST)

Hi Fred,

I used the headset with a lot of alsa apps like
gnomemeeting, mplayer, aso, and non alsa apps thru the
oss emulation of alsa.
For gnomemeeting this is just fine because is also
intended for voice, but to listen to a movie on a 8KHz
mono headset is not so HiQ.
Anyway it realy works.
What I am trying to do is to connect it when I press
the button on headset and disconnect it when I press
the button again. So no need for special applet.
I think that will be nice to put some support for
btsco in kdebluetooth, but the right person to ask is
not me.
Maybe Brad or Lars can give more details of what is in
the future development for btsco.
I just modified btsco a bit to be able to use the
rfcomm connection accepted by kdebluetoothd and did
some other small changes to better fit my Jabra BT110.

Anyway, if I can help with something, just let me
know.

Thanks,
Paul


--- Fred Schaettgen <kde-bluetooth@schaettgen.de>
wrote:

> On Sunday 16 January 2005 10:27, you wrote:
> > --- Fred Schaettgen <kde-bluetooth@schaettgen.de>
> > wrote:
> > Hi Fred,
> >
> > Yes, I can press the headset button and
> kbluetoothd
> > will start a headset connection with btsco.
> 
> And I can use it with any alsa-capable application?
> 
> > btsco is from
> http://bluetooth-alsa.sourceforge.net/
> > and is a small proof of concept AG profile using
> > snd-bt-sco which is indeed an alsa bt driver.
> > So you can connect btsco to a headset but not to a
> > phone as it does not knows HS or HF profiles.
> 
> Ah, got it.. I thought btsco handles only the SCO
> connection, but this can 
> hardly work. Do you think it would make sense to
> integrate headset support 
> into kdebluetooth at this point?
> If it works already, the only thing that's missing
> is a little tray icon, 
> where the user can terminate the headset connection.
> Problem is snd-bt-sco 
> isn't shipped with the stock kernel. But on the
> other hand it could help 
> making snd-bt-sco more popular if we support it in
> kdebluetooth. What's you 
> opinion?


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
