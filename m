Return-Path: <cyrus@holtmann.org>
From: "Sumangala, Suraj" <surajs@qca.qualcomm.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	Koustuv Ghosh <koustuvg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: SCORouting to PCM in Desktop
Date: Thu, 30 Jun 2011 10:07:15 +0000
Message-ID: <480687D4EEFE7447A2E09AADFF667362049C48F1@nasanexd02c.na.qualcomm.com>
References: <BANLkTi=ku2nnVc0DgduHtxZ6xQvzW-d+zA@mail.gmail.com>
 <20110630092824.GA26690@dell.ger.corp.intel.com>
In-Reply-To: <20110630092824.GA26690@dell.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan

Sometime ago we had a situation where we were testing a BT chip that did NOT support SCO over HCI and supported only SCO over PCM.

The problem was whenever SCO connection was made; my host (Ubuntu) sent 2 or 3 SCO packets over HCI to the controller. 
The controller could not handle these packets as it meant as only a SCO over PCM device and crashed.

 So we had to drop the SCO packets in the HCI transport driver explicitly.
So, when we say in the configuration file that SCO is over PCM should the stack make sure that no SCO packets are sent over HCI?

Note: This was observed long time before, not sure if it is relevant now.

Regards
Suraj
