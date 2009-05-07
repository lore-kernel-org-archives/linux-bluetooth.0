Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <ac8af0be0905060528o6777bdc5l87399646d5471b2e@mail.gmail.com>
References: <1241601540-6540-1-git-send-email-forrest.zhao@intel.com>
	 <20090506093049.GA31559@localhost>
	 <ac8af0be0905060528o6777bdc5l87399646d5471b2e@mail.gmail.com>
Date: Thu, 7 May 2009 10:03:06 +0800
Message-ID: <ac8af0be0905061903o17a9ca4bj81269fac884c782@mail.gmail.com>
Subject: Re: [PATCH] in headset_init(), it's possible that hs->hfp_handle is
	not set, so we should not check hs->hfp_handle in headset_connect_cb()
From: Zhao Forrest <forrest.zhao@gmail.com>
To: Johan Hedberg <johan.hedberg@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>>
>> I don't see how that's a bug. hs->hfp_active should be true only when we
>> are connected to HFP. server_is_enabled(src, HANDSFREE_SVCLASS_ID) is
>> supposed to return true if HFP support is enabled in general. These are
>> two separate things (we could be connected to HSP even though HFP support
>> is enabled if the headset only supports HSP, i.e. hs->hfp_handle == 0 in
>> this case).
>>
> Let me describe how the bug is triggered by the following steps in our
> lab:
> 1 at HFP AW side bluetoothd is started, and headset_init() is called.
> However btd_device_get_record() returns NULL, so hs->hfp_handle is
> NULL.
> 2 at HFP HF unit side bluetoothd is started, and initiated connection to HFP AW
> 3 HFP AW accepts the connection, and headset_connect_cb() is called.
> At this time hs->hfp_handle is NULL, so hs->hfp_active is set to
> FALSE.
>
> This way the bug is triggered: a real HFP connection is initiated by HFP HF
> unit, but hs->hfp_active is set to FALSE by HFP AW. It seems that this patch
> is not a real fix, could you share the ideas of fixing this bug?
>
Johan,

After cleaning /var/lib/bluetooth/* and doing pairing from scratch,
this bug can't be reproduced. It seems that a messed-up SDP database
triggered the issue.

Thanks,
Forrest
