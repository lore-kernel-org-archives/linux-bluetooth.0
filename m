Return-Path: <cyrus@holtmann.org>
Message-ID: <4C36423A.8040201@gmail.com>
Date: Thu, 08 Jul 2010 14:25:14 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8 v2]Bluetooth: Fix warning: variable 'tty' set but
 not used
References: <1276565200-5583-1-git-send-email-justinmattock@gmail.com> <1278623228.10421.70.camel@localhost.localdomain>
In-Reply-To: <1278623228.10421.70.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/08/2010 02:07 PM, Marcel Holtmann wrote:
> Hi Justin,
>
>> Resend of this patch to fix whitespace issues
>> The patch below fixes a warning message
>> when using gcc 4.6.0
>>
>>    CC [M]  drivers/bluetooth/hci_ldisc.o
>> drivers/bluetooth/hci_ldisc.c: In function 'hci_uart_send_frame':
>> drivers/bluetooth/hci_ldisc.c:213:21: warning: variable 'tty' set but not used
>>
>>
>>   Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
>>   Reviewed-By: Gustavo F. Padovan<gustavo@padovan.org>
>
> patch has been applied to bluetooth-next-2.6 tree. Thanks.
>
> Regards
>
> Marcel
>
>
>


cool..

Justin P. Mattock
