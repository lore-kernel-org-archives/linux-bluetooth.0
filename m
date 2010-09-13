Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Sep 2010 16:20:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Suraj Sumangala <suraj@Atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
Subject: Re: [RFC] BlueZ D-Bus Sim Access Profile Server API description
Message-ID: <20100913132014.GA5539@jh-x301>
References: <1284374584-12282-1-git-send-email-suraj@atheros.com>
 <20100913105932.GA3566@jh-x301>
 <4C8E0BA3.1010308@Atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C8E0BA3.1010308@Atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> Should we have the method like,
> 	struct RequestATR(string command, variant param)

ATR doesn't take any parameters so it'd be just RequestATR()

> 	where, struct = { string, array{uint8} )

What do you need the string for? Wouldn't an array{uint8} suffice? A
D-Bus error return could be used when the ResultCode in the response
indicates failure.

Johan
