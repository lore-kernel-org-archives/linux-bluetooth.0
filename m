Return-Path: <cyrus@holtmann.org>
Message-ID: <479D1EFB.9020005@gmail.com>
Date: Mon, 28 Jan 2008 10:16:59 +1000
From: Eugene <it.had.even@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <200801242256.33910.sa@claborn.net>
In-Reply-To: <200801242256.33910.sa@claborn.net>
Content-Type: multipart/mixed; boundary="------------080907040402000003010105"
Subject: Re: [Bluez-users] How to setup a headset as an audio device?
 Getting "Device busy" errors
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080907040402000003010105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

SA ?????:
> Hello,
>
> My boss has just purchased a "Jawbone" bluetooth headset (cell phone type) 
> that he wants to hook up to his computer to use like skype.
>
> I found instructions for old btsco first, and plugz. I saw that btsco was 
> outdated but I tried plugz and sbc first.
>
> Then I saw on http://wiki.bluez.org/wiki/HOWTO/AudioDevices the following:
>
> "Note: you will not need bluetooth-alsa, plugz, btsco or the like for audio to 
> work. They are obsolete. "
>
> The steps there are listed as
>
> 1. Make sure the audio service is installed and enabled 
> (file /etc/bluetooth/audio.service should exist)
>
> 2. modify your ~/.asoundrc to contain
>
> pcm.bluetooth {
>    type bluetooth
>    device 00:11:22:33:44:55
> }
> 3. configure your audio application to use the alsa device "bluetooth". See 
> Supported Players 
> http://wiki.bluez.org/wiki/HOWTO/AudioDevices#SupportedPlayers for some 
> examples.
> 4. start playing :) 
>
> Which is wonderfully simple, but it did not work for me. I also tried it on my 
> own computer. Both computers have OpenSuSE 10.3. I used the KDE bluetooth 
> manager to pair the devices. It shows up correctly in "hcitool scan"
>
> The correct Bluetooth address is 00:0D:3C:6F:0E:89, so I tried this on both 
> computers (for the remainder of this email I will focus on my own computer - 
> once I get it working here I can make it work on my boss's laptop too)
>
> Here's my /etc/bluetooth/audio.service:
> [Bluetooth Service]
> Identifier=audio
> Name=Audio service
> Description=Bluetooth Audio service
>
>
> Here's my ~/.asoundrc:
> pcm.bluetooth {
>    type bluetooth
>    device 00:0D:3C:6F:0E:89
> }
>
> I have the following bluez packages installed:
>
> bluez-utils-3.18-12
> bluez-libs-3.18-5
>
>
> When I try to configure any of the players as recommended by the page 
> http://wiki.bluez.org/wiki/HOWTO/AudioDevices#SupportedPlayers the best 
> response I get is "Device Busy" from amarok and Kaffiene (xine engine) like 
> this:
>
> "Audio output unavailable; the device is busy.
> xine parameters: "
>
> MPlayer, when I try to run the suggested command 
> "mplayer -ao alsa:device=bluetooth"
> prints out the options/argument list as though I'm using an incorrect command.
>
> I can't configure audacious at all, under Audio the "Current output plugin" 
> has no option to select, and all the other preferences are grayed out too.
>
> Can anyone tell me what I need to do to make this work?
>
> Thanks,
>
> 	JW
>
>   
Hello,
try to
aplay -v -D bluetooth './your-sound.wav'
and send its output. Else, did you started bluetooth audio service?
To check, use:
ps ax | grep bluetoothd-service-audio

Regards,
Eugene


--------------080907040402000003010105
Content-Type: text/x-vcard; charset=utf-8;
 name="it_had_even.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="it_had_even.vcf"

begin:vcard
fn:Eugene
n:;Eugene
version:2.1
end:vcard


--------------080907040402000003010105
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------080907040402000003010105
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------080907040402000003010105--
