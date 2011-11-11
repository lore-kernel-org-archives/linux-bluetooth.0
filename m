Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8f72b5bd93989eb4d9bd21c40ab4eba6@mail.hendrik-sattler.de>
References: <1320936238-28360-1-git-send-email-luiz.dentz@gmail.com>
	<1320936238-28360-6-git-send-email-luiz.dentz@gmail.com>
	<8f72b5bd93989eb4d9bd21c40ab4eba6@mail.hendrik-sattler.de>
Date: Fri, 11 Nov 2011 11:04:27 +0200
Message-ID: <CABBYNZ+m533j5WK-JuKSDR7rdnNF4x5NVWqZSTgq0F__31L70A@mail.gmail.com>
Subject: Re: [PATCH obexd 6/9] gobex: add unit test for CONNECT followed by
 PUT response
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Hendrik Sattler <post@hendrik-sattler.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hendrik,

On Thu, Nov 10, 2011 at 5:25 PM, Hendrik Sattler
<post@hendrik-sattler.de> wrote:
> Am 10.11.2011 15:43, schrieb Luiz Augusto von Dentz:
>>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> ---
>>  unit/test-gobex-transfer.c |   60
>> ++++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 60 insertions(+), 0 deletions(-)
>>
>> diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
>> index 860f129..f3eb0bf 100644
>> --- a/unit/test-gobex-transfer.c
>> +++ b/unit/test-gobex-transfer.c
>> @@ -73,6 +73,9 @@ static guint8 conn_rsp[] = { G_OBEX_RSP_SUCCESS |
>> FINAL_BIT, 0x00, 0x0c,
>>  static guint8 conn_rsp_2[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00,
>> 0x0c,
>>                                        0x10, 0x00, 0x10, 0x00, 0xcb, 0x00,
>>                                        0x00, 0x00, 0x02 };
>> +static guint8 conn_rsp_3[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00,
>> 0x0c,
>> +                                       0x10, 0x00, 0x10, 0x00, 0xcb,
>> 0x00,
>> +                                       0x00, 0x00, 0x03 };
>>
>>  static guint8 conn_get_req_first[] = { G_OBEX_OP_GET | FINAL_BIT,
>> 0x00, 0x28,
>>        G_OBEX_HDR_CONNECTION, 0x00, 0x00, 0x00, 0x01,
>> @@ -95,6 +98,14 @@ static guint8 conn_put_req_first[] = {
>> G_OBEX_OP_PUT, 0x00, 0x35,
>>        0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0,
>> 0,
>>        G_OBEX_HDR_BODY, 0x00, 0x0d,
>>        0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
>> +static guint8 conn_put_req_first_3[] = { G_OBEX_OP_PUT, 0x00, 0x35,
>> +       G_OBEX_HDR_CONNECTION, 0x00, 0x00, 0x00, 0x03,
>> +       G_OBEX_HDR_TYPE, 0x00, 0x0b,
>> +       'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
>> +       G_OBEX_HDR_NAME, 0x00, 0x15,
>> +       0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0,
>> 0,
>> +       G_OBEX_HDR_BODY, 0x00, 0x0d,
>> +       0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
>
> Not BODY_END header?

BODY_END is sent in a separated packet, see put_req_last, although it
is probably a good idea to add testes which send it in the same
packet.

-- 
Luiz Augusto von Dentz
