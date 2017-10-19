Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6AEB9243C1923B41A52689D49F0E099ED2F75E@insys-exchange.INSYS-GROUP.LAN>
References: <CAPeBu71a96x2ciRKRqGis7SOeKvxEVTpRejhv+W64YONANC+2w@mail.gmail.com>
 <6AEB9243C1923B41A52689D49F0E099ED2F75E@insys-exchange.INSYS-GROUP.LAN>
From: Matthew Hazley <lists@matthazley.com>
Date: Thu, 19 Oct 2017 11:19:49 +0100
Message-ID: <CAPeBu723rVqA2AwPLU+qSxak+z9d1cCgEGU3iBeUVbCAE6A-OQ@mail.gmail.com>
Subject: Re: BlueZ Peripheral: Detect Connection from Remote Device and Read RSSI
To: Libor Peltan <lpeltan@insys-tec.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for your comment.

> It seems to me that all the events and value changes result in DBus messages around. You can watch them with dbus-monitor first, and write your own app listening and filtering them later.

I will play with this idea but I am unsure if any dbus messages make
it into userspace before a characteristic interaction takes place.

Regards,
Matt
