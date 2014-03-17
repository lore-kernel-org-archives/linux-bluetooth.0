Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CALdY0K68bHDmg+7hpi3d_E5Ti+BJd2nCm+O8-DO1YukErFT+WA@mail.gmail.com>
References: <CALdY0K5NNrrWdY73e44kp+QNxF2dizEyU44ny9k5h1YFQDf21w@mail.gmail.com>
	<CAJdJm_Myxh+i50v+0bMJgDCActz4Na_fZdVbNuNjwCE7Bss_kQ@mail.gmail.com>
	<CALdY0K6u0ZrJM-z7YKd2zmDzPStX2azVO-v4LUa385Ziq4uzOA@mail.gmail.com>
	<CAJdJm_PE5U4ePHg7rb2Q1dxXKy0=5KH1tyjzif0tcuSQCcf6Fg@mail.gmail.com>
	<CALdY0K7WAnRAoBWLrp2YsmpC35EixpqpByj7bvbL-EqxZkt6=Q@mail.gmail.com>
	<CALdY0K68bHDmg+7hpi3d_E5Ti+BJd2nCm+O8-DO1YukErFT+WA@mail.gmail.com>
Date: Mon, 17 Mar 2014 13:50:35 -0400
Message-ID: <CAJdJm_NhCvJDY4RypGKxkCwNd5qd_GxgLN_KEn9VjxtexCZTWw@mail.gmail.com>
Subject: Re: Bluetooth low energy with gatttool and jawbone
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Christian Bianchini <christian.bianchini@euservers.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Mon, Mar 17, 2014 at 12:30 PM, Christian Bianchini
<christian.bianchini@euservers.net> wrote:
> Tried to connect with bluez:
> $ sudo bluez-simple-agent hci0 DC:7A:F8:10:AF:A5
> Creating device failed: org.bluez.Error.ConnectionAttemptFailed: Page Timeout

If you are using a 4.x BlueZ, you must run "test-discovery" until the
device appears, and then attempt the simple-agent command above. This
will feed an internal cache that allows BlueZ to know that this
address is from a LE device, not a BR/EDR one. Since BlueZ 5.0, this
is not necessary anymore.

If this does not work, please post the output from hcidump when you
run the "bluez-simple-agent" command.

> Stupid question, how do I read the firmware version? Sorry to ask
> silly questions but this my first attempt to use this kind of "AT
> commands" via GATT

Given that your connection is dropping after a few seconds, it is
difficult to run commands on the gatttool prompt before fixing this
connection timeout issue. Try running test-discovery + simple-agent as
described above, and then try gatttool again and see if it stays
connected.

> Here is the dump:
> [...]

Unfortunately, the log only says your device is disconnecting due to
"Connection Timeout". Are you getting this same error every time? And
for how long the link stays up before disconnecting? (you can pass
"-t" to hcidump to show the timestamp so you can measure easily).

This error usually means there is a poor connection between your
machine and the device, or that the device "disappeared" (i.e. became
out of range). Is the device fully charged?

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
