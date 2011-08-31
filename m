Return-Path: <cyrus@holtmann.org>
Date: Wed, 31 Aug 2011 10:51:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH BlueZ 1/8] Add link_type information to the mgmt "Device
 Connected" event
Message-ID: <20110831075115.GA6348@dell.ger.corp.intel.com>
References: <1313798969-8772-1-git-send-email-vinicius.gomes@openbossa.org>
 <1313798969-8772-2-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313798969-8772-2-git-send-email-vinicius.gomes@openbossa.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Aug 19, 2011, Vinicius Costa Gomes wrote:
> --- a/lib/hci.h
> +++ b/lib/hci.h
> @@ -212,6 +212,8 @@ enum {
>  #define SCO_LINK	0x00
>  #define ACL_LINK	0x01
>  #define ESCO_LINK	0x02
> +/* Low Energy links do not have defined link type. Use invented one */
> +#define LE_LINK		0x80

I remember Marcel being against any self-invented additions like this.
Have you discussed this with him?

Johan
