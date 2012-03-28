Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Mar 2012 12:40:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] event: Store Class of Device after connection
Message-ID: <20120328094023.GC28310@x220>
References: <1332853574-26832-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332853574-26832-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Mar 27, 2012, Anderson Lizardo wrote:
> The Class of Device is usually sent on the EIR returned by the Device
> Connected mgmt event. For hciops, the Class of Device is always NULL on
> the connection complete event.
> 
> The stored Class of Device is used later for Class/Icon device
> properties.
> ---
>  src/event.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
