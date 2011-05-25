Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 May 2011 13:33:03 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Add little note to the docs
Message-ID: <20110525203303.GA18794@dell.amr.corp.intel.com>
References: <1306337646.2010.219.camel@novo.hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306337646.2010.219.camel@novo.hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Wed, May 25, 2011, Bastien Nocera wrote:
> If one didn't read the Bluetooth 2.1 specs, we could easily miss that
> particular point. Passkeys used for SSP need to have zeros prepended if
> they are less than 6 digits long.
> 
> Added to the docs in the patch below, and will fix the bugs in
> gnome-bluetooth.

Applied. Thanks.

Johan
