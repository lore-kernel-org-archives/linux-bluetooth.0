Return-Path: <cyrus@holtmann.org>
Message-ID: <4B4D7A51.5000702@linux.intel.com>
Date: Wed, 13 Jan 2010 15:46:25 +0800
From: Zhu Yanhai <yanhai.zhu@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Don't pass down NULL path to dbus if no modem.
References: <1263276935-7456-1-git-send-email-yanhai.zhu@linux.intel.com> <20100113062819.GA16896@jh-x301> <4B4D6DC3.2020407@linux.intel.com> <20100113073539.GA18361@jh-x301>
In-Reply-To: <20100113073539.GA18361@jh-x301>
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 01/13/2010 03:35 PM, Johan Hedberg wrote:
> On Wed, Jan 13, 2010, Zhu Yanhai wrote:
>>> 2. Leaking modem_obj_path if it was already set
>> I think it will be freed in telephony_exit().
> 
> The point was that if you fetch the modems list more than once or if
> there's more than one modem the previous value of modem_obj_path will be
> overwritten with a new one without freeing the original string first.
> 
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
I see...it seems that we don't have multiple modems plan yet...ok let's
just use the first modem we saw in the system. I will patch this part and
send a separate patch later today.

Thanks,
Zhu Yanhai
