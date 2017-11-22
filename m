Return-Path: <rdunlap@infradead.org>
Subject: Re: [PATCH v1] Bluetooth: introduce DEFINE_SHOW_ATTRIBUTE() macro
From: Randy Dunlap <rdunlap@infradead.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
References: <20171122211546.5682-1-andriy.shevchenko@linux.intel.com>
 <13210ec5-af8a-3b3e-0a1c-9ffa751651e8@infradead.org>
Message-ID: <2404941a-6e4a-3665-f737-00b48819d204@infradead.org>
Date: Wed, 22 Nov 2017 14:13:04 -0800
MIME-Version: 1.0
In-Reply-To: <13210ec5-af8a-3b3e-0a1c-9ffa751651e8@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 11/22/2017 02:04 PM, Randy Dunlap wrote:
> On 11/22/2017 01:15 PM, Andy Shevchenko wrote:
>> This macro deduplicates a lot of similar code across the hci_debugfs.c
>> module. Targeting to be moved to seq_file.h eventually.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  net/bluetooth/hci_debugfs.c | 184 +++++---------------------------------------
>>  1 file changed, 18 insertions(+), 166 deletions(-)
> 
> Looks like a good idea, but below, there is a use of
> DEFINE_SHOW_ATTRIBUTE() before it is #defined.
> 
>> diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
>> index 63df63ebfb24..d4174d508cbf 100644
>> --- a/net/bluetooth/hci_debugfs.c
>> +++ b/net/bluetooth/hci_debugfs.c
>> @@ -88,6 +88,9 @@ static int __name ## _show(struct seq_file *f, void *ptr)		      \
>>  	return 0;							      \
>>  }									      \
>>  									      \
>> +DEFINE_SHOW_ATTRIBUTE(__name)
> 
> eh?

OK, it's a continuation of the macro above it.
Sorry about that.


>> +> +#define DEFINE_SHOW_ATTRIBUTE(__name)					      \
>>  static int __name ## _open(struct inode *inode, struct file *file)	      \
>>  {									      \
>>  	return single_open(file, __name ## _show, inode->i_private);	      \
> 
> 


-- 
~Randy
