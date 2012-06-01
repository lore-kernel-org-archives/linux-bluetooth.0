Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Jun 2012 16:10:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH] Bluetooth: Create empty l2cap ops function
Message-ID: <20120601131048.GA13525@x220>
References: <1338308366-11465-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338308366-11465-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, May 29, 2012, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> A2MP doesn't use part of the L2CAP chan ops API so we just create general
> empty function instead of the A2MP specific one.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  include/net/bluetooth/l2cap.h |   12 ++++++++++++
>  net/bluetooth/a2mp.c          |   23 +++--------------------
>  2 files changed, 15 insertions(+), 20 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
