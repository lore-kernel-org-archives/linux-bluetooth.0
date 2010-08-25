Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Aug 2010 20:11:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Angela Bartholomaus <angelab@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	marcel@holtmann.org
Subject: Re: [PATCH v2 0/4] Fix error reporting for SDP Requests
Message-ID: <20100825171130.GA30326@jh-x301>
References: <1282755705-28400-1-git-send-email-angelab@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282755705-28400-1-git-send-email-angelab@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Angela,

On Wed, Aug 25, 2010, Angela Bartholomaus wrote:
> Fixed the following issues revealed while performing bluez qualification: 
> - Incorrect error code was being reported for requests with invalid PDU size;
> - No error was being reported if a request less than 0x07 was received.

Thanks. All four patches have been pushed upstream.

Johan
