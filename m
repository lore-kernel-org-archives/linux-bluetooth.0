Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 May 2012 10:47:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH -v2] Bluetooth: Fix wrong set of skb fragments
Message-ID: <20120516074729.GA25830@x220>
References: <1337098975-4859-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337098975-4859-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, May 15, 2012, Gustavo Padovan wrote:
> If alloc() fails we let the frags linked list with garbage value(the err
> ptr value) in its last element.
> 
> Reported-by: Mat Martineau <mathewm@codeaurora.org>
> Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
> ---
>  net/bluetooth/l2cap_core.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
