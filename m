Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1380031363-1266-8-git-send-email-johan.hedberg@gmail.com>
References: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com>
	<1380031363-1266-8-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 24 Sep 2013 11:45:44 -0400
Message-ID: <CAJdJm_MDoR2ed6++x5JAxaG2=0+zUdAGztL_L3i-ObtaM+WbRA@mail.gmail.com>
Subject: Re: [PATCH 7/8] Bluetooth: Add new mgmt setting for LE advertising
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Sep 24, 2013 at 10:02 AM,  <johan.hedberg@gmail.com> wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
>
> This patch adds a new mgmt setting for LE advertising and hooks up the
> necessary places in the mgmt code to operate on the HCI_LE_PERIPHERAL
> flag (which corresponds to this setting). This patch does not yet add
> any new command for enabling the setting - that is left for a subsequent
> patch.

How this code behaves if we enable/disable LE advertising using
hciconfig hci0 leadv/noleadv? IIRC the LE_SET_ADV_ENABLE command will
fail if advertising is already set on the controller.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
