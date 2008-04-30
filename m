Return-Path: <cyrus@holtmann.org>
Message-ID: <4818E1B3.6000900@powercraft.nl>
Date: Wed, 30 Apr 2008 23:16:35 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <48171A58.8060200@powercraft.nl> <4817DAE3.6050406@gmail.com>
	<d89ddf300804291959m6589b95fse31e8227c37c8f1f@mail.gmail.com>
In-Reply-To: <d89ddf300804291959m6589b95fse31e8227c37c8f1f@mail.gmail.com>
Subject: Re: [Bluez-users] step by step - how to get your bluetooth stereo
 headset fully working with the bluez software stack under linux
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

Motorola Bluetooth DJ Headphones S805

Some basic things I encountered:

First to say I have tested all my devices, all at the same time on 
Windows XP SP2 with the Toshiba bluetooth system, and everything was 
working perfectly, all out of the box, including full headset controls. 
But it's not GPL so not really useful, but it gives a prove of concepts.

Feedback directly bluez related:

I got some kind of bandwidth issue with bluez. When I use my bluetooth 
headset and mouse at the same time, the audio gets interrupted. Both 
devices are master connections, if the headset is connected as slave, 
the connection is totally unusable, every other bluetooth event will 
make the audio stop in this case.
- So how can we fix the bandwidth priority/distribution system with bluez?

When I play audio from a dvd, there is a little glitch in some of the 
audio frequency's, I think there is an issue with the sbc codec it 
appears only in some audio frequency circumstances.
- Can we create a freq spectrum sweep to test the sdc codec on some 
glitches?

When playing audio, it gets buffered, and when you hit the pause key the 
media should stop directly. The buffer is also a source for some major 
audio video synchronization issues that I have encountered. hitting 
pause and play resets the buffer, but it keeps getting out of sync after 
some time.
- Can we remove the buffer and only create a fifo buffer for the 
bluetooth transmission system. Just sent date into the fifo, so 
guarantee a steady audio bitrate, without buffering and synchronisation 
issues. (under Windows everything stops and plays directly and stays in 
sync even video with audio)

I can't get two audio streams to mix and play at the same time on one 
bluetooth device.
- Can we get support for multiple audio streams mixing together for the 
same bluetooth device?

Probably not bluez related, but bluez can address the following issues:

I have tested xine- and gstreamer- based systems and different audio 
players like mpg123 ogg123 mplayer.
There was only ONE system that gave stable usable results when playing 
audio: The gstreamer backend with totem frontend wins.

ogg123 gives lots of distortions
- Can somebody please test ogg123 with alsa and bluetooth

mpg123 does sometimes work and sometimes is does not, pausing and 
resuming resets most audio distortions, but it is not >80% stable so not 
usable.

I recompiled the lateset mplayer svn to test dvd navigation, there are 
loads of issues:
-- very high cpu load of 85% when playing mp3 (also with repo version)
-- no usable dvd navigation, buttons do not work correctly, there are 
big blocks instead of usable buttons.

Video and audio: here are some major issues:
I am unable to get video and audio working correctly with xine or 
gstreamer with totem frontend or mplayer or xine-ui.

xine is the worst, it crashes and freezes, has distortions and 
synchronization issues. However xine is the only system that do play dvd 
navigation, so for me this is an major killer issue.
Gstreamer has the best responsiveness and gives the idea of a short fifo 
and audio buffers implementation, it is usable synchronised. But is has 
no dvd navigation and is missing some codecs for some evil bad video 
formats.

Conclusion:
- Bluetooth headset does not work 100% as it does with that other 
operating system that we don't want to use.
- Major killer synchronisation, buffer, bandwidth sharing and codec issues.

Plan of Attack:
... please fill in you ideas ...

Kind regards,

Jelle

-- -- -- -- --

echo 'pcm.headset {
     type bluetooth
     device 00:0C:55:D1:C9:78
     profile hifi
     #profile voice
     #profile auto
}
pcm.softvol {
     type softvol
     slave.pcm headset
     control.name Headset
     control.card 0
}
pcm.!default {
     type plug
     slave.pcm softvol
}' | tee $HOME/.asoundrc

cat $HOME/.asoundrc

sudo /etc/init.d/alsa-utils restart

echo 'options {
     autoinit yes;
     pairing multi;
     offmode devdown;
     passkey "0000";
     security auto;
}
device {
     name "[%h] / BT Device %d";
     class 0x000100;
     iscan enable;
     pscan enable;
     lm accept;
     lp rswitch,hold,sniff,park;
}' | sudo tee /etc/bluetooth/hcid.conf

cat /etc/bluetooth/hcid.conf

sudo /etc/init.d/bluetooth restart

sudo /etc/init.d/sysklogd start
sudo /etc/init.d/klogd start
sudo /etc/init.d/bluetooth restart
sudo /etc/init.d/alsa-utils restart
sudo python $HOME/simple-agent

sudo tail --lines=100 --follow /var/log/syslog

sudo modprobe uinput

-- -- -- -- --

arecord -D bluetooth -f S16_LE | aplay -D bluetooth -f S16_LE

sudo hcitool sr 00:0C:55:D1:C9:78 master

sudo hcitool con
Connections:
     < ACL 00:0C:55:D1:C9:78 handle 43 state 1 lm MASTER
     < ACL 00:0B:0D:89:5B:77 handle 42 state 1 lm MASTER
     < ACL 00:18:83:10:00:92 handle 53 state 1 lm MASTER
     < ACL 00:07:61:0F:4A:60 handle 49 state 1 lm MASTER
     < ACL 11:11:11:11:17:95 handle 46 state 1 lm MASTER

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
