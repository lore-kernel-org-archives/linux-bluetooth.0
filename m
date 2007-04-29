Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 29 Apr 2007 18:07:48 +0400
From: John Frankish <frankish@dubai.oilfield.slb.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-id: <7.0.1.0.2.20070429173621.03b9d4e8@dubai.oilfield.slb.com>
MIME-version: 1.0
Subject: [Bluez-devel] Fwd: Re: Fwd: Re: Unable to set number of SCO
 buffers	: please upgrade your Kernel !
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Reiner,

Thanks for the "xhost +" suggestion - unfortunately it didn't help...

I pasted some details below in case it helps somebody suggest where I 
might be going wrong.

Regards
John

Case 1 - hcid.conf/security = user: Whether I use my phone or bt 
headset, with bluez-utils 3.9, hcid just sits there waiting for a pin 
pop-up that doesn't happen. I had this problem with bluez-utils 2.15 
but at least I could set a pin-helper to fashion a work-around.

# hcid -n [security=user - pin request via hcitool cc/auth 
00:0A:D9:E8:4A:65, xhost +]
hcid[2745]: Bluetooth HCI daemon
hcid[2745]: HCI dev 0 registered
hcid[2745]: HCI dev 0 already up
hcid[2745]: Device hci0 has been added
hcid[2745]: Starting security manager 0
hcid[2745]: Device hci0 has been activated
hcid[2745]: link_key_request (sba=00:10:C6:56:F4:9F, dba=00:0A:D9:E8:4A:65)
hcid[2745]: pin_code_request (sba=00:10:C6:56:F4:9F, dba=00:0A:D9:E8:4A:65)
[then nothing]

Case 2 - hcid.conf/security = auto: I can initiate a connection with 
my phone and pair my machine using the local pin in hcid.conf. Maybe 
I'm missing the logic here, but when my bt headset is put into 
pairing mode, shouldn't hcid recognise this and use the local pin in 
hcid? In practise, hcid sits there waiting for me to enter a pin on 
the bt headset which of course is not possible.

# hcid -n [security=auto, connection from phone]
hcid[2776]: Bluetooth HCI daemon
hcid[2776]: HCI dev 0 registered
hcid[2776]: HCI dev 0 already up
hcid[2776]: Device hci0 has been added
hcid[2776]: Starting security manager 0
hcid[2776]: Device hci0 has been activated
hcid[2776]: pin_code_request (sba=00:10:C6:56:F4:9F, dba=00:0A:D9:E8:4A:65)
hcid[2776]: link_key_notify (sba=00:10:C6:56:F4:9F, dba=00:0A:D9:E8:4A:65)
[paired OK]

# hcid -n [security=auto, headset in pairing mode]
hcid[7423]: Bluetooth HCI daemon
hcid[7423]: HCI dev 0 registered
hcid[7423]: HCI dev 0 already up
hcid[7423]: Device hci0 has been added
hcid[7423]: Starting security manager 0
hcid[7423]: Device hci0 has been activated

nothing happens, so then

# hcitool cc 00:12:EE:A6:1D:F4
# hcitool auth 00:12:EE:A6:1D:F4
HCI authentication request failed: Input/output error

hcid[7423]: link_key_request (sba=00:10:C6:56:F4:9F, dba=00:12:EE:A6:1D:F4)
hcid[7423]: pin_code_request (sba=00:10:C6:56:F4:9F, dba=00:12:EE:A6:1D:F4)


One thing I noticed with plugz and bluez-utils 2.15 is that when I 
try to play music to the headset, it automatically pairs (via the 
pin-helper I presume) but no music appears due to the sco buffers problem.

# mplayer -ao alsa:device=headset /.../music.mp3
...
alsa-init: 1 soundcard found, using: headset
ALSA lib pcm_sco.c:273:(sco_headset_hw_params) Unable to set number 
of SCO buffers : please upgrade your Kernel !
alsa-init: unable to set hw-parameters: Invalid argument
alsa-init: pcm prepare error: Input/output error
alsa: 8000 Hz/1 channels/2 bpf/768 bytes buffer/Signed 16 bit Little Endian
AO: [alsa] 8000Hz 1ch s16le (2 bytes per sample)
Building audio filter chain for 44100Hz/2ch/s16le -> 8000Hz/1ch/s16le...
Video: no video
Starting playback...[but no sound]


When I try this with plugz and bluez-utils 3.9, the initial 
connection is rejected but this is not echoed by hcid...

# mplayer -ao alsa:device=headset /.../music.mp3
...
Building audio filter chain for 44100Hz/2ch/s16le -> 0Hz/0ch/??...
alsa-init: 1 soundcard found, using: headset
ALSA lib pcm_sco.c:561:(_snd_pcm_sco_open) Socket connection returned 
Connection refused
alsa-init: playback open error: Connection refused
Could not open/initialize audio device -> no sound.
Audio: no sound
Video: no video

# hcid -n [security=auto, headset in pairing mode]
hcid[2776]: Bluetooth HCI daemon
hcid[2776]: HCI dev 0 registered
hcid[2776]: HCI dev 0 already up
hcid[2776]: Device hci0 has been added
hcid[2776]: Starting security manager 0
hcid[2776]: Device hci0 has been activated
[but no link_key/pin_code_request??]

------------------------

>Date: Sun, 29 Apr 2007 10:23:48 +0200
>From: Reiner Klenk <pdq808@t-online.de>
>Subject: Re: [Bluez-devel] Fwd: Re: Unable to set number of SCO buffers :
>         please upgrade your Kernel !
>Sender: bluez-devel-bounces@lists.sourceforge.net
>To: BlueZ development <bluez-devel@lists.sourceforge.net>
>Reply-to: BlueZ development <bluez-devel@lists.sourceforge.net>
>Message-id: <1177835028.16681.8.camel@grappa>
>Content-type: text/plain; charset=us-ascii
>Content-transfer-encoding: 7bit
>List-Post: <mailto:bluez-devel@lists.sourceforge.net>
>List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
>  <mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
>List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
>  <mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
>List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
>List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
>List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
>Original-recipient: rfc822;frankish@dubai.oilfield.slb.com
>
>On Sun, 2007-04-29 at 09:08 +0400, John Frankish wrote:
>
> > 2. I compiled bluez-libs/bluez-utils 3.9 to see if plugz would work
> > better with this - I ran into the same pin problem as before in that
> > I don't get a pin pop-up on my machine. If I set security to auto in
> > hcid.conf then I can pair with my cell phone since I can enter a pin
> > on the phone but this does not work with a bluetooth headset since I
> > cannot enter a pin and hcid just sits there waiting...
>I have seen something like this, where the problem appeared to be that
>the pin helper could not pop up its window due to authorization failure.
>If this is the case, it helps to "xhost +".
>
>Hth,
>Reiner
>--
>debb1046 (gmail, gtalk, jabber.org, ekiga.net, last.fm, skype)
>
>
>-------------------------------------------------------------------------
>This SF.net email is sponsored by DB2 Express
>Download DB2 Express C - the FREE version of DB2 express and take
>control of your XML. No limits. Just data. Click to get it now.
>http://sourceforge.net/powerbar/db2/
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
