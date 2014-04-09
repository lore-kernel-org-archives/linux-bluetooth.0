Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Removing GAttrib.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25TTcq7=+rkLZ0LO6Zmp9oatsjfqxDL-TxZaKVfk96mPbw@mail.gmail.com>
Date: Tue, 8 Apr 2014 18:28:19 -0700
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	lukasz.rymanowski@tieto.com
Message-Id: <7D219F6D-037F-4B02-BEDB-FD787867F1B3@holtmann.org>
References: <CAHrH25QBL52xfM4Qnk=NE1xn3RX2Bwxq_i0osDDCoi4egO2tkg@mail.gmail.com> <CAKT1EBfqP75+XJWkLt2yvkdEBVmNRmFC1_T667LAnuBrNFBxuQ@mail.gmail.com> <CAHrH25TeYWXMxQPqBGd9YnNWw+y5sYT+k4e-88hu_SRtFYWY+g@mail.gmail.com> <B767FC90-10FE-41A1-8607-90F8D3F18BD1@holtmann.org> <CAHrH25QWJKOVstwGHW3oY6U-sF4zCRP2sPCkSJSqi2y8yOvY4w@mail.gmail.com> <8B6D3E26-762A-490C-9E33-A8E8357C97F5@holtmann.org> <CAHrH25TTcq7=+rkLZ0LO6Zmp9oatsjfqxDL-TxZaKVfk96mPbw@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> I am pretty open on how many steps we want to take at a time or what we want to do later. What I know for sure is that I
>> want to rid of GIOChannel and BtIO usage and GLib.
> 
> I agree with everything you described and I think a clean GLib-free
> implementation that can be shared among Linux and Android code is the
> way to go. My only concern is that a D-Bus GATT client API is much
> needed for Chromium and I'm concerned that the big overhaul involved
> in removing BtIO and GLib is going to take too long.
> 
> So my question is this: how open would you be for an initial GATT
> client API that uses the existing code in attrib/* internally? I'm
> thinking of something very similar to how android/gatt.c has been
> implemented so far. So what I have in mind is:
> 
>     - The bt_gatt structure you mentioned, lives in src/shared/gatt.*
> and internally uses GAttrib, etc. The code is D-Bus free and could be
> used by the GATT client code in android/gatt as well.
>     - D-Bus code added to src/gatt-dbus.* to expose client objects.
> This code talks to src/shared/gatt.*.
>     - src/device.* and profiles modified to use the new API with no
> explicit GIOChannel usage.

I have no problem in doing this in parallel and take smaller or different steps. My main point is that everybody knows where we need to go in the long term.

> What I'm suggesting is basically to make the daemon use the new API
> first and implement the new API with the existing GLib based code so
> that we have at least some implementation to work with for Chromium
> (and we isolate GLib usage to one place as far as GATT is concerned),
> and THEN implement bt_gatt, bt_att etc. the proper way. Is this
> something that you would be open to upstreaming? My primary concern is
> simply the amount of time it will take to implement a new ATT/GATT
> endpoint but if you believe that we should absolutely do it the right
> way the first time around then it's not the end of the world.

Go ahead with it. Internal refactoring is simple. Just plan to have unit tests included that check will ensure that all changes you make are tested.

We did this for AVDTP, AVRCP and now MCAP for our refactoring to make code shareable between Android and upstream.

Regards

Marcel

