Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1511532646.11411.11.camel@hadess.net>
Subject: Re: [PATCH] plugins/sixaxis: Don't ignore previously setup devices
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 24 Nov 2017 15:10:46 +0100
In-Reply-To: <20171108112452.9703-1-hadess@hadess.net>
References: <20171108112452.9703-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2017-11-08 at 12:24 +0100, Bastien Nocera wrote:
> 1. Setup PS3 controller through cable pairing
> 2. Remove device from BlueZ's database
> 3. Plug original PS3 controller back
> 
> As we don't change the master bdaddr on the device itself, the joypad
> will likely be trying to connect to BlueZ, and fail to connect after
> a
> small period of time. But the device will appear connected just long
> enough for the cable pairing to say "hey, I already have this setup".
> 
> Ideally, we would test for whether the device is temporary, or
> already
> trusted, but testing for whether we've setup its internal services
> *and*
> it's connected, rather than *or*, is sufficient.

This is still relevant. Szymon, could you please test this?
