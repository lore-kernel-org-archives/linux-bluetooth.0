Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1267180169.32051.20.camel@flashheart.burtonini.com>
References: <1267100354.22889.16.camel@flashheart.burtonini.com>
	 <2d5a2c101002260124w2a526e5bh4622af9658e179c0@mail.gmail.com>
	 <1267180169.32051.20.camel@flashheart.burtonini.com>
Date: Fri, 26 Feb 2010 13:58:13 +0200
Message-ID: <2d5a2c101002260358v48b09f0fh21a5be28ec76696c@mail.gmail.com>
Subject: Re: DiscoverableTimeout not working as expected
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ross Burton <ross@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ross,

On Fri, Feb 26, 2010 at 12:29 PM, Ross Burton <ross@linux.intel.com> wrote:
> On Fri, 2010-02-26 at 11:24 +0200, Luiz Augusto von Dentz wrote:
>> I got a different behavior (using git tree and testtest-adapter):
>>
>> signal sender=:1.65 -> dest=(null destination) serial=151
>> path=/org/bluez/3359/hci0; interface=org.bluez.Adapter;
>> member=PropertyChanged
>>    string "DiscoverableTimeout"
>>    variant       uint32 10
>> signal sender=:1.65 -> dest=(null destination) serial=160
>> path=/org/bluez/3359/hci0; interface=org.bluez.Adapter;
>> member=PropertyChanged
>>    string "Discoverable"
>>    variant       boolean true
>> signal sender=:1.65 -> dest=(null destination) serial=161
>> path=/org/bluez/3359/hci0; interface=org.bluez.Adapter;
>> member=PropertyChanged
>>    string "Class"
>>    variant       uint32 6430988
>> signal sender=:1.65 -> dest=(null destination) serial=162
>> path=/org/bluez/3359/hci0; interface=org.bluez.Adapter;
>> member=PropertyChanged
>>    string "Discoverable"
>>    variant       boolean false
>> signal sender=:1.65 -> dest=(null destination) serial=163
>> path=/org/bluez/3359/hci0; interface=org.bluez.Adapter;
>> member=PropertyChanged
>>    string "Class"
>>    variant       uint32 6422796
>
> Interesting.  Using test-adaptor and bluez 4.60 (debian sid), I don't
> see that behaviour.  I also can't see anything relevant in the git
> log. :(

Please check if someone isn't sending
SetProperty("DiscoverableTimeout", 0), that will cancel the timeout
which seems the exact behavior that you are seeing with your
application, bluetooth-applet on ubuntu does that when I select Make
computer discoverable it set the timeout to 0.


-- 
Luiz Augusto von Dentz
Computer Engineer
