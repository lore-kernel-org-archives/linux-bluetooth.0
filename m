Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD0=r8w035mLnWTKtEfxZ7agzwTFRO9dsv+6qdafcBG7RYzYDQ@mail.gmail.com>
References: <CAD0=r8yozB8eMdJOuffUeQZVFVf5xEXnP5tCt+k3m0e9wzMxiA@mail.gmail.com>
	<735FD32E-BD15-4CE1-8D9C-44B8EC56DF7A@holtmann.org>
	<CAHrH25Q6XqsLjGyfoXwimrap9=kKHOQn-G=k4Fz6HXmEPJ7EtQ@mail.gmail.com>
	<20140917051457.GA4671@t440s.P-661HNU-F1>
	<CAD0=r8x-=O7XAqQF_wBHQEqSkfifzgWW2AagW2EvsDUtM-E_ow@mail.gmail.com>
	<20140917065252.GA5554@t440s.lan>
	<CAD0=r8z9g+F7Z9X_8PE4jk3JbA+oLj9Of33RSqxiRd0dn9AnXQ@mail.gmail.com>
	<8868B74C-0DDD-43C1-BCBF-2578A700EF72@holtmann.org>
	<CAD0=r8xQzhizXo4umQ_mG_WMH7Akp4bji-9PNRGzqj-7HWnyNA@mail.gmail.com>
	<0EA633E6-A0F5-4F67-B421-9857466C1175@holtmann.org>
	<CAD0=r8w035mLnWTKtEfxZ7agzwTFRO9dsv+6qdafcBG7RYzYDQ@mail.gmail.com>
Date: Fri, 19 Sep 2014 09:44:37 -0700
Message-ID: <CAD0=r8zXV-b0D6dxY2ifAx-FCa9K0SP0jwr2Bq292gbHAmHWaA@mail.gmail.com>
Subject: Re: [RFC] need for new scan api for bluetooth low energy.
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, Scott James Remnant <keybuk@google.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

I will be very happy with mgmt api method that will filter by serice
uuid and RSSI value, and that's enough for me. From my use case it
looks like the user is going to be in this scan state for short time -
few seconds, maximum minute.

If it would be possible to also add general le scan method that would
return all advertisements, marked as "only for development", and "not
for use in production", and "behaves differently for different
controllers" and maybe somehow disabled by default and you need to set
some special flag to enable it on your developer machine then it would
be awsome for developers that want to play with it, but it's not my
requirement.

>
>
> >>
> >> The real problem is that controllers behave so different when you talk=
 about advertising event report. So even if you have duplicate filtering on=
 or off they have different behaviors. And that is where the real challenge=
 comes into play here. What works on one controller just fine, might turn i=
nto a huge battery drain on the other.
> >>
> >
> > Thanks for pointing that out, I've already heard that argument from
> > Scott before, and it'll require more investigation.
> >
> >> Get a few different controllers, Marvell, Intel, CSR and Broadcom and =
play with hcitool lescan to see the different behavior they provide. You ca=
n also write your own small little HCI program using the HCI User Channel f=
eature we added in 3.13 and use src/shared/hci.c as helper for handling HCI=
 commands. You really need to understand what you are getting yourself into=
 here.
> >
> > I've already implemented my functionality first using BLED112 dongle,
> > and then on linux using HCI api and tested it on two controllers, but
> > from what I understood MGMT is the  API of future. Also I want to make
> > it work for all controllers, not only those three.
>
> This is not for an official API. You can not use HCI User Channel and mgm=
t at the time. They are mutually exclusive. Actually when opening a HCI Use=
r Channel you will see that the controller index disappears from the mgmt i=
nterface.


I was forced to use HCI, because mgmt didn't exposed required
functionality (the scan I want to add). And I want my code to work in
the future without causing the controller to disapear from mgmt.

>
>
> What I am saying is that you need to get yourself some understanding on h=
ow certain controllers from certain manufactures behave if you for example =
turn on/off the duplicate filtering. And then also have a rather busy LE en=
vironment with a bunch of devices advertising. Get a few beacons that are c=
onstant advertising and get a feel on what is going on on HCI. You will qui=
ckly see that we have to be smarter than just keep scanning. And for kicks,=
 try to use BR/EDR for say A2DP at the same time. See how that goes.


>
>
> >>
> >> My main concern is battery drain. Once we figured out on how to avoid =
that, we can easily design a new mgmt command that allows you to do exactly=
 what you want to do.
> >
> > From what I understand as long as controllers don't support
> > sophisticated filtering, that would be energy conuming. I would also
> > preffer to find a energy-friendly way, but is it better not to have
> > this functionality rather than have it in non-energy consuming way ?
>
> Even if we consume extra energy on older Bluetooth chips or certain manuf=
actures, we want to try to not waste it. If it drains your battery, people =
will just disable Bluetooth and then you have not won anything.
>
> Maybe what this really needs is that we go into the Bluetooth SIG and pro=
pose controller based filtering with standard HCI commands.


Controller based filtering would be awsome, but it would probably take
2-3 years to get first controller that do it, and I hope to be able to
ship my functionality in maybe 2-3 months.

>From current discussion it seems that it's achievable to implement it
in kernel right now, and eventually talk with manufacturers to make it
standard in future.

>
> Regards
>
> Marcel
