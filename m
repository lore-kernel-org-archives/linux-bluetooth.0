Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Oct 2011 15:22:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Krystad <pkrystad@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 bluez 2/2] Add A2MP definitions
Message-ID: <20111028122242.GB21308@fusion.localdomain>
References: <1319761719-16363-1-git-send-email-pkrystad@codeaurora.org>
 <1319761719-16363-3-git-send-email-pkrystad@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319761719-16363-3-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Thu, Oct 27, 2011, Peter Krystad wrote:
> +typedef struct {
> +	uint8_t		code;
> +	uint8_t		ident;
> +	uint16_t	len;
> +} __attribute__ ((packed)) a2mp_hdr;

Even though the legacy user space code uses typedefs for HCI and L2CAP
(which is why typedefs are probably ok for your 1st patch) the general
direction should be to try to get rid of them where they're not strictly
necessary. The kernel side headers don't use them either (take a look at
include/net/bluetooth/l2cap.h and hci.h).

Therefore, I think it'd be good if you'd from the start avoid them in
this a2mp code. Later it'd be good to have a cleanup patch to convert
the L2CAP and HCI definitions to not use them either.

Johan
