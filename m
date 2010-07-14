Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH 3/3] Bluetooth: Synchronize SCO/eSCO connection
 requests to ACL state
From: Matt Wilson <mtwilson@codeaurora.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Ron Shaffer <rshaffer@codeaurora.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1279135803.6282.58.camel@localhost.localdomain>
References: <1278625779.10421.80.camel@localhost.localdomain>
	 <1278968772-29446-1-git-send-email-rshaffer@codeaurora.org>
	 <1278972477.6282.10.camel@localhost.localdomain>
	 <BCDE476F204B134B8B235FB275BC3AD810407AA0CD@NALASEXMB01.na.qualcomm.com>
	 <1279135803.6282.58.camel@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Wed, 14 Jul 2010 13:59:51 -0700
Message-ID: <1279141191.5806.1.camel@linux-champ-06.qualcomm.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel,

On Wed, 2010-07-14 at 16:30 -0300, Marcel Holtmann wrote:
> is there really a problem? The LMP will send an error via HCI. So we do
> get the mode changed event, but just with an error. And since we are not
> checking the error at all, we just go ahead with the SCO setup attempt
> in that case.
> 

The attempt to start SCO after the related ACL is no longer present
makes no sense. 

Either after mode change event with no success or disconnection complete
event the result is the same; there is no valid ACL to attempt
SCO/eSCO. 

Error code 0x02 "unknown connection identifier" may apply for the
command status event for setup synchronous connection command but the
spec does not require it.

-Matt

