Return-Path: <maxime.chevallier@openwide.fr>
Date: Tue, 16 Feb 2016 14:09:08 +0100
From: Chevallier Maxime <maxime.chevallier@openwide.fr>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	johan.hedberg@gmail.com
Subject: [RFC][PATCH 0/1] mgmt : add Set Advertising Parameters
Message-ID: <20160216130908.GA10339@vps217108.ovh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone,

The following patch is a proposal for a new mgmt command,
to set Advertising Parameters.

The goal is, in a first time, to allow user to configure
advertising intervals. Ideally, this command could be expanded
later on to add parameters that would for example allow configuring
directed advertising, and taking whitelist into account to handle
scan responses.

Currently, the advertising intervals are hardcoded and are applied
globally, wether we issued a Set Advertising or an Add Advertising
command.

My proposal impacts the Add Advertising command by adding a new flag,
that would allow the Add Advertising command to be followed by a
Set Advertising Parameters command, in order to configure parameters
specific for an Advertising Instance.

There are many aspects of this command on which I would like feedback,
especially on :
	- Wether or not it is pertinent to use the Instance '0' to
	  configure global advertising parameters
	- The system of a new flag to Add Advertising, this seems tricky
	  if we set the flag but don't issue the Set Advertising Parameters
	  afterwards
	- What we should return
	- Overall naming of flags, parameters and commands

Thanks in advance,

Maxime Chevallier

Chevallier Maxime (1):
  Add Set Advertising Parameters command

 doc/mgmt-api.txt | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

-- 
2.1.4
