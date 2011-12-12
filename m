Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Dec 2011 12:42:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Krystad <pkrystad@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 bluez 2/2] Add A2MP definitions
Message-ID: <20111212104257.GA12316@x220>
References: <1320280606-32677-1-git-send-email-pkrystad@codeaurora.org>
 <1320280606-32677-3-git-send-email-pkrystad@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320280606-32677-3-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Wed, Nov 02, 2011, Peter Krystad wrote:
> + *	This program is free software; you can redistribute it and/or modify
> + *	it under the terms of the GNU General Public License version 2 and
> + *	only version 2 as published by the Free Software Foundation.

I'm still waiting for an update from you on this licensing detail issue.
As Marcel said we'd like to keep the license terms of all libbluetooth
(and also bluez user-space for that matter) consistent. Since you're
already contributing code under "GPL v2 or later" (for the existing .c
and .h files) would it be possible for you to use that for all parts of
your patches?

Johan
