Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Jun 2010 16:56:24 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Saurabh Thukral <saurabhth@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Inquiry Result with repeated set of MAC addresses - Is it a
 problem with Bluetooth device ?
Message-ID: <20100606085624.GA393@jh-x301>
References: <AANLkTimX-ofkv4oekES0kfi7l_y4yLMVAO8A9e0Nx5tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimX-ofkv4oekES0kfi7l_y4yLMVAO8A9e0Nx5tg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Jun 06, 2010, Saurabh Thukral wrote:
> I am currently testing my bluetooth application using Bluez on Linux
> (Fedora Core 11) and have HP Eltebook laptop that has Broadcom
> bluetooth adaptor. The Bluez version installed is 4.37.
> 
> On running <hcitool scan> in one terminal and simultaneously viewing
> results using <hcidump> on the other terminal, I had a very
> interesting observation that has made me quite perplexed. I would
> really like you to help me out.
> 
> The observation is that suppose a device(Nokia N73) with MAC address
> M1 is discoverable, the response to Inquiry Request command is often a
> set of multiple Inquiry Result each with the same MAC address M1.
> 
> I had expected that only one Inquiry result with MAC address M1 should
> have been returned. But here what we find is that multiple such
> results with the same MAC address are returned.
> 
> Please advise if this is an issue with bluetooth adaptor or bluez.

It's most likely neither, but simply as it's intended to be. I presume
the inquiry results contain the RSSI which will most likely be different
in each event. The purpose of the multiple events is to give you updates
if the signal strength to the device changes.

Johan
