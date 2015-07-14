Return-Path: <cyrus@holtmann.org>
Message-ID: <a59e2e07885f3ee4bcb02cf370b3ff4c.squirrel@mungewell.org>
In-Reply-To: <1436873556.20249.50.camel@hadess.net>
References: <55A4BA19.6030109@gmail.com>
    <1436873556.20249.50.camel@hadess.net>
Date: Tue, 14 Jul 2015 12:54:37 -0400
Subject: Re: Reaching out again for serious bug in sixaxis plugin
From: simon@mungewell.org
To: "Bastien Nocera" <hadess@hadess.net>
Cc: "Sergey Kondakov" <virtuousfox@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	"Antonio Ospite" <ospite@studenti.unina.it>,
	"Szymon Janc" <szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


>> Details are in
>> http://article.gmane.org/gmane.linux.bluez.kernel/62305

> The device is connected correctly via Bluetooth. Then the bug is in the
> device's input driver, which you could probably also see when it's
> connected via USB. The right forum for this is the linux-input mailing

As the original poster stated that this DOES NOT occur with a USB
connection, it does kind of point to a Bluetooth problem (or maybe with
device itself). Has anyone been able to replicate?

My suggestion would be to display/capture the hidraw interface and see if
the missing data is present there. This can be done as root with
--
$ hexdump -v -e '49/1 "%02x " "\n"' < /dev/hidraw0
--

The '49' is the byte count, and might be wrong (working from memory).


>> Also, this kernel patch or a better alternative still hasn't been
>> applied and that's no good:
>> https://patchwork.kernel.org/patch/1075972/

The multi-touch/many-axis stuff is a pain, but the linux-input list is the
place to discuss that...
Simon


