Return-Path: <cyrus@holtmann.org>
Message-ID: <51DBB51D.9000607@linux.intel.com>
Date: Tue, 09 Jul 2013 09:00:45 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?=
 <frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v8 2/8] Bluetooth: Remove unused mask parameter in sco_conn_defer_accept
References: <1373036503-1349-1-git-send-email-frederic.dalleau@linux.intel.com> <1373036503-1349-3-git-send-email-frederic.dalleau@linux.intel.com> <45E64423-16D6-4473-A390-226E5E76AC97@holtmann.org>
In-Reply-To: <45E64423-16D6-4473-A390-226E5E76AC97@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Le 08/07/2013 21:10, Marcel Holtmann a écrit :
> can you give the exact reference where this is stated. Since I fail to find it.

Core spec v4, 7.1.8 Accept Connection Request Command, p 472, just 
before command paremeters

"Note: When accepting synchronous connection request, the Role parameter 
is not used and will be ignored by the BR/EDR Controller."

>> -		if (lmp_rswitch_capable(hdev) && (mask & HCI_LM_MASTER))
>> -			cp.role = 0x00; /* Become master */
>> -		else
>> -			cp.role = 0x01; /* Remain slave */
>> +		cp.role = 0x00; /* Ignored */
>
> Is it really 0x00 and not 0x01 to stay slave.

Since it is ignored, there is no need to care.

Fred
