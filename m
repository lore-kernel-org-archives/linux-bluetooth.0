Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43EEAEF0.209@blueyonder.co.uk>
From: Sid Boyce <sboyce@blueyonder.co.uk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <43CF16E5.1020406@blueyonder.co.uk>
In-Reply-To: <43CF16E5.1020406@blueyonder.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Re: No audio with Nokia HDW-3
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 12 Feb 2006 03:43:44 +0000

The problem is with the Broadcom chipset. I've now bought a new "Fresh" 
dongle with the CSR chipset and audio is now OK, even works with Skype.
Regards
Sid.

Sid Boyce wrote:
> I've been battling with the HDW-3 since 2.6.15 on SuSE 10.0 x86_64, the 
> device is recognised.
> # hciconfig hci0 voice 0x0060
> # btsco -v 00:03:89:60:F9:CF
> btsco v0.41
> Device is 1:0
> Voice setting: 0x0060
> RFCOMM channel 1 connected
> speaker volume: 7 mic volume: 15
> i/o needed: connecting sco...
> connected SCO channel
> Done setting sco fd
> recieved AT+VGS=07
> Sending up speaker change 7
> speaker volume: 7 mic volume: 15
> driver is not in use
> disconnected SCO channel
> speaker volume: 7 mic volume: 15
> i/o needed: connecting sco...
> connected SCO channel
> Done setting sco fd
> recieved AT+VGS=07
> Sending up speaker change 7
> speaker volume: 7 mic volume: 15
> driver is not in use
> disconnected SCO channel
> speaker volume: 7 mic volume: 15
> speaker volume: 7 mic volume: 15
> recieved AT+CKPD=200
> 
> Modules
> =======
> sco 15240 0
> snd_bt_sco 15232 0
> snd_hwdep 11144 2 snd_usb_audio,snd_bt_sco
> bluetooth 51236 8 sco,rfcomm,l2cap,hci_usb
> snd_pcm 95116 5 
> snd_usb_audio,snd_bt_sco,snd_pcm_oss,snd_via82xx,snd_ac97_codec
> snd_page_alloc 11408 3 snd_bt_sco,snd_via82xx,snd_pcm
> snd 62016 15 
> snd_usb_audio,snd_bt_sco,snd_hwdep,snd_pcm_oss,snd_mixer_oss,snd_seq,snd_via82xx,snd_ac97_co 
> 
> dec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
> 
> crw------- 1 boycie audio 14, 3 2006-01-16 14:31 /dev/dsp
> crw-rw---- 1 boycie audio 14, 19 2006-01-16 15:35 /dev/dsp1 (HDW-3)
> 
>  From "ps fax"
> 20343 ?        Ss     0:00 /usr/bin/hidd --server
> 20331 ?        Ss     0:00 hcid: processing events
> 
> 
> I get no recording or playback. Skype sound device problem report and on 
> wengophone test, no audio.
> # arecord -D hw:1,0 -r 8000 -c 1 -f S16_LE | aplay -
> # arecord -D hw:1,0 -r 8000 -c 1 -f S16_LE ZZZ.wav
> # aplay -D hw:1,0 /XXX.wav (pre-recorded with plugin mic)
> 
>  From /var/log/messages
> ------------------------
> snd-bt-sco revision 1.6 $
> snd-bt-sco: snd-bt-scod thread starting
> Bluetooth: L2CAP ver 2.8
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: RFCOMM socket layer initialized
> Bluetooth: RFCOMM TTY layer initialized
> Bluetooth: RFCOMM ver 1.6
> snd-bt-sco: capture_open
> snd-bt-sco: playback_open
> snd-bt-sco: capture_open
> snd-bt-sco: playback_open
> Bluetooth: SCO (Voice Link) ver 0.5
> Bluetooth: SCO socket layer initialized
> snd-bt-sco: capture_open
> snd-bt-sco: playback_open
> snd-bt-sco: capture_open
> snd-bt-sco: playback_open
> snd-bt-sco: capture_open
> snd-bt-sco: playback_open
> snd-bt-sco: capture_open
> snd-bt-sco: playback_open
> snd-bt-sco: capture_open
> snd-bt-sco: playback_open
> snd-bt-sco: Disposing of previous socket count 2
> 
> Looks like it should work but it doesn't, qamix doesn't display any 
> mixer controls for the HDW-3.
> 
> # arecord -D plughw:Headset -f S16_LE|aplay -
> Recording WAVE 'stdout' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
> Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
> arecord: pcm_read:1263: read error: Input/output error
> 
> I also tried with a2play.
> Any ideas welcomed.
> Regards
> Sid.


-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Retired IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support 
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
