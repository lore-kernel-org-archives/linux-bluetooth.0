Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Sep 2015 11:52:56 -0700
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linaro-kernel@lists.linaro.org,
	QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
	Intel Linux Wireless <ilw@linux.intel.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, iommu@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-mm@kvack.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
Message-ID: <20150925185256.GG5951@linux>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 <1443202945.2161.8.camel@sipsolutions.net>
 <20150925184741.GF5951@linux>
 <1443206945.2161.9.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443206945.2161.9.camel@sipsolutions.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 25-09-15, 20:49, Johannes Berg wrote:
> Ok, then, but that means Rafael is completely wrong ...
> debugfs_create_bool() takes a *pointer* and it needs to be long-lived,
> it can't be on the stack. You also don't get a call when it changes.

Ahh, ofcourse. My bad as well...

I think we can change structure definition but will wait for Rafael's
comment before that.

-- 
viresh
