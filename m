Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Jun 2013 12:07:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix conditions for HCI_Delete_Stored_Link_Key
Message-ID: <20130613090703.GA16626@x220>
References: <1371110473-15072-1-git-send-email-johan.hedberg@gmail.com>
 <20130613084521.GA3651@amd.pavel.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130613084521.GA3651@amd.pavel.ucw.cz>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavel,

On Thu, Jun 13, 2013, Pavel Machek wrote:
> > Therefore, it makes sense to move sending of HCI_Delete_Stored_Link_Key
> > to after receiving the supported commands response and to only send it
> > if its respective bit in the mask is set. The downside of this is that
> > we no longer send the HCI_Delete_Stored_Link_Key command for Bluetooth
> > 1.1 controllers since HCI_Read_Local_Supported_Command was introduced in
> > version 1.2, but this is an acceptable penalty as the command in
> > question shouldn't affect critical behavior.
> > 
> > Reported-by: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> 
> Tested-by: Pavel Machek <pavel@ucw.cz>

Thanks!

> (Addiditonaly, if you are right and this was in 3.9 already, we
> probably want to cc: stable@kernel.org).

Even though the command itself was in 3.9 it wasn't using the request
framework that was introduced in 3.10 (which for now is depending on all
commands succeeding) so I think you're right after all that it's an
regression since 3.9. Also, because this patch uses the API of the
request framework (hci_req_add) it will not be trivially backportable to
older kernels, so I'd just forget about cc:stable.

Johan
