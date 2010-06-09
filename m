Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Jun 2010 19:24:23 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Nathan Holstein <nathan@lampreynetworks.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: remove ERTM minimum packet length
Message-ID: <20100609222423.GD24245@vigoh>
References: <1276112785.3546.560.camel@strawberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1276112785.3546.560.camel@strawberry>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nathan,

* Nathan Holstein <nathan@lampreynetworks.com> [2010-06-09 15:46:25 -0400]:

> ERTM and streaming mode L2CAP sockets have no minimum packet length.
> Instead, validate the the packet contained all necessary control, FCS,
> and SAR fields.
> 
> Signed-off-by: Nathan Holstein <ngh@isomerica.net>
> ---
>  net/bluetooth/l2cap.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 

Patch has been applied to the master branch of my tree. Thanks.

-- 
Gustavo F. Padovan
http://padovan.org
