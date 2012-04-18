Return-Path: <cyrus@holtmann.org>
Message-ID: <1334714611.3725.34.camel@jlt3.sipsolutions.net>
Subject: Re: [RFCv1] mac80211: Adds Software / Virtual AMP 80211
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Tue, 17 Apr 2012 19:03:31 -0700
In-Reply-To: <20120411071119.GC17779@aemeltch-MOBL1>
References: <1334059909-20513-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1334059909-20513-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <4F846257.1060807@sipsolutions.net> <1334092668.16897.54.camel@aeonflux>
	 <4F84A422.3030900@sipsolutions.net> <4F84A52A.7050905@sipsolutions.net>
	 <20120411071119.GC17779@aemeltch-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

Sorry for the delay. I wrote answers to a lot of email on Friday morning
but they all disappeared into the void -- not really sure what happened.

> I am new to the wireless code but can new virtual interface separate those
> interfaces? They can have different MAC addresses and you can run
> wpa_supplicant for each virtual interface separately.

It's never in your best interest to run one supplicant per virtual
interface, you want to run one per piece of hardware so it can
coordinate between virtual interfaces.

johannes

