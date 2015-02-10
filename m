Return-Path: <cyrus@holtmann.org>
Message-ID: <54D9D9B1.30800@endlessm.com>
Date: Tue, 10 Feb 2015 10:13:05 +0000
From: Mario Sanchez Prada <mario@endlessm.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Larry.Finger@lwfinger.net
Subject: Re: No SCO packets while trying to use a Bluetooth headset
References: <54D4D012.4050108@endlessm.com>
In-Reply-To: <54D4D012.4050108@endlessm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi again,

Just a quick heads up about the problem mentioned a few days ago (see [1]) to let you know that I've recently (yesterday) tried the latest kernel 3.19 and that did not make any difference either. I've tested this by applying Daniel's patch to add support for the RTL8723BE bluetooth device (see [2]) on top of the v3.19 tag from the kernel git repository, and I also used the latest release of BlueZ and PulseAudio, so the problem seems to be still relevant even with the latest code.

At this point it's not clear to me what the problem could be, so I'd really appreciate any comment that might help fix or improve this situation. Larry Finger, I'm adding you to Cc as I understand you are the go-to person for these drivers, in case you could drop some light on this problem (e.g. perhaps you've seen something similar before?).

Thank you all,
Mario

[1] http://article.gmane.org/gmane.linux.bluez.kernel/58759
[2] http://article.gmane.org/gmane.linux.bluez.kernel/58810
