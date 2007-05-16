Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <5b9417770705151926i669b708fw295afd90fbc52855@mail.gmail.com>
Date: Tue, 15 May 2007 21:26:44 -0500
From: "John H." <mistamaila@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200705160221.27516.bluez-devel@huitl.de>
MIME-Version: 1.0
References: <5b9417770705141014w20611f52v50526f928501803c@mail.gmail.com>
	<200705152222.11641.bluez-devel@huitl.de>
	<200705152220.58038.chick@computergeek.freeserve.co.uk>
	<200705160221.27516.bluez-devel@huitl.de>
Subject: Re: [Bluez-devel] skype and bluetooth
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
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Did you have to use the kernel patch?  I am trying to get h700 working
with skype without patching kernel.


On 5/15/07, Robert Huitl <bluez-devel@huitl.de> wrote:
> On Dienstag, 15. Mai 2007, you wrote:
> > On Tuesday 15 May 2007 21:22, Robert Huitl wrote:
> > > Okay after some debugging I know what the problem is.
> > > 2.) Offering more sampling rates than 8 kHz would be nice to have, but
> > > I'm not familiar with the design philosophies around ALSA. It's probably
> > > not a good idea to implement resampling in each and every sound plugin
> > > like pcm_sco. Does ALSA have some resampling facilities that can be
> > > plugged in between an application and a plugin? Maybe some magic lines in
> > > .asoundrc?
> >
> > I do this with a2dp, I'm sure the same could apply to sco.
> > I use an .asoundrc file which looks like this:
>
> Thanks a lot for this configuration. I got Skype running with it, even though
> it's freezing almost always when I call the echo test service (and both input
> and output are set to headset-sco-resample). But in a few cases it actually
> worked very nicely.
>
> However, if only input _or_ output is set to the headset device, it's quite
> stable. So recording is fine, playback is fine, but both of them at a time
> freeze Skype.
>
> For reference, this is my .asoundrc:
>
> pcm.headset-sco-resample {
>         type plug
>         slave {
>                 pcm "headset-sco"
>                 rate 8000
>                 format S16_LE
>                 channels 1
>         }
> }
> pcm.headset-sco {
>         @args [BDADDR TIMEOUT]
>         @args.BDADDR {
>                 type string
>                 default "xx:xx:xx:xx:xx:xx" # Put your HS address here
>         }
>         @args.TIMEOUT {
>                 type integer
>                 default 6000
>         }
>         type        sco
>         bdaddr      $BDADDR
>         timeout     $TIMEOUT
> }
>
> Might be some problem with ALSA, though.
>
> Regards,
>   Robert
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
