Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Niek Vlessert <niekvlessert@gmail.com>
Subject: AVRCP 1.6
Message-ID: <a5d52a61-9c2e-b0d8-3e64-06a6e03cc411@gmail.com>
Date: Tue, 21 Jun 2016 00:08:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello list,

I've developed some player thing with chiptune music in the browser and 
I wanted an Android app using Webview to be able to change tracks and 
see the titles with my car audio system. After some experimenting I got 
it done using the MediaSession/PlaybackState/MediaMetadata Android 
provides. However I wondered about album art. After experimenting and a 
lot of google I'm currently here;

- Album art was standardised in AVRCP 1.6 although older versions had 
some openings that could be used but nobody did.
- As far as I know no car media system supports AVRCP 1.6 yet, but there 
seems to be some reference platform for car manufacturers; AudioVideoSDK 
3.0, that supports it.
- Bluez supports AVRCP up to 1.5
- I can't find any evidence it's been worked on
- MediaMetadata has support for images, but I suppose that's 
non-bluetooth related (Chromecast?).
- Some car systems with an iPhone can use the internet connection 
provided by the phone to download album art from cddb, which is why some 
people believe iPhone supports AVRCP 1.6. I don't think that's 
implemented in non iPhone devices?
- Some others support it in the MP3 file on the local SD card, but I'm 
not using MP3.
- Currently I'm testing my little Android app in conjunction with an 
Ubuntu VM on my iMac, because Ubuntu can run in A2DP sink mode thanks to 
Bluez.
- I'm testing AVRCP with D-feet, previous/next etc. works fine!!
- Using Wireshark on my VM I can see what's going on

So onto my questions:

- Is there any work being done on this?
- Is there any software on Linux out there to test AVRCP 1.6? I can't 
find any.
- Would you consider it possible to put the right hex into my Android 
app and transmit that to my Bluetooth connection so I can implement it 
without the Android Bluez stack supporting it? If target devices will 
ever support it... Since it's serial communication, I thought why not? I 
never did anything like this with Bluetooth programming so forgive my 
ignorance. :) Something like this: create L2CAP channel with the Cover 
Art UUID. Wait for response; encode picture in the right data packages, 
and here we go. Leave other Bluetooth communication requirements to Android.
- Or maybe I could use the cddb support? Maybe it's possible to redirect 
traffic to cddb to somewhere else, provide the cddb interface and offer 
the image like that? I know, it's horrible... ;)

And of course I'm ready to test.

Regards,

Niek Vlessert
