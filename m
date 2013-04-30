Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 11:27:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 05/13] Bluetooth: Move discovery macros to hci_core.h
Message-ID: <20130430082717.GG777@x220.ger.corp.intel.com>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
 <1367300704-703-6-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367300704-703-6-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Apr 30, 2013, Andre Guedes wrote:
> Some of discovery macros will be used in hci_core so we need to
> define them in common place such as hci_core.h. Thus, this patch
> moves discovery macros to hci_core.h and also adds the DISCOV_
> prefix to them.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h | 10 ++++++++++
>  net/bluetooth/mgmt.c             | 24 ++++++------------------
>  2 files changed, 16 insertions(+), 18 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
