Return-Path: <cyrus@holtmann.org>
Message-ID: <54CFE6FA.5020203@sunrus.com.cn>
Date: Tue, 03 Feb 2015 05:07:06 +0800
From: Chen Gang S <gang.chen@sunrus.com.cn>
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>
CC: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
 "David S. Miller" <davem@davemloft.net>,
 linux-bluetooth@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] bluetooth: hci_sock: Use type cast "(void *)" to avoid
 building warnings
References: <54CFE01D.5090309@sunrus.com.cn> <1422909598.30476.20.camel@perches.com>
In-Reply-To: <1422909598.30476.20.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

On 2/3/15 04:39, Joe Perches wrote:
> On Tue, 2015-02-03 at 04:37 +0800, Chen Gang S wrote:
>> The related warning (with allmodconfig under xtensa):
> []
>> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> []
>> @@ -952,7 +952,7 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
>>  
>>  		if (((ogf > HCI_SFLT_MAX_OGF) ||
>>  		     !hci_test_bit(ocf & HCI_FLT_OCF_BITS,
>> -				   &hci_sec_filter.ocf_mask[ogf])) &&
>> +				   (void *)&hci_sec_filter.ocf_mask[ogf])) &&
>>  		    !capable(CAP_NET_RAW)) {
>>  			err = -EPERM;
>>  			goto drop;
> 
> Probably better to change the hci_test_bit to take const void *
> 
> static inline int hci_test_bit(int nr, void *addr)
> {
> 	return *((__u32 *) addr + (nr >> 5)) & ((__u32) 1 << (nr & 31));
> }
> 

Yeah, thanks. It should be fixed like what you said above, I shall send
patch v2 for it.


Thanks.
-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
