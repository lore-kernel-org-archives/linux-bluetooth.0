Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Jan 2010 18:21:37 +0000 (GMT)
To: Philip Oberstaller <p.oberstaller@zydacron.com>
Cc: "linux-bluetooth\@vger\.kernel\.org"
	<linux-bluetooth@vger.kernel.org>
Subject: Re: Scan of already paired devices
In-Reply-To: <4B5749B9.2080108@zydacron.com>
References: <4B5749B9.2080108@zydacron.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1264011697.849429.595.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 20 Jan 2010, Philip Oberstaller wrote:

> Thus anybody know what I could do from the host side to be able to make the
> device "visible" again.

Obviously, you cannot control the device from the host if you are not even
connected to it..

What device is it?  If it is a phone then it may be possible to make it
visible always, but many limited connection devices (HID, or headphones
etc) will not advertise themselves if they have a pairing as there is no
point to do that and it wastes power.

regards,
iain


