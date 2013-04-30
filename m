Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 13:06:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] tools: Add script for updating
 bt_compidtostr() implementation
Message-ID: <20130430100655.GB5745@x220.ger.corp.intel.com>
References: <1365706752-4442-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365706752-4442-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Apr 11, 2013, Anderson Lizardo wrote:
> This script uses curl and html2text to fetch company IDs from
> bluetooth.org's "Assigned Numbers" section.
> ---
>  tools/update_compids.sh |   37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100755 tools/update_compids.sh

I tried this script but after downloading the page it fails with "Input
recoding failed due to invalid input sequence." and then proceeds with
generating a diff to remove all entries from the switch statement.

Johan
