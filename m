Return-Path: <cyrus@holtmann.org>
Message-ID: <1334092668.16897.54.camel@aeonflux>
Subject: Re: [RFCv1] mac80211: Adds Software / Virtual AMP 80211
From: Marcel Holtmann <marcel@holtmann.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Tue, 10 Apr 2012 23:17:48 +0200
In-Reply-To: <4F846257.1060807@sipsolutions.net>
References: <1334059909-20513-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1334059909-20513-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 (sfid-20120410_141120_556160_FD038CE7) <4F846257.1060807@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johannes,

<snip>

> Anyway.
> 
> I don't get this patch at all. Why am I reviewing some very very basic 
> skeleton code when we should be discussing userspace APIs (we have 
> already discussed them with a few people years ago), how the AMP is 
> going to be managed, how the security handshake is going to work, etc.

adding AMP (meaning Bluetooth Alternate MAC/PHY in case anybody cares)
for SoftMac WiFi cards should be done solely in kernel space between
Bluetooth core and mac80211. All the FullMac cards will expose the HCI
AMP directly via the Bluetooth core. See Marvell solution for example.

If we require a userspace interaction, I think we are doing something
wrong here. And as far as I can tell, the only tricky part is the WPA2
PSK 4-way handshake. We would need a kernel implementation for that.
Especially since the key material is actually derived from the Bluetooth
link key that we have available in kernel space already.

Regards

Marcel


