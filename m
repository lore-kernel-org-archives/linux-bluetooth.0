Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <147e8a7267ca1e890c4f1e2f9491cc93@mail.hendrik-sattler.de>
References: <1320936238-28360-1-git-send-email-luiz.dentz@gmail.com>
	<1320936238-28360-3-git-send-email-luiz.dentz@gmail.com>
	<147e8a7267ca1e890c4f1e2f9491cc93@mail.hendrik-sattler.de>
Date: Fri, 11 Nov 2011 11:00:27 +0200
Message-ID: <CABBYNZKT4X6FvBpxpNyTvkgsEk4y6GHXX2-jKZNyHHN-=RqaTQ@mail.gmail.com>
Subject: Re: [PATCH obexd 3/9] gobex: add unit test for CONNECT followed by
 GET request
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Hendrik Sattler <post@hendrik-sattler.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hendrik,

On Thu, Nov 10, 2011 at 5:02 PM, Hendrik Sattler
<post@hendrik-sattler.de> wrote:
> Am 10.11.2011 15:43, schrieb Luiz Augusto von Dentz:
>>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> ---
>>  unit/test-gobex-transfer.c |   68
>> ++++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 68 insertions(+), 0 deletions(-)
>>
>> diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
>> index 32dc8bb..9cb1f46 100644
>> --- a/unit/test-gobex-transfer.c
>> +++ b/unit/test-gobex-transfer.c
>> @@ -71,6 +71,13 @@ static guint8 conn_rsp[] = { G_OBEX_RSP_SUCCESS |
>> FINAL_BIT, 0x00, 0x0c,
>>                                        0x10, 0x00, 0x10, 0x00, 0xcb, 0x00,
>>                                        0x00, 0x00, 0x01 };
>>
>> +static guint8 conn_get_req_first[] = { G_OBEX_OP_GET | FINAL_BIT,
>> 0x00, 0x28,
>> +       G_OBEX_HDR_CONNECTION, 0x00, 0x00, 0x00, 0x01,
>> +       G_OBEX_HDR_TYPE, 0x00, 0x0b,
>> +       'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
>> +       G_OBEX_HDR_NAME, 0x00, 0x15,
>> +       0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0,
>> 0 };
>
> If you want the test data to be realistic: when targetting default OBEX
> inbox, you can only use type _or_ name, not both.

For OBEX/Bluetooth specific types it can be true, but type can also be
used as a regular mime-type/RFC 1521, maybe the type in this case is
not realistic and we should be using text/plain.


-- 
Luiz Augusto von Dentz
