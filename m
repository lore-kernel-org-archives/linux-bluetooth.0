Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Nov 2010 17:30:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Avoid reallocations of services UUID array
Message-ID: <20101119153027.GF28815@jh-x301>
References: <1290178759-9270-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290178759-9270-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Fri, Nov 19, 2010, Anderson Lizardo wrote:
> The array of service UUIDs used by the DeviceFound signal contains the
> same information from the GSList of services. Instead of reallocating
> this array on each signal, store it on the remote_dev_info structure and
> only reallocate it if there are new UUIDs.
> ---
>  src/adapter.c |   18 +++++++++---------
>  src/adapter.h |    3 ++-
>  2 files changed, 11 insertions(+), 10 deletions(-)

This one has also been pushed upstream. Thanks.

Johan
