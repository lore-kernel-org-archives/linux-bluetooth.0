Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Nov 2012 13:12:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: eSCO latency configuration
Message-ID: <20121127111241.GA24125@x220>
References: <4E64AD1D.6000609@invoxia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E64AD1D.6000609@invoxia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arnaud,

On Mon, Sep 05, 2011, Arnaud Mouiche wrote:
> What could be a way to add the feature without breaking any API
> 1) use the MTU of the socket or hdev ?
> 2) add hdev entry for sco latency (which can be configured with
> hciconfig like voice settings)
> 3) something else ...
> or
> 4) no one cares about latency...
> 
> PS: the same way, the retransmit effort is not configurable today.

I'm assuming this is for HFP or HSP? At least I'm not aware of other
significant profiles using (e)SCO. Since the HFP specification defines a
set of recommended parameter combinations I don't think we necessarily
need any user-space facing interface for this (with the exception of the
mSBC/CVSD codec selection which is needed for HFP 1.6).

Instead, the kernel could simply start with the S3 settings and fall
back to S2 and finally S1 if failures are encountered during the
connection setup. For mSBC the starting point would be T2 with a
fallback to T1 in case of failure. Do you agree that this would be an
acceptable solution?

Johan
