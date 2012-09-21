Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 06/18] adapter: Handle missing randomizer in btd_adapter_add_remote_oob_data
Date: Fri, 21 Sep 2012 12:42:33 +0200
Message-ID: <1423134.oto9eW1DyT@uw000953>
In-Reply-To: <20120921101723.GA4441@x220>
References: <1348221750-15345-1-git-send-email-szymon.janc@tieto.com> <1348221750-15345-7-git-send-email-szymon.janc@tieto.com> <20120921101723.GA4441@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 21 of September 2012 13:17:23 Johan Hedberg wrote:
> Hi Szymon,

Hi Johan,

> 
> I'd rather have mgmt_add_remote_oob_data accept a NULL pointer and have
> the randomizer memcpy behind a NULL test (the code is anyway already
> initializing the send buffer to zeros).

Yes, that will be much better. Will send V2 of 06/18 in a minute.

-- 
BR
Szymon Janc

