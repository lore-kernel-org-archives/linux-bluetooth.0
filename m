Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Nov 2011 21:17:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/4] High level GATT API for service registration
Message-ID: <20111114191713.GA15156@fusion.localdomain>
References: <1320417003-23493-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320417003-23493-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Nov 04, 2011, Anderson Lizardo wrote:
> Following a previously sent RFC, this series implement an internal API that
> simplifies GATT service registration on server implementations. It is built on
> top of current "low level" attribute API, and both can be used at the same time
> without problem.
> 
> It is currently being used for Phone Alert Status and Time profile server
> implementations which we are preparing to send upstream (we previously sent RFC
> patches for both of them).
> 
> As an example, I converted a service from the GATT example profile (see patch
> #4). Note the migration to this API is optional, and can be done incrementally.
> 
> Still not implemented (but can be added later):
> 
> * No support for aggregate format descriptors, included services (also we don't
>   have any example services using them)
> * No support for some GATT descriptors
> * No support for "static" characteristic values. Any readable or writeable
>   characteristic needs a corresponding read or write callback

Applied. Thanks.

Johan
