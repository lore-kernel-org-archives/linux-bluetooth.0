Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Mar 2011 11:18:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marco Sinigaglia <marco.sinigaglia@csr.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Adjust timeout LE and API
Message-ID: <20110310091826.GB5566@jh-x301>
References: <1299689985-6818-1-git-send-email-marco.sinigaglia@csr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299689985-6818-1-git-send-email-marco.sinigaglia@csr.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marco,

On Wed, Mar 09, 2011, Marco Sinigaglia wrote:
> 
> The timeout value has been hardcoded on hci_send_req call and, instead, it should be passed from above (for ex from hci_le_set_scan_enable).
> This patch removes the hardcoded value from hci_send_req and it increases the timeout to 1000ms.
> 
> v1-->v2: used git-format-patch
> 
> Signed-off-by: Marco Sinigaglia <marco.sinigaglia@csr.com>
> 
> ---
>  lib/hci.c         |   12 ++++++------
>  lib/hci_lib.h     |    6 +++---
>  tools/hciconfig.c |    2 +-
>  tools/hcitool.c   |    6 +++---
>  4 files changed, 13 insertions(+), 13 deletions(-)

The patch finally applies and has been pushed upstream. However, I did
have to fix your commit message manually:

- Lines should be short enough to fit git log output on a 80
  column wide terminal
- Patch version changes do not belong in the commit message. Put them
  between the "---" and the "diff" line.
- No Signed-off-by line for user space patches

Johan
