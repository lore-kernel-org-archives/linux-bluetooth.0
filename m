Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <d60687a84c59eb336babf09ec327d89a@mail.hendrik-sattler.de>
References: <1320936238-28360-1-git-send-email-luiz.dentz@gmail.com>
	<d60687a84c59eb336babf09ec327d89a@mail.hendrik-sattler.de>
Date: Fri, 11 Nov 2011 11:00:57 +0200
Message-ID: <CABBYNZ+gABg7BOoXqc8jTvKzdJg7fGNhiY7O8EJ5GUSYmWaeiQ@mail.gmail.com>
Subject: Re: [PATCH obexd 1/9] gobex: add unit test for CONNECT request
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Hendrik Sattler <post@hendrik-sattler.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hendrik,

On Thu, Nov 10, 2011 at 5:08 PM, Hendrik Sattler
<post@hendrik-sattler.de> wrote:
> Am 10.11.2011 15:43, schrieb Luiz Augusto von Dentz:
>>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> ---
>>  unit/test-gobex-transfer.c |   56
>> ++++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 56 insertions(+), 0 deletions(-)
>>
>> diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
>> index a246418..ac6356d 100644
>> --- a/unit/test-gobex-transfer.c
>> +++ b/unit/test-gobex-transfer.c
>> @@ -65,6 +65,12 @@ static guint8 get_rsp_first[] = {
>> G_OBEX_RSP_CONTINUE | FINAL_BIT, 0x00, 0x10,
>>  static guint8 get_rsp_last[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00,
>> 0x06,
>>                                        G_OBEX_HDR_BODY_END, 0x00, 0x03 };
>>
>> +static guint8 conn_req[] = { G_OBEX_OP_CONNECT | FINAL_BIT, 0x00, 0x07,
>> +                                       0x10, 0x00, 0x10, 0x00 };
>> +static guint8 conn_rsp[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x0c,
>> +                                       0x10, 0x00, 0x10, 0x00, 0xcb,
>> 0x00,
>> +                                       0x00, 0x00, 0x01 };
>> +
>
> Maybe replace 0xcb with G_OBEX_HDR_CONNECTION?

Yep, gonna fix it.

-- 
Luiz Augusto von Dentz
