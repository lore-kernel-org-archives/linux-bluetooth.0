Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <c441e70652.davehigton@dsl.pipex.com>
References: <7b86640552.davehigton@dsl.pipex.com>
	<CAMhHtTy7vStrSEZsj6Gcy_VO-JfL4tuYZ=TJWtQ4TxqMMGQpTQ@mail.gmail.com>
	<CAMhHtTytv2Q4JPE85T-zqgbrqpq+9XHRbgYtQWADeoip9yCP5A@mail.gmail.com>
	<c441e70652.davehigton@dsl.pipex.com>
Date: Mon, 22 Aug 2011 23:02:36 +0300
Message-ID: <CABBYNZKLbkKFt9+vYSifS8PikzmDVMBqFq-P60ec+kWSqu-1PA@mail.gmail.com>
Subject: Re: Arguments to PIN Code Request Response
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Dave Higton <davehigton@dsl.pipex.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dave,

On Mon, Aug 22, 2011 at 10:49 PM, Dave Higton <davehigton@dsl.pipex.com> wrote:
> In message
> <CAMhHtTytv2Q4JPE85T-zqgbrqpq+9XHRbgYtQWADeoip9yCP5A@mail.gmail.com>
>          Ash K <ashoksarf@gmail.com> wrote:
>
>> Hi Dave,
>>
>> If you see specification the PIN_Code parameter for
>> PIN_Code_request_reply command, it says
>>
>> Value
>> ----
>> 0xXXXXXXXXXX
>> XXXXXXXXXXX
>> XXXXXXXXXXX
>>  Parameter Description
>> ----
>> PIN code for the device that is to be connected. The Host should
>> ensure that strong PIN Codes are used. PIN Codes can be up to a
>> maximum of 128 bits. Note: The PIN_Code Parameter is a string
>> parameter. Endianess does therefore not apply to the PIN_Code
>> Parameter. The first octet of the PIN code should be transmitted first.
>> Which means, even if your PIN code of 4 byte length you have to send
>> 16 byte length of PIN code to controller. And controller uses initial
>> bytes from the 16byte PIN code, the length of the PIN code is defined
>> by length parameter.
>> What you are looking at is correct, after 4 bytes of PIN code, you
>> have some junk/host selected data which is of no interest to
>> controller.
>
> Many thanks for your explanation, Ash.

Btw, you can use hcidump to get some traces.

-- 
Luiz Augusto von Dentz
