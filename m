Return-Path: <cyrus@holtmann.org>
Subject: Re: Sony BD Remote (help requested)
From: Bastien Nocera <hadess@hadess.net>
To: Simon Kenyon <simon@koala.ie>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <492E6E6A.80509@koala.ie>
References: <492E6E6A.80509@koala.ie>
Content-Type: text/plain
Date: Thu, 27 Nov 2008 10:56:36 +0000
Message-Id: <1227783396.27994.1750.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2008-11-27 at 09:54 +0000, Simon Kenyon wrote:
> i'm trying to get y BD Remote to work.
> 
> this is what i have done so far:
> 
> installed bluez from git (as of yesterday)
> configured it (i think)
> when i:
> 
> hidd --search
> 
> i see the remote

Your remote won't work using hidd. There's no code in hidd to decode the
custom protocol.

Pair it with the bluetooth-wizard and you can be on your way.

Cheers

