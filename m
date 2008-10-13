Return-Path: <cyrus@holtmann.org>
Subject: Re: Storing HID req record
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1223913206.4397.42.camel@californication>
References: <1223767117.31961.888.camel@cookie.hadess.net>
	 <1223913206.4397.42.camel@californication>
Content-Type: text/plain
Date: Mon, 13 Oct 2008 17:32:02 +0100
Message-Id: <1223915522.31961.3407.camel@cookie.hadess.net>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2008-10-13 at 17:53 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > I'm looking for a way for a utility to write the HID req, ie. a way to
> > replace the internal store_device_info() from BlueZ 3.x.
> 
> what do you wanna achieve? Is this for the PS3 cable authentication?

Yes it is.
