Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 6 Jun 2010 10:42:23 +0530
Message-ID: <AANLkTimX-ofkv4oekES0kfi7l_y4yLMVAO8A9e0Nx5tg@mail.gmail.com>
Subject: Inquiry Result with repeated set of MAC addresses - Is it a problem
	with Bluetooth device ?
From: Saurabh Thukral <saurabhth@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear Bluez Team,

I am currently testing my bluetooth application using Bluez on Linux
(Fedora Core 11) and have HP Eltebook laptop that has Broadcom
bluetooth adaptor. The Bluez version installed is 4.37.

On running <hcitool scan> in one terminal and simultaneously viewing
results using <hcidump> on the other terminal, I had a very
interesting observation that has made me quite perplexed. I would
really like you to help me out.

The observation is that suppose a device(Nokia N73) with MAC address
M1 is discoverable, the response to Inquiry Request command is often a
set of multiple Inquiry Result each with the same MAC address M1.

I had expected that only one Inquiry result with MAC address M1 should
have been returned. But here what we find is that multiple such
results with the same MAC address are returned.

Please advise if this is an issue with bluetooth adaptor or bluez.

Kindly suggest some workaround.

--
Regards,
Saurabh Thukral
