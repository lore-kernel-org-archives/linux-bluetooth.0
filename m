Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Oct 2012 10:57:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 BlueZ 1/4] gatt: Add support for find included services
Message-ID: <20121009085741.GC32191@x220.ger.corp.intel.com>
References: <1349741858-18325-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349741858-18325-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, Oct 08, 2012, Vinicius Costa Gomes wrote:
> Some services like HID over LE can reference another service using
> included services.
> 
> See Vol 3, Part G, section 2.6.3 of Core specification for more
> details.
> ---
>  attrib/gatt.c | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  attrib/gatt.h |   9 +++
>  2 files changed, 201 insertions(+)

All patches in this set have been applied. Thanks.

Johan
