Return-Path: <cyrus@holtmann.org>
Message-ID: <4BE270EE.5080306@greffrath.com>
Date: Thu, 06 May 2010 09:34:06 +0200
From: Fabian Greffrath <fabian@greffrath.com>
MIME-Version: 1.0
To: Serhiy Kachaniuk <serzholino@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [bugreport]
References: <p2q793f89501005052222u4393c8dfhb55bea4454c454b9@mail.gmail.com>
In-Reply-To: <p2q793f89501005052222u4393c8dfhb55bea4454c454b9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 06.05.2010 07:22, schrieb Serhiy Kachaniuk:
> My USB bluetooth adapter stopped working with new versions of bluez.
> Latest version which works is 4.32.
> I initially reported bug for ubuntu package in launchpad here
> https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/453885 , but then
> i tried also opensuse livecd and problem remained there too, so looks
> like it's not ubuntu specific.

Could you please post the output of 'sudo hciconfig -a'? I am 
especially interested in the Name part.
