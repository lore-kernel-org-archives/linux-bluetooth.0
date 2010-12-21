Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Dec 2010 10:49:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Filter device name in hciconfig.
Message-ID: <20101221084954.GB14108@jh-x301>
References: <1292840029-27770-2-git-send-email-michal.labedzki@tieto.com>
 <1292920258-28989-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292920258-28989-1-git-send-email-michal.labedzki@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Tue, Dec 21, 2010, Michal Labedzki wrote:
> No anymore work someting like "hciconfig tty1", "hciconfig qfg1" or
> "hciconfig hci1hg" as "hci1".
> ---
>  lib/hci.c         |   12 +++++++++++-
>  tools/hciconfig.c |   30 +++++++++++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 2 deletions(-)

This doesn't compile for me:

lib/hci.c: In function 'is_number':
lib/hci.c:60: error: implicit declaration of function 'isdigit'

Did you actually compile using ./boostrap-configure? Always do that
before submitting patches. It'll enable some extra checks and convert
all warnings to errors so you don't miss them by mistake.

"man isdigit" tells me that <ctype.h> should be included to use the
funciton.

Also, your commit message doesn't match the patch content. The patch
also changes hci_devid which is in no way specific to hciconfig whereas
your commit message implies that the patch is specific to hciconfig.
Feel free to split this into two separate patches with appropriate
commit messages.

Johan
