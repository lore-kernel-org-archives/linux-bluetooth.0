Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+i+Aw2_ZJfBbqukwVXhrOeXTpRENTNPu+225zCLRfanM7c5eQ@mail.gmail.com>
References: <CAFVnFZafZxVJtZ1bSKSd1nSOSYBMnG9B_xs=+RqxR6OWpHUQog@mail.gmail.com>
	<CA+i+Aw2_ZJfBbqukwVXhrOeXTpRENTNPu+225zCLRfanM7c5eQ@mail.gmail.com>
Date: Thu, 25 Aug 2011 19:31:45 +0100
Message-ID: <CAFVnFZYvCrSE9320t=C8hEAoO01kCqTFudnkU_NTKQinAxzqRw@mail.gmail.com>
Subject: Re: MAP support in Obexd
From: "spaceindaver0@gmail.com" <spaceindaver0@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Just for confirmation - by "MAP Server" do you mean the MSE side -
i.e. what would reside on a phone?

My interests lie on the MCE side, the IVI headunit functionality. What
I would like in the end would be a sample email program that pairs
with a phone (with MAP support, e.g. HTC Sensation) grabs the emails
and displays them in a sample UI. How much (if any) of this is covered
by your work?

Quote from MAP spec
Message Server Equipment (MSE) – is the device that provides the
message repository engine i.e. has the ability to provide a client
unit with messages that are stored in this device and notifications of
changes in its message repository.
Message Client Equipment (MCE) – is the device that uses the message
repository engine of the MSE for browsing and displaying existing
messages and to upload messages created on the MCE to the MSE.

Regards,
David O Carroll

On Fri, Aug 19, 2011 at 9:36 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
> On Fri, Aug 19, 2011 at 8:06 PM, spaceindaver0@gmail.com
> <spaceindaver0@gmail.com> wrote:
>> Hi All,
>>
>> I am a student enetering my final year of study and would like to
>> contribute as part of my Final Year Project. I would like to implement
>> the MAP profile in obexd as I have an interest in developing for
>> bluetooth (and have done work in IVI where this would be usefull).
>>
>> Is anyone aware of anybody currently doing work in this area?
> Yes, the work on MAP server is ongoing. I'm developing a protocol
> infrastructure and Bartosz Szatkowski is working on backend for
> accessing messages stored in GNOME Tracker). Most of the functionality
> has been already coded but out of upstream tree and now it's being
> refactored to the form appropriate for upstreaming. You can already
> see small parts of it in obexd git tree (plugins/messages.h,
> plugins/mas.c, plugins/messages-*.c)
>
> --
> Slawomir Bochenski
>
