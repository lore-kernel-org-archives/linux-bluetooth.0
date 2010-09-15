Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Sep 2010 11:10:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com
Subject: Re: [RFC] D-Bus API for out of band association model
Message-ID: <20100915081047.GA15065@jh-x301>
References: <1284537527-22783-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284537527-22783-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wed, Sep 15, 2010, Andrzej Kaczmarek wrote:
> On behalf of ST-Ericsson SA, below is our proposal of API for out of band
> association model. To give you a bit more overview how this will be integrated
> into BlueZ:
> 
> .RequestRemoteOobData should be called from hcid_dbus_request_io_cap to
> check if any data was exchange/retrieved from remote device. Returned data
> will be stored (if any) and used to reply with proper IO capabilities as well
> as to to return retrieved data. This will involve some changes in flow from
> io_capa_request onwards.
> 
> Please let me know if you have any comments. Implementation will follow.

I'd prefer to do this completely internally in bluetoothd through a
plugin. Do you see any reasons why not to do it that way? We still need
some UI to call CreatePairedDevice but a plugin that knows about local
platform specific OOB mechanisms (e.g. NFC) could provide the core
daemon with enough info to set the IO capabilities correctly and provide
the necessary OOB values.

Johan
