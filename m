Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 May 2013 12:02:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/2] Bluetooth: Use HCI_MGMT instead of HCI_LINK_KEYS
 flag
Message-ID: <20130514090258.GA12420@x220.ger.corp.intel.com>
References: <20130507114116.GA11873@x220>
 <1368521057-20931-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368521057-20931-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, May 14, 2013, Andrei Emeltchenko wrote:
> Use HCI_MGMT flag instead of HCI_LINK_KEYS flag. There is a problem with
> HCI_LINK_KEYS flag since it is set only when link keys are loaded. Otherwise
> kernel assumes that old interface is used.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_event.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
