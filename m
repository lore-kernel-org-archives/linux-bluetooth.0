Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150717153000.GA18208@t440s.P-661HNU-F1>
References: <CANzaTi6_OF9C6DjPeRqaoUBKqdJZSQ+0k0cJLodWS3o5LzTsbw@mail.gmail.com>
	<20150716105937.GA18341@t440s.lan>
	<CANzaTi5gK457ZJP5V_ty6ufSzm2LmX6wsfVracqR0MwDZS6jyg@mail.gmail.com>
	<20150716131004.GA28916@t440s.P-661HNU-F1>
	<C1E229B1-274F-4B5B-81EA-A546488B07DD@holtmann.org>
	<CANzaTi6s3W1Q4sPZW9U32-oV8qmqDYYTdcDD8yNEohuH1PND7A@mail.gmail.com>
	<20150717153000.GA18208@t440s.P-661HNU-F1>
Date: Wed, 22 Jul 2015 12:53:38 +0200
Message-ID: <CANzaTi4fzd6tCgBYiZ5LahPpOLXitVcTMGsOEFibP+cExzQX7g@mail.gmail.com>
Subject: Re: Advertising API, possible to set LE only?
From: dogan yazar <doganyazar@gmail.com>
To: dogan yazar <doganyazar@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jul 17, 2015 at 5:30 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi dogan,
>
> On Fri, Jul 17, 2015, dogan yazar wrote:
>> Thanks! This worked well. Any hints for me to track down why
>> "ControllerMode=le in the [General] section of
>> /etc/bluetooth/main.conf" did not work fine? Running a shell command
>> from our software is not a very neat solution.
>
> Enable bluetoothd debug logs (-d command line switch) and check if
> there's anything suspicious when you start bluetoothd. Btw, which BlueZ
> version do you have? The ControllerMode option was first introduced in
> BlueZ 5.25.

Thanks! Apparently it was a cheap mistake on my side. Since I wanted
to test latest bluez, I have installed from the source files with
default configuration, the conf file I should have updated was under
/usr/local. So it works great now!
