Return-Path: <cyrus@holtmann.org>
From: Freek de Kruijf <f.de.kruijf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: hcidump does not show all traffic
Date: Fri, 28 Aug 2015 14:24:23 +0200
Message-ID: <16191327.qpDB01f2sL@eik132.beelaertsict.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am trying to monitor the traffic between my linux system and an external 
bluetooth system using the command "hcidump -i hci0 -w filename". I only catch 
some traffic from the host to the external device, but nothing from the device 
to the host. I analyze the file using wireshark.

-- 
fr.gr.

Freek de Kruijf

