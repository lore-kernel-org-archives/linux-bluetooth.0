Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANq1E4RE4ZhfvxhO=MdbMdwUZYrsdYnw=Yn7uLJE4gTAbHhOEw@mail.gmail.com>
References: <5050F5A9.5090401@butterbrot.org>
	<CANq1E4RYuVy2b1GD2E4MsErbkGZgD6gnDaYeDmyWyYnKaze0Jg@mail.gmail.com>
	<ed6fbaf1-1410-4539-a36e-1d6d6f6220b5@email.android.com>
	<CANq1E4RmacRAkTVtRt2JH_+V=qn1AH3iJWZZS_LCqmj_yt4DoQ@mail.gmail.com>
	<CANq1E4S70tqhTG7PTMj5cHp45NLO9g4n1eLVaHJMuDZx1KMYjg@mail.gmail.com>
	<5052519F.30803@butterbrot.org>
	<CANq1E4TRWGTdpiXsrR3uUp+n1jtptRnSaOp++LBKqyiRM0=eGg@mail.gmail.com>
	<50549F3C.8050406@butterbrot.org>
	<CANq1E4RE4ZhfvxhO=MdbMdwUZYrsdYnw=Yn7uLJE4gTAbHhOEw@mail.gmail.com>
Date: Mon, 17 Sep 2012 12:32:44 +0200
Message-ID: <CANq1E4SEksMap70S7kRW9R7birBdFkBXbWmSM-sb-rR3jyhujg@mail.gmail.com>
Subject: Re: Wii Balance Board vs. bluez
From: David Herrmann <dh.herrmann@googlemail.com>
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian

On Mon, Sep 17, 2012 at 11:47 AM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Thanks! I have both patches ready for submission. However, could you
> actually tell me in what range data is submitted? As I said, I cannot
> test these patches. But looking at the code, you get 16bit per value
> raw input. You then calculate the per-kg value and multiply it by
> 17kg. So I guess you fill up the whole 16bit?
>
> Your second patch does not adjust the MIN/MAX values for the ABS_HATXY
> values and I am just looking for good values here.

I just noticed these values aren't forced by the input core so I've
just sent the patches to the linux-input ML and put you into CC.
Please respond to them with your signed-off-by and tested-by lines as
I noted in the comment below each commit-message.

Thanks a lot for your work here!
If you're working on any userspace programs, I would interested to
hear about it. Also feel free to use github.com/dvdhrm/xwiimote for
easier communications with the kernel driver. Although, this project
is still TODO ;)
David
