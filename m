Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 Sep 2011 12:55:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ 02/11] Add set auto connect in device
Message-ID: <20110905095532.GA6735@dell.ger.corp.intel.com>
References: <1314999521-11261-1-git-send-email-claudio.takahasi@openbossa.org>
 <1314999521-11261-3-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314999521-11261-3-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Sep 02, 2011, Claudio Takahasi wrote:
> +void btd_adapter_system_unlocked(struct btd_adapter *adapter)
> +{
> +	if (!adapter->up)
> +		return;
> +
> +	DBG("Unlocked");
> +
> +	g_slist_foreach(adapter->devices, set_auto_connect, NULL);
> +}

While the concept seems fine I think you've got the wrong name for the
function. You shouldn't assume that "system unlocked" is the only reason
for enabling auto-connect for the devices. It's as if you'd be pushing
policy into the core daemon ("if unlocked, then auto-connect"). Instead
the function should be named according to what it does, e.g.
btd_adapter_enable_auto_connect or btd_adapter_auto_connect_devices.

Johan
