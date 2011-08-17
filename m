Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBebYWwjNURbciEM9s3saKX5tYHp2Jtr-VTcqV+eUrMSvA@mail.gmail.com>
References: <CAKT1EBfK1P7oJpLrm2HNTQTOKoN0Z+6mh7BoeaVeA8gUQpD49g@mail.gmail.com>
	<AFCDDB4A3EA003429EEF1E7B211FDBBA33A435FBDE@EXDCVYMBSTM005.EQ1STM.local>
	<CAKT1EBebYWwjNURbciEM9s3saKX5tYHp2Jtr-VTcqV+eUrMSvA@mail.gmail.com>
Date: Wed, 17 Aug 2011 10:38:35 -0300
Message-ID: <CAKT1EBem4esSBXuBbsaabKDbbOiFoNuT3c--x1Gd_oDYrizNJw@mail.gmail.com>
Subject: Re: Current status on BLE development
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here is a new status update of the BLE development. Changes since the
first status report:
1. SM patches refactoring based on the comments of the maintainers in the ML
2. Use the LTK after receiving a LE Security Request: basically for
re-connections
3. initial LE scanning before connections(re-connections) if the entry
is not found in the cache (unstable)

Proximity Link Loss and Find are now working. Tested using real
hardware(key fobs).
Proximity Path Loss needs improvement, is there someone in the BlueZ
ML interested in helping us?
At the moment we are using hard-coded values for RSSI thresholds:
-60(low RSSI threshold) and -75(high RSSI threshold)
We need to improve the logic to define the SignalLevel(good, regular,
weak) properly based on the measured RSSI, Remote TX Power and other
parameter that could influence the results.


* Unstable kernel with Interleaved Discovery, RSSI Threshold monitor,
LE scanning and remaining SM patches
[1] http://git.infradead.org/users/vcgomes/linux-2.6.git (branch
proximity-integration)

* BlueZ Userspace
[2] git://git.infradead.org/users/cktakahasi/bluez.git proximity-devel

Regards,
Claudio
