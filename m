Return-Path: <cyrus@holtmann.org>
From: Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 9 Jul 2009 14:08:28 +0530
Subject: RE: A2DP issue with latest BlueZ in Ubuntu 9.04
Message-ID: <44EE5C37ADC36343B0625A05DD408C485068EDD268@CHEXMB-01.global.atheros.com>
References: <44EE5C37ADC36343B0625A05DD408C485068EDD151@CHEXMB-01.global.atheros.com>
 <20090709070808.GA11972@jh-x301>
In-Reply-To: <20090709070808.GA11972@jh-x301>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



-----Original Message-----
From: Johan Hedberg [mailto:johan.hedberg@gmail.com]
Sent: 09 July 2009 12:38
To: Jothikumar Mothilal
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: A2DP issue with latest BlueZ in Ubuntu 9.04

Hi Jothi,

On Wed, Jul 08, 2009, Jothikumar Mothilal wrote:
> I am able to hear songs properly using mplayer.
>
> I have upgraded the BlueZ version 4.44 in the same setup by manual compile.
> A2DP not working...and found following line in bluetoothd daemon output
>
> "bluetoothd[17495]: Invalid seid 0"
>
> Pairing is ok. Mplayer throws an error message.
>
> I am not able to track what is the issue.
> Any once faces such issue? Let me know how to fix this issue.

The "Invalid seid" message is coming from audio/unix.c. The value is
indeed invalid (since in the hcidump your headset reports to have SEID 1
and 6 and bluetoothd configures a stream to SEID 1) and it is being sent
by the UNIX socket client (i.e. your alsa player) to bluetoothd.

The reason why your player is sending invalid data to bluetoothd could be
that you're using an old version of the bluetooth alsa plugin with a new
version of bluez. To fix this make sure that you don't have any old
libasound_module_pcm_bluetooth.so lying around in /usr/lib/alsa-lib or
/usr/local/lib/alsa-lib and install the new version there instead.

Johan

Hi,
I installed latest alsa library and tried. Same behavior found.

-- Jothi
