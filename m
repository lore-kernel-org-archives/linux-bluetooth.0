Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH 3/3] Bluetooth: Synchronize SCO/eSCO connection
 requests to ACL state
From: Marcel Holtmann <marcel@holtmann.org>
To: Matt Wilson <mtwilson@codeaurora.org>
Cc: Ron Shaffer <rshaffer@codeaurora.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1279141191.5806.1.camel@linux-champ-06.qualcomm.com>
References: <1278625779.10421.80.camel@localhost.localdomain>
	 <1278968772-29446-1-git-send-email-rshaffer@codeaurora.org>
	 <1278972477.6282.10.camel@localhost.localdomain>
	 <BCDE476F204B134B8B235FB275BC3AD810407AA0CD@NALASEXMB01.na.qualcomm.com>
	 <1279135803.6282.58.camel@localhost.localdomain>
	 <1279141191.5806.1.camel@linux-champ-06.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Jul 2010 03:13:45 -0300
Message-ID: <1279174425.6282.60.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matt,

> > is there really a problem? The LMP will send an error via HCI. So we do
> > get the mode changed event, but just with an error. And since we are not
> > checking the error at all, we just go ahead with the SCO setup attempt
> > in that case.
> > 
> 
> The attempt to start SCO after the related ACL is no longer present
> makes no sense. 
> 
> Either after mode change event with no success or disconnection complete
> event the result is the same; there is no valid ACL to attempt
> SCO/eSCO. 
> 
> Error code 0x02 "unknown connection identifier" may apply for the
> command status event for setup synchronous connection command but the
> spec does not require it.

I see the point the the disconnect event and in that case we need to
check if we have an pending SCO setup and remove that.

However what is up with the mode change. If that fails, we are still in
sniff mode and can just proceed with the SCO setup attempt. With the
broken hardware it will fail for sure, but with good behaving LM on the
remote side it might just get the device out of sniff mode at that point
and SCO setup can succeed.

Why do you imply that a mode change event with a failure means that the
ACL is no longer present?

Regards

Marcel


