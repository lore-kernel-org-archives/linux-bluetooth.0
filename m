Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <EBF0FA29-819E-4419-84D1-9CE22E8AE0A5@holtmann.org>
References: <20180126130652.3499127-1-arnd@arndb.de> <EBF0FA29-819E-4419-84D1-9CE22E8AE0A5@holtmann.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 26 Jan 2018 17:06:44 +0100
Message-ID: <CAK8P3a1-b+wPsYhTUF9GLcpDqfo3R1SCCiOKn=hP6YwB+tCu5Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btintel: remove extraneous semicolon
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Tedd Ho-Jeong An <tedd.an@linux.intel.com>,
	Bluez mailing list <linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jan 26, 2018 at 4:22 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Arnd,
>
>> The newly added btintel_download_firmware() dummy helper definition is
>> incorrect, causing a build error when CONFIG_BT_INTEL is disabled:
>>
>> In file included from drivers/bluetooth/hci_ldisc.c:49:0:
>> drivers/bluetooth/btintel.h:196:1: error: expected identifier or '(' bef=
ore '{' token
>> drivers/bluetooth/btintel.h:193:19: error: 'btintel_download_firmware' d=
eclared 'static' but never defined [-Werror=3Dunused-function]
>>
>> Removing the semicolon makes it work again.
>>
>> Fixes: 0bd4ded3287d ("Bluetooth: btintel: Create common function for fir=
mware download")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> drivers/bluetooth/btintel.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
>> index 01728e212267..41c642cc523f 100644
>> --- a/drivers/bluetooth/btintel.h
>> +++ b/drivers/bluetooth/btintel.h
>> @@ -192,7 +192,7 @@ static inline int btintel_read_boot_params(struct hc=
i_dev *hdev,
>>
>> static inline int btintel_download_firmware(struct hci_dev *dev,
>>                                           const struct firmware *fw,
>> -                                         u32 *boot_param);
>> +                                         u32 *boot_param)
>> {
>>       return -EOPNOTSUPP;
>> }
>
> didn=E2=80=99t I fix this before sending the pull request? Can you check =
against
> net-next tree that this is still an issue?

It's fixed in net-next. I looked at linux-next, which apparently had an
older version of the commit when Stephen pulled the tree into today's
linux-next, through bluetooth-next.git#master.

         Arnd
