Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Jun 2014 13:18:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 0/3] Gatt Client Characteristic Configuration
Message-ID: <20140604101806.GB13961@t440s.ice.intel.com>
References: <1401201223-17852-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401201223-17852-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tue, May 27, 2014, Jakub Tyszkowski wrote:
> This adds Client Characteristic Configuration descriptor for Service Changed
> Characteristic registered on gatt init. This stored value should be persistent
> across connections for bonded devices, thus gatt specific api was aded to
> bluetooth core profile exposing storage functionality.
> 
> We could consider creating more generic functions, allowing to store custom
> <key, value> pairs. that other profiles could use aswell. Then on every value
> read we would access the file as we do on write, instead of storing it in device
> along with other properties.
> 
> I'm not sure which aproach would be better. Should we go with the generic
> version already or do it later if it turns out that we need to store more
> thing for more profiles?

I'd go with a specific solution now. We can still change this later if
necessary.

Johan
