Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <44EE5C37ADC36343B0625A05DD408C485068EDD151@CHEXMB-01.global.atheros.com>
References: <44EE5C37ADC36343B0625A05DD408C485068EDD151@CHEXMB-01.global.atheros.com>
Date: Wed, 8 Jul 2009 16:43:10 -0300
Message-ID: <2d5a2c100907081243n27574598k143d2d568018492b@mail.gmail.com>
Subject: Re: A2DP issue with latest BlueZ in Ubuntu 9.04
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jothikumar Mothilal <Jothikumar.Mothilal@atheros.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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
