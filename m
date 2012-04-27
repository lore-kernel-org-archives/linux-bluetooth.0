Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120427174439.GC16207@tuxdriver.com>
References: <20120322192406.GB2432@tuxdriver.com>
	<1332698585.1870.88.camel@aeonflux>
	<20120326145433.GE13806@tuxdriver.com>
	<1332774906.1870.98.camel@aeonflux>
	<20120326152541.GH13806@tuxdriver.com>
	<20120427174439.GC16207@tuxdriver.com>
Date: Sat, 28 Apr 2012 00:40:17 +0300
Message-ID: <CAMXE1-ojy-SnZxdZKMiL+ouiZWDnj_V1axTK713Y78fBPi3Rmw@mail.gmail.com>
Subject: Re: CFP -- Linux Wireless (802.11/Bluetooth/NFC) Mini-Summit 2012 (Barcelona!)
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-wireless@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, alexander.smirnov@siemens.com,
	Sergey.Sobolev@siemens.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

On Fri, Apr 27, 2012 at 8:44 PM, John W. Linville
<linville@tuxdriver.com> wrote:
> Now, we need some talk proposals! =A0Please post in this thread (or
> contact me or Marcel directly if necessary) to propose talks. =A0I would
> love to see any topics on any relevant technologies, as well as topics
> about how the projects are being managed, new sub-projects, etc.
> It seems like a long time away right now, but it is a good time to
> start thinking... :-)

I propose to talk about Software / Virtual Bluetooth AMP Controller (softam=
p).
It can be implemented through wireless stack in mac80211.

AMP is Alternate MAC/PHYs Controller for Bluetooth sybsystem.
When an AMP is common between the two devices, the Bluetooth system
provides mechanisms for moving data traffic from BR/EDR Controller to
an AMP Controller.

I've recently posted RFC which implement some functionality and can be used
as example of interfaces.

Regards,
Andrei
