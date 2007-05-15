Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Robert Huitl <bluez-devel@huitl.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Tue, 15 May 2007 02:00:43 +0200
References: <5b9417770705141014w20611f52v50526f928501803c@mail.gmail.com>
In-Reply-To: <5b9417770705141014w20611f52v50526f928501803c@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200705150200.43977.bluez-devel@huitl.de>
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

On Montag, 14. Mai 2007, John H. wrote:
> Motorola h700.

Jabra BT.620S here

> I have plugz installed, and the corresponding asound.conf from it.
>
> fc6 and headset paired.
>
> I tell new alpha skype 1.4 to use headset for in, out and ring(as
> headsetd is running)
>
> When i try test call, it says problem with audio playback?  However,
> the headset beeps at this time, so there's definitely some kind of
> communication.

I can confirm this problem with Skype 1.4 Build 58. I tried setting only one 
of the devices to use headsetd, but it works for neither playback nor 
capturing.

I noticed that Skype seems to probe all devices when I initiate a call, 
because headsetd establishes a connection even though all three (input, 
output, ringing) devices are set to "default" (i.e. the internal sound card).

> What to do?  Am I supposed to be using hijacker?

I tried to get headsetd working with other programs, for example arecord. This 
might point to a problem with headsetd not supporting the sample format Skype 
requests:

$ arecord -Dheadset-sco
Recording WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
arecord: set_params:900: Sample format non available

Trying a different sample format reminds me of a kernel patch you can find on 
this list. It is required for reliable SCO communication:

$ arecord -Dheadset-sco -f s16_le
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
ALSA lib pcm_sco.c:277:(sco_headset_hw_params) Unable to set number of SCO 
buffers : please upgrade your Kernel !
arecord: set_params:961: Unable to install hw params:
[...]

In both cases arecord fails to use the headsetd sound device.

So either
1) Skype tries to use a sample format that is not supported at all or
2) the sample format is okay but it fails because of the missing kernel patch
3) there's some other problem ;-)

You could try the patch to see if it helps.

Regards,
  Robert

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
