Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Jan 2015 10:14:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v1] core: device: Fix bugs in device_browse_gatt
Message-ID: <20150128081439.GA22704@t440s.lan>
References: <1422388746-23627-1-git-send-email-armansito@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422388746-23627-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, Jan 27, 2015, Arman Uguray wrote:
> This patch fixes two issues in GATT service browsing:
> 
> 1. There was a bug in gatt_client_ready_cb that broke GAttrib-based
> profiles by not creating gatt_primary structures if no browse request
> exists at the time.
> 
> 2. In device_browse_gatt, a response to "Pair" wasn't always being sent
> since the code didn't assign the DBusMessage pointer to the browse_req.

Please split this into two patches since these seem to be independent
issues.

> Change-Id: I9d2b24db19be9c55b971504750a1061df6366e84

And please leave this part out.

Otherwise the actual code changes look good to me.

Johan
