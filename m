Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a5d52a61-9c2e-b0d8-3e64-06a6e03cc411@gmail.com>
References: <a5d52a61-9c2e-b0d8-3e64-06a6e03cc411@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 21 Jun 2016 11:42:54 +0300
Message-ID: <CABBYNZ+fo2FY2rvFkz9mkTGf5guCCQgczEK+5TSrqhS-hHEmVA@mail.gmail.com>
Subject: Re: AVRCP 1.6
To: Niek Vlessert <niekvlessert@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Niek,

On Tue, Jun 21, 2016 at 1:08 AM, Niek Vlessert <niekvlessert@gmail.com> wrote:
> Hello list,
>
> I've developed some player thing with chiptune music in the browser and I
> wanted an Android app using Webview to be able to change tracks and see the
> titles with my car audio system. After some experimenting I got it done
> using the MediaSession/PlaybackState/MediaMetadata Android provides. However
> I wondered about album art. After experimenting and a lot of google I'm
> currently here;
>
> - Album art was standardised in AVRCP 1.6 although older versions had some
> openings that could be used but nobody did.
> - As far as I know no car media system supports AVRCP 1.6 yet, but there
> seems to be some reference platform for car manufacturers; AudioVideoSDK
> 3.0, that supports it.
> - Bluez supports AVRCP up to 1.5

Actually we can do up to 1.6 but just the mandatory commands which
don't include the ones necessary for cover art, etc.

> - I can't find any evidence it's been worked on
> - MediaMetadata has support for images, but I suppose that's non-bluetooth
> related (Chromecast?).

Android has support only to 1.3, there are vendors that extend to
1.4/1.5 like samsung but they have to change all the way from HAL to
java to interface this to the application.

> - Some car systems with an iPhone can use the internet connection provided
> by the phone to download album art from cddb, which is why some people
> believe iPhone supports AVRCP 1.6. I don't think that's implemented in non
> iPhone devices?

I don't think so either, even in case of chromecast it is a custom
protocol by the application or the full tab if you are using chrome to
cast.

> - Some others support it in the MP3 file on the local SD card, but I'm not
> using MP3.
> - Currently I'm testing my little Android app in conjunction with an Ubuntu
> VM on my iMac, because Ubuntu can run in A2DP sink mode thanks to Bluez.
> - I'm testing AVRCP with D-feet, previous/next etc. works fine!!

You can use tools/bluetooth-player if you want to control it from the
command line, another alternative is to use tools/mpris-proxy and then
control it using a MPRIS controller.

> - Using Wireshark on my VM I can see what's going on
>
> So onto my questions:
>
> - Is there any work being done on this?
> - Is there any software on Linux out there to test AVRCP 1.6? I can't find
> any.

I don't think anyone has come to implement AVRCP 1.6 for any OS
actually, at least not the commands necessary for cover art transfer.

> - Would you consider it possible to put the right hex into my Android app
> and transmit that to my Bluetooth connection so I can implement it without
> the Android Bluez stack supporting it? If target devices will ever support
> it... Since it's serial communication, I thought why not? I never did
> anything like this with Bluetooth programming so forgive my ignorance. :)
> Something like this: create L2CAP channel with the Cover Art UUID. Wait for
> response; encode picture in the right data packages, and here we go. Leave
> other Bluetooth communication requirements to Android.

You can do whatever you want, but since it would be non-standard this
would limit a lot the usage.

> - Or maybe I could use the cddb support? Maybe it's possible to redirect
> traffic to cddb to somewhere else, provide the cddb interface and offer the
> image like that? I know, it's horrible... ;)

Also non-standard, perhaps investing time in doing a AVRCP 1.6 would be better.

> And of course I'm ready to test.
>
> Regards,
>
> Niek Vlessert
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
