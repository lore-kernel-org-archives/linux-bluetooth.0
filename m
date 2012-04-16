Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120416084522.GA24483@x220.ger.corp.intel.com>
References: <1334553181-10884-1-git-send-email-hemant.gupta@stericsson.com>
	<20120416084522.GA24483@x220.ger.corp.intel.com>
Date: Mon, 16 Apr 2012 14:35:27 +0530
Message-ID: <CACj007mQ6kGvaj0KCpyS9=Td8xiXJs1rR3Ur66TOb9mtCQ3Tmw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: mgmt: Fix address type while loading Long Term Key
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Cc: Naresh Gupta <naresh.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Apr 16, 2012 at 2:15 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Hemant,
>
> On Mon, Apr 16, 2012, Hemant Gupta wrote:
>> This patch fixes the address type while loading long term keys when BT is
>> switched on. Without this fix pairing is reinitated even though LTK exists
>> for remote device because of mismatch of address type.
>>
>> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
>> ---
>>  net/bluetooth/mgmt.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 880b7c9..b84de64 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -2652,7 +2652,8 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
>>               else
>>                       type = HCI_SMP_LTK_SLAVE;
>>
>> -             hci_add_ltk(hdev, &key->addr.bdaddr, key->addr.type,
>> +             hci_add_ltk(hdev, &key->addr.bdaddr,
>> +                         mgmt_to_link(LE_LINK, key->addr.type),
>>                           type, 0, key->authenticated, key->val,
>>                           key->enc_size, key->ediv, key->rand);
>>       }
>
> This doesn't compile:
>
> net/bluetooth/mgmt.c: In function 'load_long_term_keys':
> net/bluetooth/mgmt.c:2656:8: error: implicit declaration of function 'mgmt_to_link' [-Werror=implicit-function-declaration]
Thanks for comment, I forgot to send a dependent patch somehow. have
sent it now.

>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
