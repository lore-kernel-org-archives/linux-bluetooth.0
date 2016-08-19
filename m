Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Anthony Bourguignon <contact@toniob.net>,
        linux-bluetooth@vger.kernel.org
Subject: Re: Can't connect a Xbox one controller
In-Reply-To: <1471515072.4976.10.camel@toniob.net>
References: <1471515072.4976.10.camel@toniob.net>
Date: Fri, 19 Aug 2016 15:02:12 -0300
Message-ID: <8760qwy6vv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anthony,

Anthony Bourguignon <contact@toniob.net> writes:

> Hi,
>
> I've recently bought a new xbox one controller as the 2016 version has
> bluetooth connectivity.
>
> The controller is pairing and connecting well on a windows 10 computer
> and an android 4.4 tablet. But I can"t make it connect under linux
> (Debian unstable, kernel 4.6 and 4.7-rc7, bluez 5.40 from
> experimental). The pairing is ok but when I try to connect to
> controller, it stays connected for less than one second, then
> disconnects, then connects again and so one until the controller goes
> to sleep, because of the lack of a remote connection.

Can you produce the logs with L2CAP ERTM/Streaming mode disabled,
doing something like this before connecting this should work:

$ echo 1 > /sys/module/bluetooth/parameters/disable_ertm


Cheers,
--
Vinicius
