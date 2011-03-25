Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110324185759.GB2236@joana>
References: <1300979768-31963-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1300979768-31963-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20110324185759.GB2236@joana>
Date: Fri, 25 Mar 2011 11:35:04 +0200
Message-ID: <AANLkTimW5=zRZkYBpVCCGeYbm0+g0O4HaaQd4VgyhvCw@mail.gmail.com>
Subject: Re: [RFCv1 2/3] Bluetooth: remove duplicated code
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Mar 24, 2011 at 8:57 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Andrei,
>
> * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-03-24 17:16:07 +0200]:
>
>> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>>
>> info_timer takes care about removed code
>>
>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>> ---
>>  net/bluetooth/l2cap_core.c |   12 +++---------
>>  1 files changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index fd58b8f..4255f00 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -2472,16 +2472,10 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
>>               return 0;
>>       }
>>
>> -     del_timer(&conn->info_timer);
>> -
>> -     if (result != L2CAP_IR_SUCCESS) {
>> -             conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
>> -             conn->info_ident = 0;
>> -
>> -             l2cap_conn_start(conn);
>
> Are you sure? Does remove this code won't create a delay to call
> l2cap_conn_start()?

Yes, but the difference is only with delay. I believe that this way it
will be cleaner.

Do you think that it could cause problems?

Regards,
Andrei
