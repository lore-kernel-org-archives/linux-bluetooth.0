Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 11:36:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 09/13] Bluetooth: Refactor hci_cc_le_set_scan_enable
Message-ID: <20130430083633.GK777@x220.ger.corp.intel.com>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
 <1367300704-703-10-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367300704-703-10-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Apr 30, 2013, Andre Guedes wrote:
> This patch does a trivial refactoring in hci_cc_le_set_scan_enable.
> Since start and stop discovery command failures are now handled in
> mgmt layer, the status check became empty. So, we can move it to
> outside the switch statement.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
