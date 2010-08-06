Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Aug 2010 10:58:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org, rshaffer@codeaurora.org
Subject: Re: [PATCH 7/7] Add service UUIDs from EIR to device properties in
 "Device Found" signal.
Message-ID: <20100806075848.GA22383@jh-x301>
References: <20100805102513.GA7221@jh-x301>
 <1281047801-4044-1-git-send-email-ingas@codeaurora.org>
 <20100806075552.GA22150@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100806075552.GA22150@jh-x301>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Aug 06, 2010, Johan Hedberg wrote:
> 		/* Bail out if field_len claims to reach beyond the EIR
> 		 * data end */
> 		if (len + field_len + 1 >= EIR_DATA_LENGTH)
> 			break;

Sorry, that should actually be > and not >= since it's fine if the end
of the field coincides with the end of EIR data.

Johan
