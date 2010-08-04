Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Aug 2010 22:04:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	marcel@holtmann.org
Subject: Re: [PATCH v7 0/7] Enhanced support for extended inquiry response
Message-ID: <20100804190439.GA18786@jh-x301>
References: <1280941655-14313-1-git-send-email-ingas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280941655-14313-1-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Wed, Aug 04, 2010, Inga Stotland wrote:
> EIR needs to be updated whenever local SDP record database changes.
> Previously, when an SDP record was added/removed/updated, EIR would 
> be written in callback fired off HCI "Command Complete" event set off by
> "Write Class Of Device" command. However, if the class of device did not
> need to be updated, the EIR write was not happening either. This
> implementation has been augmented to write new EIR when modification
> in SDP database does not lead to updating of class of device.
> 
> Added support for UUID128 service descriptors in local EIR. 
> 
> Service UUIDs are written to "device properties" dictionary  when emitting
> "Device Found" signal. This allows peek at available services offered by 
> a remote device without establishing SDP connection.

There seems to be two "4/7" patches with the same summary line but
different content. What's going on? The patches apply cleanly but the
commit messages should match the content before I can push upstream.
Other than that and one other minor thing (I'll send another email about
it) the patches are starting to look like upstreamable quality. Thanks
for bearing with me and doing all the requested fixes (which I imagine
can feel overly pedantic at times) :)

Johan
