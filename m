Return-Path: <cyrus@holtmann.org>
Message-ID: <1331489824.14217.69.camel@aeonflux>
Subject: Re: [PATCH 0/2] DeviceInfo and BatteryService Clients
From: Marcel Holtmann <marcel@holtmann.org>
To: chen.ganir@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Chen Ganir <chen.ganir@ti.com>
Date: Sun, 11 Mar 2012 11:17:04 -0700
In-Reply-To: <1331470642-23924-1-git-send-email-chen.ganir@ti.com>
References: <1331470642-23924-1-git-send-email-chen.ganir@ti.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

> Adding Battery Service client and Device Information Service Client stubs.
> More logic will be added to these service as development continues.
> To enable the new features you will need to use:
> --enable-batterystate
> --enable-deviceinfo

I rather have us reducing the number of configure options. Do we really
need these? I would just enable them all by default.

Regards

Marcel


