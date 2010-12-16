Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Dec 2010 23:01:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Sheldon Demario <sheldon.demario@openbossa.org>
Subject: Re: [PATCH 2/5] Change CreatePairedDevice to support LE devices
Message-ID: <20101216210111.GA25720@jh-x301>
References: <1292442852-26457-1-git-send-email-claudio.takahasi@openbossa.org>
 <1292442852-26457-2-git-send-email-claudio.takahasi@openbossa.org>
 <20101216092432.GB4322@jh-x301>
 <AANLkTikQOsuUH5NdmBgu47AJLcKMyQ08nRRruj+X8Lfc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikQOsuUH5NdmBgu47AJLcKMyQ08nRRruj+X8Lfc@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Dec 16, 2010, Claudio Takahasi wrote:
> Currently, the purpose are service search functions and UUIDs utility functions.
> glib-helper was originally created to implement some utility functions
> to manage connections and sdp search abstractions.
> Connection functions were moved/removed when btio was created. I have
> two suggestions to try cleanup the code:
> 1. keep only sdp functions that use GLib types and rename the file to
> gsdp or other convenient name
> 2. Or create a btd_device_search/cancel functions(moving them to
> device.c) and try to remove glib-helper from the source tree, in the
> worst case keep only functions to manipulate UUIDs
> 
> The bt_discover_primary can be moved to gatt.c if we split the
> discover cancel function.
> bt_discover_services() can be removed, there isn't reference in code.
> 
> Which approach do you prefer? Any other suggestion?

Considering that around 90% of the file is SDP stuff right now I think
option 1 sounds better. I.e. rename the file to something SDP related as
well as create some more appropriate namespace for its public functions
than bt_*

Johan
