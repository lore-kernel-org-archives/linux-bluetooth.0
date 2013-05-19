Return-Path: <cyrus@holtmann.org>
Date: Sun, 19 May 2013 07:06:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 BlueZ] tools: Add script for updating bt_compidtostr()
 implementation
Message-ID: <20130519040653.GA9463@x220>
References: <1367612371-20930-1-git-send-email-anderson.lizardo@openbossa.org>
 <1368800519-20187-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368800519-20187-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, May 17, 2013, Anderson Lizardo wrote:
> This script uses curl and html2text to fetch company IDs from
> bluetooth.org's "Assigned Numbers" section.
> ---
> 
> v3:
> 
> * Make the script work better with modified html2text versions.
> (it is unfortunate that in this case the upstream unmodified version works
> better than the distro one).
> 
> I should report a bug to Fedora as time permits...
> 
> 
>  tools/update_compids.sh |   48 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100755 tools/update_compids.sh

Applied. Thanks.

Johan
