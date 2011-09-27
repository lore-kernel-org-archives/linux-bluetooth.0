Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:47:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/2] Refactoring address fields handled in vcard
 module
Message-ID: <20110927094708.GK3952@dell>
References: <1314009177-19178-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314009177-19178-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Mon, Aug 22, 2011, Rafal Michalski wrote:
> This patch introduces phonebook_addr struct for more intuitive
> handling address fields from backend. Now address fields are managed
> by linked list (wrapped by structure) and it is used for printing vCard
> address fields, instead of buffers set (combined with g_strsplit
> and snprintf functions).
> ---
>  plugins/phonebook-tracker.c |   72 +++++++++++++++++++++++++++++++++++++-----
>  plugins/vcard.c             |   70 +++++++++++++++++++----------------------
>  plugins/vcard.h             |    7 +++-
>  3 files changed, 101 insertions(+), 48 deletions(-)

Both patches applied. Thanks.

Johan
