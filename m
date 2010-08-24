Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 0/4] Fix error reporting for SDP Requests
From: Marcel Holtmann <marcel@holtmann.org>
To: Angela Bartholomaus <angelab@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	johan.hedberg@gmail.com
In-Reply-To: <1282688060-10727-1-git-send-email-angelab@codeaurora.org>
References: <1282688060-10727-1-git-send-email-angelab@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 Aug 2010 00:21:28 +0200
Message-ID: <1282688488.6841.34.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Angela,

> Fixed the following issues revealed while performing bluez qualification: 
> - Incorrect error code was being reported for requests with invalid PDU size;
> - No error was being reported if a request less than 0x07 was received.

I never needed any of these fixes when doing qualification. So why do
you? Please mention the test case numbers.

Regards

Marcel


