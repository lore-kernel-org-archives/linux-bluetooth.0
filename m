Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Sep 2010 21:49:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: >net-wireless/bluez-4.63 unable to connect audio streams due
 commit
Message-ID: <20100920184943.GA22968@jh-x301>
References: <1285006436.15378.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285006436.15378.2.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Sep 20, 2010, Pacho Ramos wrote:
> Reporter found that the problem with his dongle was introduced in commit
> aee26b30bbc24cde464ba1a557c2b258ddec6432 "Make BtIO default security
> level MEDIUM", he asked here, on upstream mailing list, but didn't get
> any reply clarifying this:
> http://marc.info/?l=linux-bluetooth&m=127893935109510&w=2

The important piece of info missing here is an HCI trace of the failure
(i.e. output of hcidump). There was a similar issue reported on IRC a
few days back and the hcidump there revealed a LMP response timeout
after BlueZ issues a HCI_Set_Connection_Encryption command. This would
seem to indicate a bug either in the local adapter or the remote device
(headset). Only an airtrace would really reveal what's going on.
However, I suspect it might be possible to work around this by looking
into possibilities of changing the ordering and timing of when the
kernel sends the encryption request.

Johan
