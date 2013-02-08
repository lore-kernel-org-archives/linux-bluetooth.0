Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1359766284.16887.2.camel@aeonflux>
References: <1359765878-31409-1-git-send-email-andre.guedes@openbossa.org>
	<1359765878-31409-2-git-send-email-andre.guedes@openbossa.org>
	<1359766284.16887.2.camel@aeonflux>
Date: Thu, 7 Feb 2013 22:33:59 -0300
Message-ID: <CACJA=fVEBf=ecV5yxc3VaGiOpMqQAFCUSr=SeC_VW=5HZXiE4Q@mail.gmail.com>
Subject: Re: [RFC 1/7] Bluetooth: Add new connection states
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Feb 1, 2013 at 9:51 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andre,
>
>> This patch adds two new connection states which will be used by
>> hci_conn to establish LE connections.
>>
>> BT_SCAN state means the controller is scanning for LE devices. Once
>> the target device is found, the connection goes to BT_DEV_FOUND
>> state, and then to BT_CONNECT state.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>>  include/net/bluetooth/bluetooth.h | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>> index 9531bee..add5721 100644
>> --- a/include/net/bluetooth/bluetooth.h
>> +++ b/include/net/bluetooth/bluetooth.h
>> @@ -126,7 +126,9 @@ enum {
>>       BT_CONNECT2,
>>       BT_CONFIG,
>>       BT_DISCONN,
>> -     BT_CLOSED
>> +     BT_CLOSED,
>> +     BT_SCAN,
>> +     BT_DEV_FOUND
>>  };
>
> I am actually against this. These states where originally socket states
> and not general states that we just pile on top of.
>
> You need to create separate state handling for LE connection handling. I
> am really not happy that we always try to shoe-horn this onto something
> else.

Ok, I'll create a separated state for LE connection handling.

Regards,

Andre
