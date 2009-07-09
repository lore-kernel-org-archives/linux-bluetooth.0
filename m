Return-Path: <cyrus@holtmann.org>
From: Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 9 Jul 2009 12:10:41 +0530
Subject: RE: A2DP issue with latest BlueZ in Ubuntu 9.04
Message-ID: <44EE5C37ADC36343B0625A05DD408C485068EDD22D@CHEXMB-01.global.atheros.com>
References: <44EE5C37ADC36343B0625A05DD408C485068EDD151@CHEXMB-01.global.atheros.com>
 <2d5a2c100907081243n27574598k143d2d568018492b@mail.gmail.com>
In-Reply-To: <2d5a2c100907081243n27574598k143d2d568018492b@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



-----Original Message-----
From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
Sent: 09 July 2009 01:13
To: Jothikumar Mothilal
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: A2DP issue with latest BlueZ in Ubuntu 9.04

Hi,

On Wed, Jul 8, 2009 at 11:32 AM, Jothikumar
Mothilal<Jothikumar.Mothilal@atheros.com> wrote:
> I have upgraded the BlueZ version 4.44 in the same setup by manual compile.
> A2DP not working...and found following line in bluetoothd daemon output
>
> "bluetoothd[17495]: Invalid seid 0"

First check if you are installing alsa plugin correctly then run
bluetoothd with -dn so we can check what is going wrong on.

--
Luiz Augusto von Dentz
Engenheiro de Computação


Hi,
I have already installed alsa-utils, Bluez-alsa and gstreamer0.10-alsa.
Same setup works on Bluez 4.32. I am facing problem only in BlueZ 4.44.
I am wondering what else I am missing for BlueZ 4.44

Thanks,
Jothi
