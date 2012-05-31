Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 May 2012 16:58:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH -v3 1/2] Bluetooth: Create function to return the ERTM
 header size
Message-ID: <20120531135834.GA28198@x220.ger.corp.intel.com>
References: <1338308957-17282-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338308957-17282-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, May 29, 2012, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> Simplify the handling of different ERTM header size. We were the same
> check in some places of the code, and more is expected to come, so just
> replace them with a function.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  net/bluetooth/l2cap_core.c |   25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
