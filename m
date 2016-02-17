Return-Path: <maxime.chevallier@openwide.fr>
Date: Wed, 17 Feb 2016 10:17:36 +0100
From: Chevallier Maxime <maxime.chevallier@openwide.fr>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: [RFC][PATCH 0/1 v2] mgmt : add Set Advertising Parameters
Message-ID: <20160217091736.GA12037@vps217108.ovh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone,

After some discussions, here is another proposition for adding
a Set Advertising Parameters command to mgmt API. This command
would set parameters globally, for advertisements issued both
with Set Advertising and Add Advertising.

I would like to discuss the parameters that are passed to
this command. This proposition only include advertising
intervals, but that could be expanded later on.

I choosed to take as parameters the exact same format that is
accepted by the HCI command 'LE Set Advertising Parameters',
with the same units and constraints. If you think that could
be improved in some way to make it clearer, please tell me.

I also would like some feedback on the policy we should apply
when we are in ADV_NONCONN_IND (and ADV_SCAN_IND, but I think
this type is not used for now), since the spec says that
intervals shall not be less than 100ms. I choosed to fallback
to default parameters while we are in non connectable mode.

Thanks in advance,

Maxime

Chevallier Maxime (1):
  Add Set Advertising Parameters command

 doc/mgmt-api.txt | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

-- 
2.1.4
