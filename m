Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Mar 2012 12:36:10 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: trivial: Correct types
Message-ID: <20120316153610.GA21335@x220>
References: <1331560774-10748-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331560774-10748-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Mar 12, 2012, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Fix sparse warnigns below:
> ...
> net/bluetooth/hci_sysfs.c:458:33: warning: cast to restricted __be32
> net/bluetooth/hci_sysfs.c:458:47: warning: cast to restricted __be16
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_sysfs.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Patches 1-3 have been applied. Thanks.

Johan
