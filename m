Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Jul 2011 13:13:29 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/6] Support for semicolon escaping
Message-ID: <20110726101329.GF28891@dell>
References: <1311145907-3874-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1311145907-3874-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Wed, Jul 20, 2011, Rafal Michalski wrote:
> According to specification of vcard 2.1, semicolon is only character
> which is escaped with a backslash character (in vcard's property field
> content). This patch provides "escape_semicolon" function which handles
> this issue.
> ---
>  plugins/vcard.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)

Doesn't compile:

plugins/vcard.c:152:13: error: ‘escape_semicolon’ defined but not used [-Werror=unused-function]

If you're going to add a static function you also need to have at least
one user of it in the same patch.

Johan
