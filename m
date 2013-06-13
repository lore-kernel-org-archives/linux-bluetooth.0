Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Jun 2013 10:45:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix conditions for
 HCI_Delete_Stored_Link_Key
Message-ID: <20130613084521.GA3651@amd.pavel.ucw.cz>
References: <1371110473-15072-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371110473-15072-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> Therefore, it makes sense to move sending of HCI_Delete_Stored_Link_Key
> to after receiving the supported commands response and to only send it
> if its respective bit in the mask is set. The downside of this is that
> we no longer send the HCI_Delete_Stored_Link_Key command for Bluetooth
> 1.1 controllers since HCI_Read_Local_Supported_Command was introduced in
> version 1.2, but this is an acceptable penalty as the command in
> question shouldn't affect critical behavior.
> 
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>

Tested-by: Pavel Machek <pavel@ucw.cz>

(Addiditonaly, if you are right and this was in 3.9 already, we
probably want to cc: stable@kernel.org).

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
