Return-Path: <cyrus@holtmann.org>
From: "Aj, SanthoshX" <santhoshx.aj@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Holtmann, Marcel" <marcel.holtmann@intel.com>,
	"Nair, Rashmi G" <rashmi.g.nair@intel.com>
Subject: Breaks in A2DP playback during device search
Date: Thu, 5 Jan 2012 04:35:22 +0000
Message-ID: <001F63875E1AF5428162B5A2D3ED1BDD8E8D@IRSMSX101.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
We are facing Issue with A2DP playback & device search.
To solve the issue of audio breaks the controller expects the latency to be set to lesser value.
It's been found HOST is able to send the data but to process the data the latency in the controller to be set (12ms).

We are currently using Android Froyo (2.2.2) which has bluez version 4.47 & kernel version 2.6.32.
We found there was already a hack for Broadcom chip in audio/device.c to set the priority using vendor specific command.
We used the same space to send the HCI QoS Setup command to set the latency.

I am attaching the patch for your review in next mail. Please give your comments & suggestion.

Regards
Santhosh AJ

