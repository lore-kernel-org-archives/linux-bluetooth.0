Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1223294503.11272.158.camel@violet.holtmann.net>
References: <1223293223-21162-1-git-send-email-tomas.winkler@intel.com>
	 <1223294503.11272.158.camel@violet.holtmann.net>
Date: Mon, 2 Feb 2009 16:15:51 +0200
Message-ID: <1ba2fa240902020615w239753a5v6973e77ed59128c9@mail.gmail.com>
Subject: Re: [PATCH V2] btsdio: fix tx error path
From: Tomas Winkler <tomasw@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 6, 2008 at 2:01 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Tomas,
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
>> index 58630cc..c422e89 100644
>> --- a/drivers/bluetooth/btsdio.c
>> +++ b/drivers/bluetooth/btsdio.c
>> @@ -91,6 +91,7 @@ static int btsdio_tx_packet(struct btsdio_data *data, struct sk_buff *skb)
>>
>>       err = sdio_writesb(data->func, REG_TDAT, skb->data, skb->len);
>>       if (err < 0) {
>> +             skb_pull(skb, 4);
>>               sdio_writeb(data->func, 0x01, REG_PC_WRT, NULL);
>>               return err;
>>       }
>
> thanks, but I already fixed that one manually in my tree :)
>
> Regards
>
> Marcel

Would you mind to queue it for 27 stable?  I'm always hitting this and
I guess I'm not only one.
http://marc.info/?l=linux-bluetooth&m=122513647106365&w=2

Thanks
Tomas
