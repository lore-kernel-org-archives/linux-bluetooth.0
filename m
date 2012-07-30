Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jul 2012 15:52:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [RFC v2] DBus OutOfBand API update
Message-ID: <20120730125230.GA16470@x220.ger.corp.intel.com>
References: <1343391723-32072-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343391723-32072-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Jul 27, 2012, Szymon Janc wrote:
> - short name vs full name distinguish

I don't think we need the distinction. Just support full name.

> - emit DeviceDisappeared when removing oob data?

I suppose we could, not that I feel particularly strongly either way.

> - enable OOB interface only for BLE and/or SSP capable adapters?

I'd just return org.bluez.Error.NotSupported for the methods.

Johan
