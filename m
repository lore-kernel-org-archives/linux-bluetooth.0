Return-Path: <cyrus@holtmann.org>
Date: Sun, 15 May 2011 02:31:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix a crash when creating a device from storage
Message-ID: <20110514233158.GI28969@dell.ger.corp.intel.com>
References: <1304963744-31282-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304963744-31282-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, May 09, 2011, Vinicius Costa Gomes wrote:
> The list "services" is just a list of the object paths of the
> registered services that a device has. When we want to store
> the primary services information we need to store the "primaries"
> list, that contain all the primary services information.
> ---
>  src/device.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
