Return-Path: <cyrus@holtmann.org>
Message-ID: <482413B0.4010900@powercraft.nl>
Date: Fri, 09 May 2008 11:04:48 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <48171A58.8060200@powercraft.nl> <482356E2.3050909@jlab.org>
In-Reply-To: <482356E2.3050909@jlab.org>
Content-Type: multipart/mixed; boundary="------------050205010104070406040007"
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
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050205010104070406040007
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Chris Carlin wrote:
> Just to finish this up, Jelle, what type of bluetooth adapter do you have?
> 
> ~Chris
> 
> Jelle de Jong wrote:
>> Hello everybody,
>>
>> I have been playing around with bluetooth devices under linux the last 
>> month or so. I got some very good and some very bad experience with it.
>>
>> I am planning to create some wiki pages when I can get things working 
>> 100%. However I still got some major issues that I need to overcome.
>>
>> I bought a Motorola Bluetooth S805 stereo headset. It should get the 
>> following functionality:
>>
>> - Playback of stereo quality audio without distortions and without delay 
>> when playing audio and video at the same time.
>> - Generic playback controls like playpause/stop/next/previous.
>> - Internal microphone to record audio, used for audio recordings and 
>> audio video conferences.
>>
>> I was planning to get things up and running step by step:
>> - alsa configuration
>> - bluetooth configuration
>> - input device configuration
>>
>> So the alsa configuration exist out of:
>> -- handle multiple audio streams (slave devices)
>> -- make the device default or as a plugin
>> -- use multiple bluetooth headset for the same audio (conference)
>> -- use multiple bluetooth headset per user based (multiseat)
>> -- force audio to use the correct bit-rate and frequency for the devices?
>> -- set-up correct buffer so that playback is without distortions of out 
>> of sync audio and video. (testing with totem-xine?)
>> -- configure multiple profiles for stereo recording/playback
>>
>> Would somebody be willing to sent his working alsa configuration files 
>> that can do some of the above functions:
>>
>> On this moment the headset plays stereo audio, but when watching video 
>> with and audio dvd on totem-xine the audio is out of sync and when 
>> scrolling or skipping chapters it get worse and hidd can even crash with 
>> segmentation faults. There is also a lot of noise distortions.


I attached the information about the bluetooth adapter.

Is it a good idea to create some bug reports, then i can put all the 
information on one central place, and hopefully can also track the progress.

I switched back to alsa and lib-xine because gstreamer does not handles 
dvd playback very well, and pulse creates a to heavy cpu load for my system.

When playing back a dvd with totem with lib-xine and my bluetooth 
headset i got a few killer issues, that are directly bluez related:

1. when playing dvd audio, there is a audio conversion/compression 
problem, how higher the audio quality how greater the audio glitches. It 
is a really anoying glitch, it a sort of click sound.

A/52 2.0 (stereo)
48000 Hz
224 kbps

2. When my headset connects its becomes a slave by default, and i am 
also using a bluetooth mouse, that is master by default. When i move my 
mouse the audio stops and i need to pause and play to resync audio and 
video. I now execute sudo hcitool sr 00:0C:55:D1:C9:78 master everytime 
i start using the headset, but this causes the bluetooth mouse cursor to 
shock when playing high quality sound. And its not a cpu issue i am not 
using 100%. So i got a real bandwidth priority issue with bluez....?

Thanks in advance,

Jelle

--------------050205010104070406040007
Content-Type: text/plain;
	name="cirago bluethooth usb adapter micro BTA-3210.txt"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
	filename="cirago bluethooth usb adapter micro BTA-3210.txt"

c3VkbyBoY2ljb25maWcgLWEKaGNpMDogICBUeXBlOiBVU0IKICAgIEJEIEFkZHJlc3M6IDAw
OjFCOkRDOjAwOjNFOjBCIEFDTCBNVFU6IDMxMDoxMCBTQ08gTVRVOiA2NDo4CiAgICBVUCBS
VU5OSU5HIFBTQ0FOIElTQ0FOCiAgICBSWCBieXRlczo0NzA1MSBhY2w6MjcwMiBzY286MCBl
dmVudHM6MTg2IGVycm9yczowCiAgICBUWCBieXRlczoxNjIyIGFjbDozOSBzY286MCBjb21t
YW5kczo2MSBlcnJvcnM6MAogICAgRmVhdHVyZXM6IDB4ZmYgMHhmZiAweDhmIDB4ZmUgMHg5
YiAweGY5IDB4MDAgMHg4MAogICAgUGFja2V0IHR5cGU6IERNMSBETTMgRE01IERIMSBESDMg
REg1IEhWMSBIVjIgSFYzCiAgICBMaW5rIHBvbGljeTogUlNXSVRDSCBIT0xEIFNOSUZGIFBB
UksKICAgIExpbmsgbW9kZTogU0xBVkUgQUNDRVBUCiAgICBOYW1lOiAnW2RlYmlhbi1lZWVw
Y10gLyBCVCBEZXZpY2UgMCcKICAgIENsYXNzOiAweDA4MDEwOAogICAgU2VydmljZSBDbGFz
c2VzOiBDYXB0dXJpbmcKICAgIERldmljZSBDbGFzczogQ29tcHV0ZXIsIFNlcnZlcgogICAg
SENJIFZlcjogMi4wICgweDMpIEhDSSBSZXY6IDB4YzVjIExNUCBWZXI6IDIuMCAoMHgzKSBM
TVAgU3VidmVyOiAweGM1YwogICAgTWFudWZhY3R1cmVyOiBDYW1icmlkZ2UgU2lsaWNvbiBS
YWRpbyAoMTApCgpzdWRvIGhjaWNvbmZpZyBoY2kwIGZlYXR1cmVzCmhjaTA6ICAgVHlwZTog
VVNCCiAgICBCRCBBZGRyZXNzOiAwMDoxQjpEQzowMDozRTowQiBBQ0wgTVRVOiAzMTA6MTAg
U0NPIE1UVTogNjQ6OAogICAgRmVhdHVyZXM6IDB4ZmYgMHhmZiAweDhmIDB4ZmUgMHg5YiAw
eGY5IDB4MDAgMHg4MAogICAgICAgIDwzLXNsb3QgcGFja2V0cz4gPDUtc2xvdCBwYWNrZXRz
PiA8ZW5jcnlwdGlvbj4gPHNsb3Qgb2Zmc2V0PgogICAgICAgIDx0aW1pbmcgYWNjdXJhY3k+
IDxyb2xlIHN3aXRjaD4gPGhvbGQgbW9kZT4gPHNuaWZmIG1vZGU+CiAgICAgICAgPHBhcmsg
c3RhdGU+IDxSU1NJPiA8Y2hhbm5lbCBxdWFsaXR5PiA8U0NPIGxpbms+IDxIVjIgcGFja2V0
cz4KICAgICAgICA8SFYzIHBhY2tldHM+IDx1LWxhdyBsb2c+IDxBLWxhdyBsb2c+IDxDVlNE
PiA8cGFnaW5nIHNjaGVtZT4KICAgICAgICA8cG93ZXIgY29udHJvbD4gPHRyYW5zcGFyZW50
IFNDTz4gPGJyb2FkY2FzdCBlbmNyeXB0PgogICAgICAgIDxFRFIgQUNMIDIgTWJwcz4gPEVE
UiBBQ0wgMyBNYnBzPiA8ZW5oYW5jZWQgaXNjYW4+CiAgICAgICAgPGludGVybGFjZWQgaXNj
YW4+IDxpbnRlcmxhY2VkIHBzY2FuPiA8aW5xdWlyeSB3aXRoIFJTU0k+CiAgICAgICAgPGV4
dGVuZGVkIFNDTz4gPEVWNCBwYWNrZXRzPiA8RVY1IHBhY2tldHM+IDxBRkggY2FwLiBzbGF2
ZT4KICAgICAgICA8QUZIIGNsYXNzLiBzbGF2ZT4gPDMtc2xvdCBFRFIgQUNMPiA8NS1zbG90
IEVEUiBBQ0w+CiAgICAgICAgPEFGSCBjYXAuIG1hc3Rlcj4gPEFGSCBjbGFzcy4gbWFzdGVy
PiA8RURSIGVTQ08gMiBNYnBzPgogICAgICAgIDxFRFIgZVNDTyAzIE1icHM+IDwzLXNsb3Qg
RURSIGVTQ08+IDxleHRlbmRlZCBmZWF0dXJlcz4K
--------------050205010104070406040007
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--------------050205010104070406040007
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------050205010104070406040007--
