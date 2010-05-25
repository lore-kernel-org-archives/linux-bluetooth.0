Return-Path: <cyrus@holtmann.org>
Subject: Re: WRT non-UTF-8 device names
From: Bastien Nocera <hadess@hadess.net>
To: Fabian Greffrath <fabian@greffrath.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1274432516.4068.29.camel@vfrodo>
References: <1274432516.4068.29.camel@vfrodo>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 25 May 2010 13:38:39 +0100
Message-ID: <1274791119.27274.17718.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2010-05-21 at 11:01 +0200, Fabian Greffrath wrote:
> Dear Bluez list,
> 
> I am experiencing the following issues with the bluez 4.63-2 and
> gnome-bluetooth 2.30.0-1 packages from Debian unstable:

Stupid question, but do you use a UTF-8 locale, or not?

The output of "locale" as root would probably help.

My guess is that we make assumptions as to a user entry being valid
UTF-8 somewhere, when it could be non-UTF-8.

As for your problem, I don't think we want to allow non-UTF-8 device
names anyhow. They're not valid spec.

