Return-Path: <cyrus@holtmann.org>
Message-ID: <50573B3E.7050003@butterbrot.org>
Date: Mon, 17 Sep 2012 17:01:18 +0200
From: Florian Echtler <floe@butterbrot.org>
MIME-Version: 1.0
To: David Herrmann <dh.herrmann@googlemail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Wii Balance Board vs. bluez
References: <5050F5A9.5090401@butterbrot.org> <CANq1E4RYuVy2b1GD2E4MsErbkGZgD6gnDaYeDmyWyYnKaze0Jg@mail.gmail.com> <ed6fbaf1-1410-4539-a36e-1d6d6f6220b5@email.android.com> <CANq1E4RmacRAkTVtRt2JH_+V=qn1AH3iJWZZS_LCqmj_yt4DoQ@mail.gmail.com> <CANq1E4S70tqhTG7PTMj5cHp45NLO9g4n1eLVaHJMuDZx1KMYjg@mail.gmail.com> <5052519F.30803@butterbrot.org> <CANq1E4TRWGTdpiXsrR3uUp+n1jtptRnSaOp++LBKqyiRM0=eGg@mail.gmail.com> <50549F3C.8050406@butterbrot.org> <CANq1E4RE4ZhfvxhO=MdbMdwUZYrsdYnw=Yn7uLJE4gTAbHhOEw@mail.gmail.com>
In-Reply-To: <CANq1E4RE4ZhfvxhO=MdbMdwUZYrsdYnw=Yn7uLJE4gTAbHhOEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On 17.09.2012 11:47, David Herrmann wrote:
> On Sat, Sep 15, 2012 at 5:31 PM, Florian Echtler <floe@butterbrot.org> wrote:
>> never mind - I tested my patch again and noticed that the driver wasn't able
>> to read all 24 calibration bytes in one go, which was the root cause for not
>> getting any data (I am simply disabling the extension when not getting
>> proper calibration data).
> Thanks! I have both patches ready for submission. However, could you
> actually tell me in what range data is submitted? As I said, I cannot
> test these patches. But looking at the code, you get 16bit per value
> raw input. You then calculate the per-kg value and multiply it by
> 17kg. So I guess you fill up the whole 16bit?
> Your second patch does not adjust the MIN/MAX values for the ABS_HATXY
> values and I am just looking for good values here.
OK, I see - the advertised maximum weight for the balance board is 150 
kg. In theory, that would mean that every one of the 4 sensors can take 
up to 150 kg (if a very heavy person is standing on one foot right in 
the corner), which would translate to an absolute maximum value of 
15000. In "unweighted" state, my balance board reports slightly negative 
values for some sensors, so a minimum of perhaps -500 would be appropriate.

Thanks for integrating my patch!

Florian
-- 
SENT FROM MY PDP-11
