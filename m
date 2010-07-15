Return-Path: <cyrus@holtmann.org>
From: "Perelet, Oleg" <operelet@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Matt Wilson <mtwilson@codeaurora.org>,
	Ron Shaffer <rshaffer@codeaurora.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 15 Jul 2010 10:23:48 -0700
Subject: RE: [PATCH 3/3] Bluetooth: Synchronize SCO/eSCO connection requests
 to ACL state
Message-ID: <BCDE476F204B134B8B235FB275BC3AD810407AA252@NALASEXMB01.na.qualcomm.com>
References: <1278625779.10421.80.camel@localhost.localdomain>
	 <1278968772-29446-1-git-send-email-rshaffer@codeaurora.org>
	 <1278972477.6282.10.camel@localhost.localdomain>
	 <BCDE476F204B134B8B235FB275BC3AD810407AA0CD@NALASEXMB01.na.qualcomm.com>
	 <1279135803.6282.58.camel@localhost.localdomain>
	 ,<1279141191.5806.1.camel@linux-champ-06.qualcomm.com>
	 <BCDE476F204B134B8B235FB275BC3AD810408D2A99@NALASEXMB01.na.qualcomm.com>
 <1279174619.6282.63.camel@localhost.localdomain>
In-Reply-To: <1279174619.6282.63.camel@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>Also until the SCO setup is completed the SCO socket should
>never be connected. So userspace can properly detect if SCO setup is in
>progress and route it to the speaker with a proper audio policy. So I
>think the emergency call argument is void. 

Way it works (most of opensource phone systems) - when phone is "connected" to HS/CarKit with no active Ccall ACL + RFCOMM (for AT commnds) is up, but SCO is down for power savings because there's no active audio. Physically audio is routed to HS all the time while HS ACL is up.

When you enter call state phone will attempt to establish SCO over existing ACL with audio still routed to BT - this is when things get screwed up. 

several seconds later unsniff will fail, ACL will get messed up and disconnected and phone will switch to speaker.

>So userspace can properly detect if SCO setup is in
>progress and route it to the speaker with a proper audio policy.

So during "normal" SCO setup (which can take up to 2.5 secs) you suggest to route audio back to speaker for 2.5 secs and then put it back to BT?:)


Oleg.
