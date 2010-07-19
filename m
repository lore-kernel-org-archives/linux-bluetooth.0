Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH 3/3] Bluetooth: Synchronize SCO/eSCO connection
 requests to ACL state
From: Matt Wilson <mtwilson@codeaurora.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Ron Shaffer <rshaffer@codeaurora.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1279174425.6282.60.camel@localhost.localdomain>
References: <1278625779.10421.80.camel@localhost.localdomain>
	 <1278968772-29446-1-git-send-email-rshaffer@codeaurora.org>
	 <1278972477.6282.10.camel@localhost.localdomain>
	 <BCDE476F204B134B8B235FB275BC3AD810407AA0CD@NALASEXMB01.na.qualcomm.com>
	 <1279135803.6282.58.camel@localhost.localdomain>
	 <1279141191.5806.1.camel@linux-champ-06.qualcomm.com>
	 <1279174425.6282.60.camel@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Mon, 19 Jul 2010 15:07:40 -0700
Message-ID: <1279577260.16170.54.camel@linux-champ-06.qualcomm.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> However what is up with the mode change. If that fails, we are still in
> sniff mode and can just proceed with the SCO setup attempt. With the
> broken hardware it will fail for sure, but with good behaving LM on the
> remote side it might just get the device out of sniff mode at that point
> and SCO setup can succeed.
> 
> Why do you imply that a mode change event with a failure means that the
> ACL is no longer present?

I was thinking the Mode Change event would carry a LMP response timeout
or link supervision (LS) timeout status when the two devices lose
synchronization while in sniff just after sending exit sniff LMP PDU
(only baseband ACK). It is more clear when the LS timeout is greater
than the 30 second (immutable) LMP response timeout.

But reading the LMP spec (2.4.1) I conclude that the former cannot occur
in the exit sniff scenario and the Disconnection Complete event is the
only required event in the latter.

I agree to wait until we have a clear and real scenario and then discuss
further with those logs.

Best regards,

-Matt

Employee of the Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.



