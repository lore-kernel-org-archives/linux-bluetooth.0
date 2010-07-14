Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH 3/3] Bluetooth: Synchronize SCO/eSCO connection
 requests to ACL state
From: Marcel Holtmann <marcel@holtmann.org>
To: "Perelet, Oleg" <operelet@quicinc.com>
Cc: Ron Shaffer <rshaffer@codeaurora.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Wilson, Matt" <mtwilson@quicinc.com>
In-Reply-To: <BCDE476F204B134B8B235FB275BC3AD810407AA0CD@NALASEXMB01.na.qualcomm.com>
References: <1278625779.10421.80.camel@localhost.localdomain>
	 <1278968772-29446-1-git-send-email-rshaffer@codeaurora.org>
	 <1278972477.6282.10.camel@localhost.localdomain>
	 <BCDE476F204B134B8B235FB275BC3AD810407AA0CD@NALASEXMB01.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Jul 2010 16:30:03 -0300
Message-ID: <1279135803.6282.58.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oleg,

> >I find your patch actually highly complicated. So I tried to capture
> >your intend the in the attached patch (only compiled test) and it would
> >be good if you can try that.
> 
> Marcel, your fix is mode delicate compared to original and has same functionality. 
> 
> There's small problem with both yours & Rons - there's no error handling for case when other device will never ACK's unsniff - you pretty much DOS session if there's no reply. No real HS will do that but it may present security flaw. I do not know how severe is that
> 
> I attached original conversation when we 1st time seen the problem.

is there really a problem? The LMP will send an error via HCI. So we do
get the mode changed event, but just with an error. And since we are not
checking the error at all, we just go ahead with the SCO setup attempt
in that case.

Regards

Marcel


