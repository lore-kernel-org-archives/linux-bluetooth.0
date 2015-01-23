Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150123121426.GA14616@t440s.lan>
References: <1422014012-6840-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1422014012-6840-2-git-send-email-lukasz.rymanowski@tieto.com>
	<20150123121426.GA14616@t440s.lan>
Date: Fri, 23 Jan 2015 15:40:51 +0100
Message-ID: <CAMudyAsxs=-A8ByHCVLj28sR9fD0z3no==mAgeaRwJBk_S_0-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Use reject error code in pair device method
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan

On 23 January 2015 at 13:14, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lukasz,
>
> On Fri, Jan 23, 2015, Lukasz Rymanowski wrote:
>> If user space is trying to do LE pair but LE has not been enabled then
>> MGMT_STATUS_REJECT will be returned.
>>
>> Same result code will be returned also in case of BREDR pairing if BREDR
>> is not enabled.
>>
>> Having separate error code for that scenario might be useful for
>> debugging at least.
>>
>> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
>> ---
>>  net/bluetooth/mgmt.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 41e3005..e03e63c 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -3246,6 +3246,8 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
>>
>>               if (PTR_ERR(conn) == -EBUSY)
>>                       status = MGMT_STATUS_BUSY;
>> +             else if (PTR_ERR(conn) == -EOPNOTSUPP)
>> +                     status = MGMT_STATUS_REJECTED;
>>               else
>>                       status = MGMT_STATUS_CONNECT_FAILED;
>
> Good catch, but I'd like to keep this consistent with our handling of LE
> support elsewhere. Particularly, I'd like to follow the same semantics
> as the mgmt_le_support() helper function, meaning if the HW doesn't
> support LE we get NOT_SUPPORTED whereas if it does support LE but it's
> simply not enabled we get REJECTED.
>
> You could e.g. use EOPNOTSUPP for non-LE HW and ECONNREFUSED for LE not
> enabled (feel free to propose a better errno to mgmt status mapping).
>
Ok.
I could not found any better error code than  ECONNREFUSED so I will go for it.

Also going with your proposal I should probably change hci_connect_acl
in the same way.
Meaning return EOPNOTSUPP if it is LE only chip and ECONNREFUSED if it
is dual but
BREDR is disabled.

Do you agree?

> Johan
