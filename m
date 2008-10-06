Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Subject: RE: [PATCH] btsdio: fix tx error path
Date: Mon, 6 Oct 2008 13:20:35 +0200
Message-ID: <C07C4589BE74A34981C3C3525EE1F801048A149D@hasmsx412.ger.corp.intel.com>
In-Reply-To: <1223290490.11272.149.camel@violet.holtmann.net>
References: <1223283914-18238-1-git-send-email-tomas.winkler@intel.com> <1223290490.11272.149.camel@violet.holtmann.net>
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>



>-----Original Message-----
>From: Marcel Holtmann [mailto:marcel@holtmann.org]
>Sent: Monday, October 06, 2008 12:55 PM
>To: Winkler, Tomas
>Cc: linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] btsdio: fix tx error path
>
>Hi Tomas,
>
>> This patch fixes accumulating of the header
>> in case packet was requeued in the error path.
>>
>> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>> Cc: Marcel Holtmann <marcel@holtmann.org>
>> ---
>>  drivers/bluetooth/btsdio.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
>> index 58630cc..e4724b8 100644
>> --- a/drivers/bluetooth/btsdio.c
>> +++ b/drivers/bluetooth/btsdio.c
>> @@ -91,6 +91,7 @@ static int btsdio_tx_packet(struct btsdio_data
*data,
>struct sk_buff *skb)
>>
>>  	err =3D sdio_writesb(data->func, REG_TDAT, skb->data, skb->len);
>>  	if (err < 0) {
>> +		skb_pop(skb, 4);
>>  		sdio_writeb(data->func, 0x01, REG_PC_WRT, NULL);
>>  		return err;
>>  	}
>
>please do at least a compile test. It is skb_pull() and not skb_pop().

Sorry, my bad. It was oneliner so I didn't take the patch directly from
the test machine and my server .config was wrong so the file didn't
compile at all :( leading to clean compilation I will resubmit be more
careful next time.=20

Tomas=20

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
