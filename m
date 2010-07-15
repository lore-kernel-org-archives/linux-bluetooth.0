Return-Path: <cyrus@holtmann.org>
From: "Perelet, Oleg" <operelet@quicinc.com>
To: Matt Wilson <mtwilson@codeaurora.org>,
	Marcel Holtmann <marcel@holtmann.org>
CC: Ron Shaffer <rshaffer@codeaurora.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 14 Jul 2010 20:07:45 -0700
Subject: RE: [PATCH 3/3] Bluetooth: Synchronize SCO/eSCO connection requests
 to ACL state
Message-ID: <BCDE476F204B134B8B235FB275BC3AD810408D2A99@NALASEXMB01.na.qualcomm.com>
References: <1278625779.10421.80.camel@localhost.localdomain>
	 <1278968772-29446-1-git-send-email-rshaffer@codeaurora.org>
	 <1278972477.6282.10.camel@localhost.localdomain>
	 <BCDE476F204B134B8B235FB275BC3AD810407AA0CD@NALASEXMB01.na.qualcomm.com>
	 <1279135803.6282.58.camel@localhost.localdomain>,<1279141191.5806.1.camel@linux-champ-06.qualcomm.com>
In-Reply-To: <1279141191.5806.1.camel@linux-champ-06.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel.

>> is there really a problem? The LMP will send an error via HCI. 
>
>The attempt to start SCO after the related ACL is no longer present
>makes no sense.
>
>Either after mode change event with no success or disconnection complete
>event the result is the same; there is no valid ACL to attempt
>SCO/eSCO.
>
>Error code 0x02 "unknown connection identifier" may apply for the
>command status event for setup synchronous connection command but the
>spec does not require it.

Security classification that this case fits is partial DOS for voice services, which is 
considered to be severe for emergency calls even for few seconds.

Depending on chip - It will take awhile (several seconds) before response will pop  
up  and then no matter what we'll still go over sco/esco setup at top of non existing ACL as Matt says.

Because whole thing is in kernel several seconds of audio may get lost before phone(userland) 
will realize that SCO failed and route audio to speaker, if ever:)

I'm not big fan of having all of this complication in kernel because of couple of screwed up headsets. 
There's no problem doing similar logic in userland with tight control over particular HS and timing. 

Oleg.