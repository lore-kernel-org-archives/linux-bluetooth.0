Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Oct 2015 10:02:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: bpa10x: Read revision information in setup
 stage
Message-ID: <20151008070236.GG25309@t440s.lan>
References: <1444263846-72474-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444263846-72474-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 08, 2015, Marcel Holtmann wrote:
> For debugging pruposes, read the revision string of the BPA-10x devices
> and print it. For example one of the latest devices respond with the
> string SNIF_102,BB930,02/01/18,10:37:56.
> 
>   < HCI Command: Vendor (0x3f|0x000e) plen 1
>           07                                               .
>   > HCI Event: Command Complete (0x0e) plen 49
>         Vendor (0x3f|0x000e) ncmd 1
>           Status: Success (0x00)
>           53 4e 49 46 5f 31 30 32 2c 42 42 39 33 30 2c 30  SNIF_102,BB930,0
>           32 2f 30 31 2f 31 38 2c 31 30 3a 33 37 3a 35 36  2/01/18,10:37:56
>           00 00 00 00 00 00 00 00 00 00 00 00 00           .............
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/bpa10x.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
