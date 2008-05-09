Return-Path: <cyrus@holtmann.org>
Message-ID: <48244A74.7080307@powercraft.nl>
Date: Fri, 09 May 2008 14:58:28 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <48171A58.8060200@powercraft.nl> <482356E2.3050909@jlab.org>
	<482413B0.4010900@powercraft.nl>
In-Reply-To: <482413B0.4010900@powercraft.nl>
Content-Type: multipart/mixed; boundary="------------090107000400050502040807"
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
--------------090107000400050502040807
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Jelle de Jong wrote:
> Chris Carlin wrote:
>> Just to finish this up, Jelle, what type of bluetooth adapter do you 
>> have?
>>
>> ~Chris
>>
>> Jelle de Jong wrote:
>>> Hello everybody,
>>>
>>> I have been playing around with bluetooth devices under linux the 
>>> last month or so. I got some very good and some very bad experience 
>>> with it.
>>>
>>> I am planning to create some wiki pages when I can get things working 
>>> 100%. However I still got some major issues that I need to overcome.
>>>
>>> I bought a Motorola Bluetooth S805 stereo headset. It should get the 
>>> following functionality:
>>>
>>> - Playback of stereo quality audio without distortions and without 
>>> delay when playing audio and video at the same time.
>>> - Generic playback controls like playpause/stop/next/previous.
>>> - Internal microphone to record audio, used for audio recordings and 
>>> audio video conferences.
>>>
>>> I was planning to get things up and running step by step:
>>> - alsa configuration
>>> - bluetooth configuration
>>> - input device configuration
>>>
>>> So the alsa configuration exist out of:
>>> -- handle multiple audio streams (slave devices)
>>> -- make the device default or as a plugin
>>> -- use multiple bluetooth headset for the same audio (conference)
>>> -- use multiple bluetooth headset per user based (multiseat)
>>> -- force audio to use the correct bit-rate and frequency for the 
>>> devices?
>>> -- set-up correct buffer so that playback is without distortions of 
>>> out of sync audio and video. (testing with totem-xine?)
>>> -- configure multiple profiles for stereo recording/playback
>>>
>>> Would somebody be willing to sent his working alsa configuration 
>>> files that can do some of the above functions:
>>>
>>> On this moment the headset plays stereo audio, but when watching 
>>> video with and audio dvd on totem-xine the audio is out of sync and 
>>> when scrolling or skipping chapters it get worse and hidd can even 
>>> crash with segmentation faults. There is also a lot of noise 
>>> distortions.
> 
> 
> I attached the information about the bluetooth adapter.
> 
> Is it a good idea to create some bug reports, then i can put all the 
> information on one central place, and hopefully can also track the 
> progress.
> 
> I switched back to alsa and lib-xine because gstreamer does not handles 
> dvd playback very well, and pulse creates a to heavy cpu load for my 
> system.
> 
> When playing back a dvd with totem with lib-xine and my bluetooth 
> headset i got a few killer issues, that are directly bluez related:
> 
> 1. when playing dvd audio, there is a audio conversion/compression 
> problem, how higher the audio quality how greater the audio glitches. It 
> is a really anoying glitch, it a sort of click sound.
> 
> A/52 2.0 (stereo)
> 48000 Hz
> 224 kbps
> 
> 2. When my headset connects its becomes a slave by default, and i am 
> also using a bluetooth mouse, that is master by default. When i move my 
> mouse the audio stops and i need to pause and play to resync audio and 
> video. I now execute sudo hcitool sr 00:0C:55:D1:C9:78 master everytime 
> i start using the headset, but this causes the bluetooth mouse cursor to 
> shock when playing high quality sound. And its not a cpu issue i am not 
> using 100%. So i got a real bandwidth priority issue with bluez....?
> 
> Thanks in advance,
> 
> Jelle
> 

I got a new device Motorola s9 today and did some more testing, it also 
has the issue that it connects in a way that when using other bluetooth 
devices the audio stops. When I manually set the device as master my 
bluetooth mouse is somewhat more responding then with the Motorola s805 
headset. But a reminder that everything works 100% fully under windows, 
so it should be possible to use the devices 100% with bluez somehow...

I attached device and hcitool info in addition the my previous message.

Kind regards,

Jelle

--------------090107000400050502040807
Content-Type: text/plain;
 name="hcitool-info-motorola-s9.txt"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="hcitool-info-motorola-s9.txt"

Y29uZmlnIGEyZHAgLSBkZXZpY2UgPSAwMDowRDpGRDoxODo2RTozQyBhY2Nlc3NfbW9kZSA9
IDIKY29kZWMgc2JjIC0gZnJlcXVlbmN5ID0gMSBjaGFubmVsX21vZGUgPSAxIGFsbG9jYXRp
b24gPSAxIHN1YmJhbmRzID0gMSBibG9ja3MgPSAxIGJpdHBvb2wgPSA0NAoKaGNpdG9vbCBj
b24KQ29ubmVjdGlvbnM6CiAgICA8IEFDTCAwMDowRDpGRDoxODo2RTozQyBoYW5kbGUgNDIg
c3RhdGUgMSBsbSBNQVNURVIgRU5DUllQVAogICAgPiBBQ0wgMTE6MTE6MTE6MTE6MTc6OTUg
aGFuZGxlIDQzIHN0YXRlIDEgbG0gTUFTVEVSCgpzdWRvIGhjaXRvb2wgaW5mbyAwMDowRDpG
RDoxODo2RTozQwpSZXF1ZXN0aW5nIGluZm9ybWF0aW9uIC4uLgogICAgQkQgQWRkcmVzczog
IDAwOjBEOkZEOjE4OjZFOjNDCiAgICBEZXZpY2UgTmFtZTogTW90b3JvbGEgUzkKICAgIExN
UCBWZXJzaW9uOiAyLjAgKDB4MykgTE1QIFN1YnZlcnNpb246IDB4ZTkwCiAgICBNYW51ZmFj
dHVyZXI6IENhbWJyaWRnZSBTaWxpY29uIFJhZGlvICgxMCkKICAgIEZlYXR1cmVzOiAweGZm
IDB4ZmYgMHg4YiAweGY4IDB4MWIgMHgxOCAweDAwIDB4ODAKICAgICAgICA8My1zbG90IHBh
Y2tldHM+IDw1LXNsb3QgcGFja2V0cz4gPGVuY3J5cHRpb24+IDxzbG90IG9mZnNldD4KICAg
ICAgICA8dGltaW5nIGFjY3VyYWN5PiA8cm9sZSBzd2l0Y2g+IDxob2xkIG1vZGU+IDxzbmlm
ZiBtb2RlPgogICAgICAgIDxwYXJrIHN0YXRlPiA8UlNTST4gPGNoYW5uZWwgcXVhbGl0eT4g
PFNDTyBsaW5rPiA8SFYyIHBhY2tldHM+CiAgICAgICAgPEhWMyBwYWNrZXRzPiA8dS1sYXcg
bG9nPiA8QS1sYXcgbG9nPiA8Q1ZTRD4gPHBhZ2luZyBzY2hlbWU+CiAgICAgICAgPHRyYW5z
cGFyZW50IFNDTz4gPGJyb2FkY2FzdCBlbmNyeXB0PiA8ZW5oYW5jZWQgaXNjYW4+CiAgICAg
ICAgPGludGVybGFjZWQgaXNjYW4+IDxpbnRlcmxhY2VkIHBzY2FuPiA8aW5xdWlyeSB3aXRo
IFJTU0k+CiAgICAgICAgPGV4dGVuZGVkIFNDTz4gPEVWNCBwYWNrZXRzPiA8RVY1IHBhY2tl
dHM+IDxBRkggY2FwLiBzbGF2ZT4KICAgICAgICA8QUZIIGNsYXNzLiBzbGF2ZT4gPEFGSCBj
YXAuIG1hc3Rlcj4gPEFGSCBjbGFzcy4gbWFzdGVyPgogICAgICAgIDxleHRlbmRlZCBmZWF0
dXJlcz4K
--------------090107000400050502040807
Content-Type: text/plain;
 name="hcitool-info-motorola-s805.txt"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="hcitool-info-motorola-s805.txt"

Y29uZmlnIGEyZHAgLSBkZXZpY2UgPSAwMDowQzo1NTpEMTpDOTo3OCBhY2Nlc3NfbW9kZSA9
IDIKY29kZWMgc2JjIC0gZnJlcXVlbmN5ID0gMSBjaGFubmVsX21vZGUgPSAxIGFsbG9jYXRp
b24gPSAxIHN1YmJhbmRzID0gMSBibG9ja3MgPSAxIGJpdHBvb2wgPSA0NAoKc3VkbyBoY2l0
b29sIHNyIDAwOjBDOjU1OkQxOkM5Ojc4IG1hc3RlcgoKc3VkbyBoY2l0b29sIGNvbgpDb25u
ZWN0aW9uczoKICAgID4gQUNMIDExOjExOjExOjExOjE3Ojk1IGhhbmRsZSA0MyBzdGF0ZSAx
IGxtIE1BU1RFUgogICAgPiBBQ0wgMDA6MEM6NTU6RDE6Qzk6NzggaGFuZGxlIDQyIHN0YXRl
IDEgbG0gTUFTVEVSCgpzdWRvIGhjaXRvb2wgaW5mbyAwMDowQzo1NTpEMTpDOTo3OApSZXF1
ZXN0aW5nIGluZm9ybWF0aW9uIC4uLgogICAgQkQgQWRkcmVzczogIDAwOjBDOjU1OkQxOkM5
Ojc4CiAgICBEZXZpY2UgTmFtZTogTW90b3JvbGEgUzgwNQogICAgTE1QIFZlcnNpb246IDIu
MCAoMHgzKSBMTVAgU3VidmVyc2lvbjogMHhhNDEKICAgIE1hbnVmYWN0dXJlcjogQ2FtYnJp
ZGdlIFNpbGljb24gUmFkaW8gKDEwKQogICAgRmVhdHVyZXM6IDB4ZmYgMHhmZiAweDhmIDB4
NzggMHgxOCAweDE4IDB4MDAgMHg4MAogICAgICAgIDwzLXNsb3QgcGFja2V0cz4gPDUtc2xv
dCBwYWNrZXRzPiA8ZW5jcnlwdGlvbj4gPHNsb3Qgb2Zmc2V0PgogICAgICAgIDx0aW1pbmcg
YWNjdXJhY3k+IDxyb2xlIHN3aXRjaD4gPGhvbGQgbW9kZT4gPHNuaWZmIG1vZGU+CiAgICAg
ICAgPHBhcmsgc3RhdGU+IDxSU1NJPiA8Y2hhbm5lbCBxdWFsaXR5PiA8U0NPIGxpbms+IDxI
VjIgcGFja2V0cz4KICAgICAgICA8SFYzIHBhY2tldHM+IDx1LWxhdyBsb2c+IDxBLWxhdyBs
b2c+IDxDVlNEPiA8cGFnaW5nIHNjaGVtZT4KICAgICAgICA8cG93ZXIgY29udHJvbD4gPHRy
YW5zcGFyZW50IFNDTz4gPGJyb2FkY2FzdCBlbmNyeXB0PgogICAgICAgIDxlbmhhbmNlZCBp
c2Nhbj4gPGludGVybGFjZWQgaXNjYW4+IDxpbnRlcmxhY2VkIHBzY2FuPgogICAgICAgIDxp
bnF1aXJ5IHdpdGggUlNTST4gPEFGSCBjYXAuIHNsYXZlPiA8QUZIIGNsYXNzLiBzbGF2ZT4K
ICAgICAgICA8QUZIIGNhcC4gbWFzdGVyPiA8QUZIIGNsYXNzLiBtYXN0ZXI+IDxleHRlbmRl
ZCBmZWF0dXJlcz4K
--------------090107000400050502040807
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--------------090107000400050502040807
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------090107000400050502040807--
