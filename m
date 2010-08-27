Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] BT_SECURITY_HIGH requires 16 digit pin code
From: Bastien Nocera <hadess@hadess.net>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	joakim.xj.ceder@stericsson.com, johan.hedberg@gmail.com
In-Reply-To: <1282909526-19374-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1282909526-19374-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Fri, 27 Aug 2010 13:12:13 +0100
Message-ID: <1282911133.835.30.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2010-08-27 at 13:45 +0200, Waldemar Rymarkiewicz wrote:
> The security level BT_SECURITY_HIGH expects secure connection
> and a minimum 16 digit pin code used for bonding. It's requitred by the
> Sim Access Profile.

How is user-space (meaning the pairing agent) supposed to handle that?
I'd need to make changes to gnome-bluetooth to use longer PIN codes for
the maximum security.

Cheers

