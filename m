Return-Path: <cyrus@holtmann.org>
Sender: Jiri Slaby <jirislaby@gmail.com>
Message-ID: <54F09ABA.3080307@suse.cz>
Date: Fri, 27 Feb 2015 17:26:34 +0100
From: Jiri Slaby <jslaby@suse.cz>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
 BlueZ development <linux-bluetooth@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Gustavo F. Padovan" <gustavo@padovan.org>
Subject: Re: [PATCH v2 1/1] Bluetooth: make hci_test_bit's addr const
References: <1424354164-11728-1-git-send-email-jslaby@suse.cz> <1424355643-30660-1-git-send-email-jslaby@suse.cz> <21570C6D-0C2F-40CA-9100-5A5CC7D1CEAB@holtmann.org>
In-Reply-To: <21570C6D-0C2F-40CA-9100-5A5CC7D1CEAB@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 02/19/2015, 05:10 PM, Marcel Holtmann wrote:
> Hi Jiri,
> 
>> gcc5 warns about passing a const array to hci_test_bit which takes a
>> non-const pointer:
>> net/bluetooth/hci_sock.c: In function ‘hci_sock_sendmsg’:
>> net/bluetooth/hci_sock.c:955:8: warning: passing argument 2 of ‘hci_test_bit’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-array-qualifiers]
>>        &hci_sec_filter.ocf_mask[ogf])) &&
>>        ^
>> net/bluetooth/hci_sock.c:49:19: note: expected ‘void *’ but argument is of type ‘const __u32 (*)[4] {aka const unsigned int (*)[4]}’
>> static inline int hci_test_bit(int nr, void *addr)
>>                   ^
>>
>> So make 'addr' 'const void *'.
>>
>> [v2] make the pointer in the cast const too. 
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> Cc: Marcel Holtmann <marcel@holtmann.org>
>> Cc: Gustavo Padovan <gustavo@padovan.org>
>> Cc: Johan Hedberg <johan.hedberg@gmail.com>
>> ---
>> net/bluetooth/hci_sock.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
>> index 1d65c5be7c82..d1a7d67619d8 100644
>> --- a/net/bluetooth/hci_sock.c
>> +++ b/net/bluetooth/hci_sock.c
>> @@ -46,9 +46,9 @@ struct hci_pinfo {
>> 	unsigned short    channel;
>> };
>>
>> -static inline int hci_test_bit(int nr, void *addr)
>> +static inline int hci_test_bit(int nr, const void *addr)
>> {
>> -	return *((__u32 *) addr + (nr >> 5)) & ((__u32) 1 << (nr & 31));
>> +	return *((const __u32 *) addr + (nr >> 5)) & ((__u32) 1 << (nr & 31));
>> }
> 
> we had a lengthy discussion about this before. I am reluctant to change any of this until we have a test tool that proofs this does not break userspace API compatibility.
> 
> I don't see how just adding const would break anything, but I cautious since this code is pretty much a big mistake that we are carrying around for almost 14 years now.

Yeah, I understand, but relying on the compiler is worse in this case, I
think. Here, the function casts away const from a const array, which is
undefined behaviour (6.7.3 of the standard).

So all in all I believe applying this fix cannot make the code worse.

thanks,
-- 
js
suse labs
