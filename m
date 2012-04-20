Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120413221700.GF1680@joana>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
	<1334243001-17016-27-git-send-email-s.syam@samsung.com>
	<20120413221700.GF1680@joana>
Date: Fri, 20 Apr 2012 15:13:44 -0300
Message-ID: <CACJA=fW=3ZHUh1r-TzDPhsxydRkDJiN62Dg4yMetw1v+i-zf_Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] Bluetooth: Remove unused hci_le_ltk_reply()
From: Andre Guedes <andre.guedes@openbossa.org>
To: Gustavo Padovan <gustavo@padovan.org>,
	Syam Sidhardhan <s.syam@samsung.com>,
	linux-bluetooth@vger.kernel.org,
	Vinicius Gomes <vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam/Gustavo,

On Fri, Apr 13, 2012 at 7:17 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
> Hi Syam,
>
> * Syam Sidhardhan <s.syam@samsung.com> [2012-04-12 20:33:17 +0530]:
>
>> In this API, we were using sizeof operator for an array
>> given as function argument, which is invalid.
>> However this API is not used anywhere.
>>
>> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
>> ---
>>  include/net/bluetooth/hci_core.h |    1 -
>>  net/bluetooth/hci_conn.c         |   16 ----------------
>>  2 files changed, 0 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index c0b232c..6e170de 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -1069,7 +1069,6 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
>>                                       u16 latency, u16 to_multiplier);
>>  void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
>>                                                       __u8 ltk[16]);
>> -void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
>
> I'll let Andre comment here, I'm not sure if this is going to be used on
> the future or not.

I'm not sure too, I think Vinicius can tell more about that.

Regarding the memcpy call, yes, it is definitely bogus.

Regards,

Andre
