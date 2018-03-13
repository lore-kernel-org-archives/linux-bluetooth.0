Return-Path: <elfring@users.sourceforge.net>
Subject: Re: [PATCH 5/5] Bluetooth: btmrvl: Use common error handling code in
 btmrvl_sdio_download_fw_w_helper()
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
 <a3f4f205-dbda-c1dc-6ca6-506d44e20615@users.sourceforge.net>
 <360E0F12-1BC1-441D-872B-8E3946EB2425@holtmann.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <bf69424e-e126-40b7-663e-c278230e6b4e@users.sourceforge.net>
Date: Tue, 13 Mar 2018 08:55:57 +0100
MIME-Version: 1.0
In-Reply-To: <360E0F12-1BC1-441D-872B-8E3946EB2425@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

>> Add a jump target so that the setting of a specific error code is stored
>> only once at the end of this function.
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>> ---
>> drivers/bluetooth/btmrvl_sdio.c | 13 +++++++------
>> 1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
>> index 05c78fcc13ff..24ed62fe2aeb 100644
>> --- a/drivers/bluetooth/btmrvl_sdio.c
>> +++ b/drivers/bluetooth/btmrvl_sdio.c
>> @@ -601,8 +601,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
>> 					" base0 = 0x%04X(%d)."
>> 					" Terminating download",
>> 					base0, base0);
>> -				ret = -EIO;
>> -				goto done;
>> +				goto e_io;
>> 			}
>> 			base1 = sdio_readb(card->func,
>> 					card->reg->sq_read_base_addr_a1, &ret);
>> @@ -611,8 +610,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
>> 					" base1 = 0x%04X(%d)."
>> 					" Terminating download",
>> 					base1, base1);
>> -				ret = -EIO;
>> -				goto done;
>> +				goto e_io;
>> 			}
>>
>> 			len = (((u16) base1) << 8) | base0;
>> @@ -638,8 +636,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
>> 			if (count > MAX_WRITE_IOMEM_RETRY) {
>> 				BT_ERR("FW download failure @%d, "
>> 					"over max retry count", offset);
>> -				ret = -EIO;
>> -				goto done;
>> +				goto e_io;
>> 			}
>> 			BT_ERR("FW CRC error indicated by the helper: "
>> 				"len = 0x%04X, txlen = %d", len, txlen);
>> @@ -681,6 +678,10 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
>> 	kfree(tmpfwbuf);
>> 	release_firmware(fw_firmware);
>> 	return ret;
>> +
>> +e_io:
>> +	ret = -EIO;
>> +	goto done;
>> }
> 
> I am not applying this one. I see zero benefit in this change.

Would you care for a bit of object code reduction in this function implementation.


> It is not even saving a single line since it actually is more code.

Should I fiddle with any other source code layout?

Do you find an extra blank line inappropriate before the added jump target
in this use case?

Regards,
Markus
