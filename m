Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120502145830.GA16030@joana>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
	<1334243001-17016-27-git-send-email-s.syam@samsung.com>
	<20120502145830.GA16030@joana>
Date: Thu, 3 May 2012 11:27:08 +0530
Message-ID: <CAFBvHidB1vSvqjVjHxFjqQ+C8TkQAgDNmfRQJoGw__SVrx9NRw@mail.gmail.com>
Subject: Re: [PATCH 1/5] Bluetooth: Remove unused hci_le_ltk_reply()
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	Syam Sidhardhan <s.syam@samsung.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius, Gustavo and Johan,

On Wed, May 2, 2012 at 8:28 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
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
>
> Patch has been applied to bluetooth-next. Thanks.
>

Thanks for reviewing and applying it.

There is one more patch pending for the review in that series. [PATCH
v1 2/5] Bluetooth: Remove unused hci_le_ltk_neg_reply()

Regards,
Syam.

>        Gustavo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
