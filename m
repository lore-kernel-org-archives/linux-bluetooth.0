Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Feb 2012 19:29:38 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] client: Remove unused public function
Message-ID: <20120301032938.GA1087@x220>
References: <1330433830-20017-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330433830-20017-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Feb 28, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> obex_io_error_quark is only used in session.c so can be static
> ---
>  client/session.c |    2 +-
>  client/session.h |    3 ---
>  2 files changed, 1 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan
