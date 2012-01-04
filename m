Return-Path: <cyrus@holtmann.org>
Subject: Re: About needing to run "udevadm trigger" to get bluetooth
 adapter detected at boot
From: Pacho Ramos <pachoramos@gmail.com>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1325714356.10711.2.camel@belkin4>
References: <1325714356.10711.2.camel@belkin4>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 Jan 2012 23:11:46 +0100
Message-ID: <1325715106.3277.1.camel@belkin4>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El mié, 04-01-2012 a las 22:59 +0100, Pacho Ramos escribió:
> Hello
> 
> I would like to know why do we need to run things like:
> udevadm trigger --subsystem-match=bluetooth --action=add
> 
> or even simpler:
> udevadm trigger
> 
> Manually or using a "bluetooth" init.d script to simply run that or,
> otherwise, bluetooth adapter is not detected. Reading OpenSuSE Changelog
> in their bluez package seems that this is caused because dbus needs to
> be running to get it detected. In that case, I would like to know why
> only bluez looks to be affected by this problem and, also, know if there
> is another way to workaround (or fix) this issue than needing to add a
> bluez init.d script to simply run this
> 
> Thanks a lot
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Looks like, on Gentoo, we have an init.d script that runs:
udevadm trigger --type=failed -v

after dbus is running, but looks like running udevadm trigger with
"--type=failed" option won't start bluetoothd... will investigate it a
bit more, sorry for the noise :S

