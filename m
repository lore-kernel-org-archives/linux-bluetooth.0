Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <98391a7b0908240413u371c4392r2c9f92ee85a97081@mail.gmail.com>
References: <98391a7b0908240413u371c4392r2c9f92ee85a97081@mail.gmail.com>
From: =?ISO-8859-1?Q?Nicol=F2_Chieffo?= <nicolo.chieffo@gmail.com>
Date: Thu, 27 Aug 2009 10:39:47 +0200
Message-ID: <98391a7b0908270139s1cf9464g60eaf5d0ac5f466c@mail.gmail.com>
Subject: Re: can't pair cellphone
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've also tried the test scripts in bluez (this problem appears only
in ubuntu karmic, not in jaunty)

Things I've done before making this test:
* remove the pairing in the phone *
* disable bluetooth *
* poweroff phone *
* poweron phone *
* enable bluetooth *

Here's some command outputs:

$ hcitool scan:
Scanning ...
       xx:xx:xx:xx:xx:xx       Chievo

$ source/bluetooth/bluez-4.48/test/
$ ./simple-agent hci0 xx:xx:xx:xx:xx:xx remove
Creating device failed: org.bluez.Error.ConnectionAttemptFailed: Page Timeout

$ ./simple-agent hci0 xx:xx:xx:xx:xx:xx
Creating device failed: org.bluez.Error.ConnectionAttemptFailed: Page Timeout

Can it be a kernel problem?
