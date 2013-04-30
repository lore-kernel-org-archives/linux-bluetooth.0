Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 19:10:40 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 13/13] Bluetooth: Fix multiple LE socket handling
Message-ID: <20130430221040.GA4456@joana>
References: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
 <1367253345-12482-14-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367253345-12482-14-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-04-29 19:35:45 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The LE ATT server socket needs to be superseded by any ATT client
> sockets. Previously this was done by looking at the hcon->out variable
> (indicating whether the connection is outgoing or incoming) which is a
> too crude way of determining whether the server socket needs to be
> picked or not (an outgoing connection doesn't necessarily mean that an
> ATT client socket has triggered it).
> 
> This patch extends the ATT server socket lookup function
> (l2cap_le_conn_ready) to be used for all LE connections (regardless of
> the hcon->out value) and adds an internal check into the function for
> the existence of any ATT client sockets (in which case the server socket
> should be skipped). For this to work reliably all lookups must be done
> while the l2cap_conn->chan_lock is held, meaning also that the call to
> l2cap_chan_add needs to be changed to its lockless __l2cap_chan_add
> counterpart.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

All 13 patches have been applied to bluetooth-next. Thanks.

	Gustavo
