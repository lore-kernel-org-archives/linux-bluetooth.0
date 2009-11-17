Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Nov 2009 14:16:58 +0100
From: Vladimir Botka <vbotka@gmail.com>
To: Thilo =?UTF-8?B?Umllw59uZXI=?= <thilo@riessner.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluetooth dead after suspend
Message-ID: <20091117141658.355fc829@vlado>
In-Reply-To: <200911171333.47667.thilo@riessner.de>
References: <200911171333.47667.thilo@riessner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 17 Nov 2009 13:33:47 +0100
Thilo Rießner <thilo@riessner.de> wrote:

> Hello, my bluetooth works fine after normal boot, bat after
> suspending and resuming, it is dead. With my old installation
> (openSuSE 11.1) it was the same, but the problem could be solved by
> restarting bluetooth (rcbluetooth restart). With the new openSuSE
> 11.2 the rcbluetooth script vanished. As far as I understood,
> bluetooth gets started via dbus. But even a rcdbus restart does not
> help. Any idea of a quirk or workaround? Thanks in advance for any
> help.

Hello. If your notebook is an ThinkPad you may try to copy the script
[1] into the directory [2]. If this does not help you may consider to
open a bug report in [3] and attach the suspend log file [4].

[1] /usr/share/doc/packages/pm-utils/examples/hooks/49bluetooth
[2] /usr/lib/pm-utils/sleep.d/
[3] bugzilla.novell.com
[4] /var/log/pm-suspend.log

Cheers,
-- 
	-vlado
	Vladimir Botka

