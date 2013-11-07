Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [PATCH 2/2] android: Add set/get for discovery timeout
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131107080758.GA7493@x220.p-661hnu-f1>
Date: Thu, 7 Nov 2013 09:14:18 +0100
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Message-Id: <2A89EA95-1DDB-4C2F-8A37-A11372E1DF06@holtmann.org>
References: <1383750530-18815-1-git-send-email-lukasz.rymanowski@tieto.com> <1383750530-18815-2-git-send-email-lukasz.rymanowski@tieto.com> <20131107080758.GA7493@x220.p-661hnu-f1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> static bool get_discoverable_timeout(void)
>> {
>> -	DBG("Not implemented");
>> +	struct hal_ev_adapter_props_changed *ev;
>> +	int len;
>> 
>> -	/* TODO: Add implementation */
>> +	len = sizeof(*ev) + sizeof(struct hal_property) + sizeof(uint32_t);
>> 
> 
> The dynamic memory allocation seems a bit overkill here since the size is
> not very big and can be determined even at compile time. I'd consider
> doing something like:
> 
> 	uint8_t buf[sizeof(struct hal_ev_adapter_props_changed) +
> 			sizeof(struct hal_property) + sizeof(uint32_t)];
> 	struct hal_ev_adapter_props_changed *ev = (void *) buf;

actually having some #define for the base len would be easier to read.

	uint8_t buf[BASELEN + sizeof(uint32_t));
 
> 
> 	...
> 
> 	ipc_send(..., sizeof(buf), buf, ...);

Of course an alternative is to use alloca to just allocate on the stack. Then no free is actually needed.

Regards

Marcel

