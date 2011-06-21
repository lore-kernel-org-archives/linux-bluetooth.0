Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Jun 2011 10:46:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Make proper use of user_data when using
 bt_io_listen
Message-ID: <20110621074636.GA5325@dell.ger.corp.intel.com>
References: <1308639617-28882-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308639617-28882-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jun 21, 2011, Luiz Augusto von Dentz wrote:
> This changes the user_data from server pointer to service driver pointer
> since the former is not really used in the callback but the latter is.
> ---
>  plugins/bluetooth.c |   10 ++--------
>  1 files changed, 2 insertions(+), 8 deletions(-)

Applied. Thanks.

Johan
