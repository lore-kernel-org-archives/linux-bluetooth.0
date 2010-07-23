Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 Jul 2010 11:43:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>, linux-bluetooth@vger.kernel.org,
	rshaffer@codeaurora.org, marcel@holtmann.org
Subject: Re: [PATCH v4 0/5] Enhanced support for extended inquiry response
Message-ID: <20100723084300.GA14443@jh-x301>
References: <1279814780-29673-1-git-send-email-ingas@codeaurora.org>
 <20100723082045.GA1600@jh-x301>
 <20100723082754.GA12563@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100723082754.GA12563@jh-x301>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 23, 2010, Johan Hedberg wrote:
> On Fri, Jul 23, 2010, Johan Hedberg wrote:
> > Could you explain to me why this is needed. With the current git
> > (without your patches) the local EIR data seems to be correctly updated
> > whenever the SDP database changes. Are there some scenarios when this
> > doesn't happen? I did a quick test with sdptool add/del while bluetoothd
> > was running and I could see the appropriate "Write Extended Inquiry
> > Response" commands with hcidump.
> 
> It seems currently this only happens when a local record change causes
> the service class bits of the class of device to be updated too. If the
> record change doesn't affect the class of device then it seems the EIR
> data isn't modified accordingly. Is this correct? If so, could you
> please add that information to your commit message so that it's clear
> why the patch is needed.

Even with your patch it seems this still doesn't work. If I I don't have
any OBEX servers running and I do "sdptool add OPUSH" I get the
apropriate EIR update with the OPP UUID (0x1105) added to the list, but
if I do a consecutive "sdptool add FTP" 0x1106 doesn't get added even
though it should. Then when I do sdptool del for the OPP record the UUID
doesn't get removed from the EIR data. So it seems some things still
need fixing.

Also, could you somehow try to avoid the multiple "Write Extended
Inquiry Response" commands while bluetoothd is probing drivers for an
adapter that entered the UP state? With the class of device this is done
through adapter->cache_enable, so maybe some more generic system could
be used for all HCI trafic related to probing drivers.

Johan
