Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <f68b8ee1050323043862bc4c6d@mail.gmail.com>
From: James Fitzsimons <james.fitzsimons@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco and Nokia HDW-3 headset not working
In-Reply-To: <42409B3B.1080906@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1111528750.12076.18.camel@localhost>
	 <42409B3B.1080906@xmission.com>
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
Date: Wed, 23 Mar 2005 12:38:06 +0000

Hi Brad, thanks for your reply.

On Tue, 22 Mar 2005 15:24:59 -0700, Brad Midgley <bmidgley@xmission.com> wrote:
> > athos root # sdptool search --bdaddr 00:03:89:67:8F:F7 0x1108
> 
> Do our docs still recommend this? The channel has been autodetected for
> some time.
Not sure sorry, I copied this from a howto on the gentoo forums.

> > athos root # btsco 00:03:89:67:8F:F7 1
> > Device is 2:0
> > Voice setting: 0x0060
> > RFCOMM channel 1 connected
> 
> This is not the latest cvs version. It's silent unless you specify "-v"
> flag. Where did you get the kernel module and btsco daemon you are trying?
That may be the case, I built this a few weeks ago. I will update
tonight. I am using an ebuild produced by someone in the gentoo
community, however I am pretty sure it gets the kernel modules and
btsco daemon source from cvs. I will check this and rebuild to see if
that helps.

> It would really be a lot easier to debug if you were using the most
> recent kernel release (we don't have enough resources to maintiain
> several versions for what is supposed to be a stable kernel series)
I understand, however as I am running an amd64 machine I prefer to use
the gentoo sources as they have some amd64 specific patches applied.
 
> Make sure you are using the integrated alsa, not the standalone that is
> distributed separately. 
I am definately using the intergrated alsa.

>IIRC, this came up because gentoo uses the
> standalone alsa.
Actually I don't think this is the case any longer.

Thanks again,
James


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
