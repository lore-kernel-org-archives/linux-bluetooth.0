Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <830792141.4253161258419999163.JavaMail.root@sz0149a.westchester.pa.mail.comcast.net>
References: <232854869.4251721258419865790.JavaMail.root@sz0149a.westchester.pa.mail.comcast.net>
	 <830792141.4253161258419999163.JavaMail.root@sz0149a.westchester.pa.mail.comcast.net>
Date: Tue, 17 Nov 2009 09:56:57 +0200
Message-ID: <dfb262380911162356g750dfdbfu4d0b67ae3ce567c4@mail.gmail.com>
Subject: Re: bluetooth audio fails
From: Ramagudi Naziir <naziirr@gmail.com>
To: marjnkl@comcast.net
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mark,

On Tue, Nov 17, 2009 at 3:06 AM,  <marjnkl@comcast.net> wrote:
> Is this the agent that comes with bluez?

yes: bluez-git/test/agent.c

> You should have a directory in /var/lib/bluetooth with the mac address of your bluetooth device.

for some reason it is not being created. weird.


>> (bluetoothd:1260): GLib-CRITICAL **: g_key_file_get_boolean:
>> assertion
>> `key_file != NULL' failed
>> ...
>
> I do not get anything like this.  Do you get this when you run hciconfig hci0 up?

yes

> It really seems that your bluetooth device is not fully recognized by the OS.  Do you have all the drivers needed for the bluetooth device?  How is your device attached (e.g usb, pci)?

it's a UART device. and it looks like it works pretty good - I got
rfcomm to work with my laptop (which means scan, connect, pair worked,
and I got a binded /dev/rfcomm0 that I could write to and read from
and see the laptop data).


Thank you!
naziir
