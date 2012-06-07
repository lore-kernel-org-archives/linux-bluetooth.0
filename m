Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Jun 2012 15:03:39 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/8] gattrib: Fix GAttrib buffer allocation
Message-ID: <20120607070339.GA11609@x220>
References: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Wed, Jun 06, 2012, Andre Guedes wrote:
> GAttrib buffer should be allocated according to ATT_MTU value. Over
> BR/EDR, ATT_MTU should be set to the L2CAP imtu negotiated during
> L2CAP configuration phase. Over LE, ATT_MTU should be 23 octets.
> ---
>  attrib/gattrib.c |   32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)

I've applied all patches as they look ok and the behavior can't get
much more broken than it was previously. I'll also continue testing them
at the UPF and do/propose additional fixes if necessary.

Johan
