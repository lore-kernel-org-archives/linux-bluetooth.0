Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <587CC1BB.9000607@avmap.ro>
References: <587CC1BB.9000607@avmap.ro>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Jan 2017 16:15:59 +0200
Message-ID: <CABBYNZLFrHSR5t4oDD5FSAEvSxAXnL4vpXDVr488Z6narbu4YQ@mail.gmail.com>
Subject: Re: AVRCP enabled music player application: Enable Browsing
To: Istvan Posta <iposta@avmap.ro>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Istvan,

On Mon, Jan 16, 2017 at 2:51 PM, Istvan Posta <iposta@avmap.ro> wrote:
> Hello,
>
> I apologize if I will sound too dumb, but I am desperate because I can't the
> solution for my problem.
>
> I am developing a music player application which will respond to
> Play/Pause/Stop/Next/Previous media button keys if the device running the
> application is connected to a media player device, like a media player in
> the car.
>
> Libraries I am using:
>     bluez version: 5.19
>     Dbus binding: GIO 2.42.1
>
> For this I have implemented all the interfaces following the MPRIS D-Bus
> Interface Specification, and called the org.bluez.Media1.RegisterPlayer
> method.
> The application is getting Play/Pause/Stop/Next/Previous key press events
> and is responding to them accordingly.
>
> The next step is to implement the Browsing feature in the application. This
> is where I got stuck. I have implemented the
> org.mpris.MediaPlayer2.Playlists an the org.mpris.MediaPlayer2.TrackList
> interfaces, but if I press the Browse button on the media player device,
> isn't showing the dummy playlists and tracklists of the application.
>
> I would really appreciate If somebody could help me and give me a good
> step-by-step description of what to implement, register or call in order to
> make it work.
>
> If I wasn't detailed enough and I have to give more information, please tell
> me.

Actually browsing isn't implemented for TG only for CT, so while you
might be doing everything correctly the implementation will never
pickup the Playlists and TrackList objects, although the idea would be
to do exactly that with playlists emulation the VFS and the TrackList
the NowPlaying but it has not being done yet.

-- 
Luiz Augusto von Dentz
