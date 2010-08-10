Return-Path: <cyrus@holtmann.org>
Message-ID: <4C6173CA.8060308@codeaurora.org>
Date: Tue, 10 Aug 2010 10:44:10 -0500
From: David Scherba <dscherba@codeaurora.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: johan.hedberg@gmail.com, marcel@holtmann.org,
 rshaffer@codeaurora.org
Subject: Re: [PATCH 2/2] Use HCI device type to gate BR/EDR-specific HCI commands
References: <1281453304-30408-1-git-send-email-dscherba@codeaurora.org> <1281453304-30408-3-git-send-email-dscherba@codeaurora.org>
In-Reply-To: <1281453304-30408-3-git-send-email-dscherba@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 8/10/2010 10:15 AM, David Scherba wrote:
> -	if (!hci_test_bit(HCI_RAW,&di.flags))
> +	if (ignore_device(&di))

Johan--

This change is functionally incorrect--sorry about that.  Updating patch 
2/2.

Cheers,
David

-- 
David Scherba
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
