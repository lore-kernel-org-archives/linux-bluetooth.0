Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Sep 2012 12:59:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 2/7 v2] client: Add filters to PhonebookAccess.Pull
Message-ID: <20120905095925.GA766@x220>
References: <1346157115-23933-1-git-send-email-luiz.dentz@gmail.com>
 <1346157115-23933-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1346157115-23933-2-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Aug 28, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This avoid D-Bus round trips and is more aligned with what has been
> proposed for MessageAccess interface.
> ---
>  client/pbap.c | 79 +++++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 53 insertions(+), 26 deletions(-)

This patch doesn't compile:

client/pbap.c: In function ‘pull_vcard_listing.constprop.10’:
client/pbap.c:614:21: error: ‘apparam’ may be used uninitialized in this function [-Werror=maybe-uninitialized]

Johan
