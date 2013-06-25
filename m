Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Jun 2013 21:48:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: Re: regression in sdp lib
Message-ID: <20130625184848.GA29741@x220.P-661HNU-F1>
References: <1560638.biMD7yTzvv@athlon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1560638.biMD7yTzvv@athlon>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Jun 21, 2013, Szymon Janc wrote:
> commit 'lib: Add range check for SDP_SVC_ATTR_RSP/SDP_SVC_SEARCH_ATTR_RSP'
> 1796f00e846561af broke sdp with Nokia BH217 headset.

Since there evidently wasn't any progress on this issue and we want to
get a new release out (due to also another severe regression) I've gone
ahead and simply reverted the original patch. Nevertheless, I'm still
looking forward to seeing a proper fix for this issue.

Johan
