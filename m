Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKwwfuThjnWe_GTJEvKxyHkGZsZeVSYd1gb3N5ywZp7oCpZ1nw@mail.gmail.com>
References: <CAKwwfuT5t6ARrmhPnpTTDpyhTUZ1j+enRh1jsMMhyb5jjiaBYA@mail.gmail.com>
 <CAAEJBhJ_abML8TL7LQAA5S18Q9vAmV8OOX9USMeFqiU2Z9ULjA@mail.gmail.com>
 <CAKwwfuQ0zvHYCWZMbBnOKGjUWtX++a6As=SjRY-ycQym3kBL8g@mail.gmail.com>
 <CAAEJBh+vb2z7UJd0-47V2fgizNS+k-HhFjFy7W_dBtVmHFRkmw@mail.gmail.com>
 <CAKwwfuScYXwcguX6uysmzn90YvEvjrcK_Dx5=Z0DYzSOHrhd=w@mail.gmail.com>
 <CAKwwfuQecoEYY=F7ewiX+8RyJimLGnz9rMvy0L2y37OdJhpKfw@mail.gmail.com> <CAKwwfuThjnWe_GTJEvKxyHkGZsZeVSYd1gb3N5ywZp7oCpZ1nw@mail.gmail.com>
From: Szymon Janc <szymon.janc@codecoup.pl>
Date: Mon, 27 Feb 2017 17:50:35 +0100
Message-ID: <CAAEJBhKANaxmsh1E6r3wPd=mxET-RFbUVjr5qjn+OwQnCDLAUw@mail.gmail.com>
Subject: Re: Unable to pair Bose QC35
To: Dor Shemer <dorshemer@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 27 February 2017 at 17:36, Dor Shemer <dorshemer@gmail.com> wrote:
>
>
>
> On Feb 27, 2017 1:27 PM, "Szymon Janc" <szymon.janc@codecoup.pl> wrote:
>
> Hi,
>
> On 26 February 2017 at 22:54, Dor Shemer <dorshemer@gmail.com> wrote:
> > Thanks for replying,
> >
> > On Sun, Feb 26, 2017 at 9:57 PM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> >> Hi,
> >>
> >> On 25 February 2017 at 15:10, Dor Shemer <dorshemer@gmail.com> wrote:
> >>> Hello,
> >>>
> >>> I have a new set of Bose QC35 that won't my pair with ubuntu 16.10
> >>> (dell xps 9550). I tried everything I could find on this mailing list
> >>> (http://marc.info/?l=linux-bluetooth&m=148314289530765&w=2) and
> >>> askubuntu.com (http://askubuntu.com/questions/833322/pair-bose-quietcomfort-35-with-ubuntu-16-04-over-bluetooth)
> >>> but nothing seems to help.
> >>>
> >>> I'm trying to pair using either dual mode or bredr, as suggested in
> >>> the askubunu answer.
> >>>
> >>> Using ControllerMode = dual I get:
> >>>
> >>>     [bluetooth]# devices
> >>>     Device 04:52:C7:62:27:75 LE-Pigment Pete
> >>>     [bluetooth]# pair 04:52:C7:62:27:75
> >>>     Attempting to pair with 04:52:C7:62:27:75
> >>>     [CHG] Device 04:52:C7:62:27:75 Connected: yes
> >>>     Failed to pair: org.bluez.Error.AuthenticationFailed
> >>>     [CHG] Device 04:52:C7:62:27:75 Connected: no
> >>>
> >>>
> >>> OnControllerMode = bredr I can't even find the device, but if
> >>> remembered from the dual mode scan, I get:
> >>>
> >>>     [bluetooth]# devices
> >>>     Device 04:52:C7:62:27:75 LE-Pigment Pete
> >>>     [bluetooth]# pair 04:52:C7:62:27:75
> >>>     Attempting to pair with 04:52:C7:62:27:75
> >>>     Failed to pair: org.bluez.Error.AuthenticationRejected
> >>>
> >>>
> >>> I'm not sure what causes this or where to keep looking, as none of the
> >>> questions I found online have this exact problem. Could you help guide
> >>> me?
> >>
> >> Please update, this should be fixed in 5.42.
> >
> > I tried that, and upgraded to 5.43 from source, however the issue
> > remains the same,
> > Should I upgrade another package? Are there logs or debug mode I should check?
>
> It seems to work just fine here.
>
> Are you sure your headset is in pairing mode?
> You could collect btmon traces from pairing (including device discovery).
>
> --
> pozdrawiam
> Szymon K. Janc
>
>
> I'm positive it's in pairing mode. The same procedure works with my Android and Windows devices.
>
> How can I collect pairing traces from btmon? I'm not familiar with it.
> Is there anywhere I can get a more detailed error than AuthenticationFailed / AuthenticationRejected?

You can use 'sudo btmon' for HCI traces and then you'll see all the traffic.

But what you describe seems like you are not using 5.43 but older
version. This looks like you try
to pair over LE and QC35 doesn't support pairing over LE (nor cross
transport pairing).

Please double check if you correctly upgraded BlueZ (since you use
Ubuntu I'd just use debs from
'zesty' release instead of building from sources).

-- 
pozdrawiam
Szymon K. Janc
