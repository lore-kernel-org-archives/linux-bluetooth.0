Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Jul 2015 18:30:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: dogan yazar <doganyazar@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: Advertising API, possible to set LE only?
Message-ID: <20150717153000.GA18208@t440s.P-661HNU-F1>
References: <CANzaTi6_OF9C6DjPeRqaoUBKqdJZSQ+0k0cJLodWS3o5LzTsbw@mail.gmail.com>
 <20150716105937.GA18341@t440s.lan>
 <CANzaTi5gK457ZJP5V_ty6ufSzm2LmX6wsfVracqR0MwDZS6jyg@mail.gmail.com>
 <20150716131004.GA28916@t440s.P-661HNU-F1>
 <C1E229B1-274F-4B5B-81EA-A546488B07DD@holtmann.org>
 <CANzaTi6s3W1Q4sPZW9U32-oV8qmqDYYTdcDD8yNEohuH1PND7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANzaTi6s3W1Q4sPZW9U32-oV8qmqDYYTdcDD8yNEohuH1PND7A@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi dogan,

On Fri, Jul 17, 2015, dogan yazar wrote:
> Thanks! This worked well. Any hints for me to track down why
> "ControllerMode=le in the [General] section of
> /etc/bluetooth/main.conf" did not work fine? Running a shell command
> from our software is not a very neat solution.

Enable bluetoothd debug logs (-d command line switch) and check if
there's anything suspicious when you start bluetoothd. Btw, which BlueZ
version do you have? The ControllerMode option was first introduced in
BlueZ 5.25.

Johan
