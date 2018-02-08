Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <376c4af7-acbc-08e8-e3b9-1e7f288f69d2@gmail.com>
References: <d74ae042-eec6-e4bb-45f9-904631fe642b@gmail.com>
 <CABBYNZJ3NfZnM0A3ni=G1kXN4Yt5CeBbV5H0OaRfs8f07BmzAg@mail.gmail.com>
 <88feb93f-928f-9783-7d16-b4b87b402a1a@gmail.com> <CAOASepPE0AtSCaMc085eOZdX1X_E7mxxa0a+tcSNc3mGGioMog@mail.gmail.com>
 <73597a16-0a96-4d6f-64f5-46a7bb3f983a@gmail.com> <CABBYNZ+HUx2MdO4kZ5-49vZNVr7YP_9YgwVC8+zN17p=MaaSVQ@mail.gmail.com>
 <f4f61d35-bdf0-77e0-5c3f-3696e3cedfc8@gmail.com> <CABBYNZLk8LbypFOeTsnFYmJJaJpZNTkQh7d1sWi42fK8joHvLw@mail.gmail.com>
 <CABBYNZLS1Qbw9sktPX6_qmQrtuvGmch78-aOo_V3Agi1Z9pfMg@mail.gmail.com> <376c4af7-acbc-08e8-e3b9-1e7f288f69d2@gmail.com>
From: Julien Nicoulaud <julien.nicoulaud@gmail.com>
Date: Thu, 8 Feb 2018 16:15:11 +0100
Message-ID: <CA+mcLN57gZ=oNqeVwMieOPz4r+iWtC-y4vxq-Gx0u0U5Ze2z_w@mail.gmail.com>
Subject: Re: Apparent bluez 5.48 regression: Headphones fail to reconnect
 after suspend/resume
To: Vincent Petry <pvince81@googlemail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2018-02-07 7:52 GMT+01:00 Vincent Petry <pvince81@googlemail.com>:
>
> Hi Luiz,
>
> Can you give me some pointers where I should put the gdb breakpoint to
> get a useful trace ?
>
> I also saw that there is some DBG function logging things. How do I
> enable this logging and from where can I get its output ? Useful would
> probably to log some internal state with and without returning from suspend.
>
> Regarding the breaking patch, it seems to be related to some advertising
> API that used to be marked experimental and is now not experimental any
> more in 5.48.
> Does maybe pulseaudio use this API and had a fallback at the time said
> API was disabled ? And now that it's enabled its code path changed and
> maybe triggered a hidden bug ? Would need to look at the pulseaudio
> bluetooth source code.
> Or does the patch in question enabled advertising where no advertising
> was done before ? Maybe it is advertising too early at a time where the
> system hasn't fully resumed from suspend ?
>
> My pulseaudio version: pulseaudio-11.1-2.1.x86_64
>
> Would be good if the other affected users post their distro + pulseaudio
> versions for cross-reference.

Hi, I am also affected by this since updating to bluez 5.48.

My distro is Arch Linux, pulseaudio 11.1-1, linux 4.14.15, using a
Bose QuietComfort 35 headset with an Asus zenbook laptop (Intel 7260
wireless chip).

Please let me know if I can be of any help.

Cheers,
Julien

>
>
> Cheers,
>
> Vincent
>
>
> On 02/06/2018 03:28 PM, Luiz Augusto von Dentz wrote:
> > Hi Vincent,
> >
> > On Tue, Feb 6, 2018 at 11:30 AM, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> >> Hi Vincent,
> >>
> >> On Tue, Feb 6, 2018 at 11:17 AM, Vincent Petry <pvince81@googlemail.com> wrote:
> >>> Hi Luiz,
> >>>
> >>>> Hi Vincent,
> >>>>
> >>>> On Tue, Feb 6, 2018 at 4:53 AM, Vincent Petry <pvince81@googlemail.com> wrote:
> >>>>> Hello,
> >>>>>
> >>>>> I have bisected bluez between 5.47 (good) and 5.48 (bad) to find the
> >>>>> breaking commit for the headset reconnect issue.
> >>>>>
> >>>>> Here are the results:
> >>>>>
> >>>>> git bisect start
> >>>>> # bad: [0d1e3b9c5754022c779da129025d493a198d49cf] Release 5.48
> >>>>> git bisect bad 0d1e3b9c5754022c779da129025d493a198d49cf
> >>>>> # good: [d139fd866241fe0d99b5e430f937c8d6160cc7dd] Release 5.47
> >>>>> git bisect good d139fd866241fe0d99b5e430f937c8d6160cc7dd
> >>>>> # bad: [65aaf36f2a36895e4a351ac3fa1cb8da87d4589c] mesh: Correct length
> >>>>> test in agent.c:request_ascii
> >>>>> git bisect bad 65aaf36f2a36895e4a351ac3fa1cb8da87d4589c
> >>>>> # good: [c50a8a397d4abd994a9115230279d5fe922b4aa5] adapter: Add
> >>>>> btd_request_authorization_cable_configured()
> >>>>> git bisect good c50a8a397d4abd994a9115230279d5fe922b4aa5
> >>>>> # bad: [c133489d54cb6d28c3fd308557937acbc5245f5e] battery: Add BT SIG
> >>>>> reserved number used by Battery Service
> >>>>> git bisect bad c133489d54cb6d28c3fd308557937acbc5245f5e
> >>>>> # good: [e577e478e9cb1d1a22e63fd7d8fff07c471590de] gatt: Add
> >>>>> implementation of link option
> >>>>> git bisect good e577e478e9cb1d1a22e63fd7d8fff07c471590de
> >>>>> # bad: [5b9596dac4d0e25c5179be8643726a02c058b00a] advertising: Add
> >>>>> implementation of Duration and Timeout
> >>>>> git bisect bad 5b9596dac4d0e25c5179be8643726a02c058b00a
> >>>>> # bad: [f9a2b1f515c7f5dced80397f4ea891d6c372175d] client: Fix not
> >>>>> detecting advertising instance is no longer valid
> >>>>> git bisect bad f9a2b1f515c7f5dced80397f4ea891d6c372175d
> >>>>> # bad: [d6e9539e31c6bb5afd39ec6f09c518d232e6345d] doc/advertising-api:
> >>>>> Mark LEAdvertisingManager1 stable
> >>>>> git bisect bad d6e9539e31c6bb5afd39ec6f09c518d232e6345d
> >>>>> # good: [10760c91c234fe2bfedf924c9e61f31861c2dc72] gatt: Fix crash while
> >>>>> disconnecting ATT
> >>>>> git bisect good 10760c91c234fe2bfedf924c9e61f31861c2dc72
> >>>>> # first bad commit: [d6e9539e31c6bb5afd39ec6f09c518d232e6345d]
> >>>>> doc/advertising-api: Mark LEAdvertisingManager1 stable
> >>>> Im not able to decipher this, what is the patch where the problem
> >>>> first appeared? Also could you collect the HCI trace and syslog when
> >>>> it happens?
> >>> Please try this:
> >>>
> >>> 1. git clone git://git.kernel.org/pub/scm/bluetooth/bluez.git
> >>> 2. cd bluez
> >>> 3. git show d6e9539e31c6bb5afd39ec6f09c518d232e6345d
> >>>
> >>> This will show your the first bad commit / the patch that introduces the
> >>> issue.
> >>>
> >>> For the syslog, see attachments to my original report here
> >>> https://bugzilla.suse.com/show_bug.cgi?id=1076898
> >>>
> >>> Do you have more information about how I could get the HCI trace ?
> >>> Should I run bluetoothd through gdb and query the backtrace from the
> >>> point where the error message happens, if that's what you are asking for ?
> >> Jan 20 15:50:47 vvortex.ttv pulseaudio[1964]: [pulseaudio]
> >> bluez5-util.c: Information about device
> >> /org/bluez/hci0/dev_E3_28_E9_20_58_08 is invalid
> >> Jan 20 15:50:47 vvortex.ttv bluetoothd[3136]: Endpoint replied with an
> >> error: org.bluez.Error.InvalidArguments
> >>
> >> So this is really PulseAudio rejecting the connection, it probably
> >> loose track of the objects when resuming or we did not send the
> >> objects but in that case bluetoothctl would not be able to list them
> >> as well.
> > And I couldn't reproduce it myself:
> > https://gist.github.com/anonymous/423edb41e572577b8507d8d0662acc84
> >
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
