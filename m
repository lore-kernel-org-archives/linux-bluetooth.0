Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC v3] doc: Connection Parameters command and event
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJ5+1XjWLn2o68yNjTzEj-XtzV_p_VH89fHfUXRuPhorA@mail.gmail.com>
Date: Wed, 25 Jun 2014 15:14:55 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Andre Guedes <andre.guedes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <53698982-4F49-4BD9-8E6A-29A017302F95@holtmann.org>
References: <1396906610-3853-1-git-send-email-andre.guedes@openbossa.org> <03ACEBDE-F9B0-44F2-8466-CC578C37D8C1@holtmann.org> <20140408095622.GA21390@t440s.spectrum.wifi> <BEB72C39-8137-4270-8C93-2634CC329AF9@holtmann.org> <CABBYNZJ5+1XjWLn2o68yNjTzEj-XtzV_p_VH89fHfUXRuPhorA@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>>>>> +Load Connection Parameters Command
>>>>> +====================================
>>>>> +
>>>>> +   Command Code:           0x0031
>>>>> +   Controller Index:       <controller id>
>>>>> +   Command Parameters:     Params_Count (2 Octets)
>>>> 
>>>>                             Param_Count
>>>> 
>>>>> +                           Params1 {
>>>> 
>>>>                             Param1
>>>>> +                                   Address (6 Octets)
>>>>> +                                   Address_Type (1 Octet)
>>>>> +                                   Min_Connection_Interval (2 Octets)
>>>>> +                                   Max_Connection_Interval (2 Octes)
>>>>> +                                   Connection_Latency (2 Octets)
>>>>> +                                   Supervision_Timeout (2 Octets)
>>>>> +                           }
>>>>> +                           Params2 {  }
> 
> Regarding the parameters it seems we should include the scan interval
> and window as well otherwise the logic will not be completely in the
> kernel and the userspace will still have to keep a list of devices and
> set the scan parameters by itself. IMO it would be better the leave
> the kernel to control everything, anyway it will have to deal with
> scanning logic based on connection list, so it will be able to detect
> if a certain connection requires a more aggressive scanning and also
> relax the scanning once connected.

the reason why did it this way is, because these are the exact parameters used by the Connection Update Procedure. The scan parameters are actually not really of a concern.

Also keep in mind that these parameters are triggered mainly by the slave to update the parameters of the connection. And picking the right ones from the start increases the connection establishment time and the overall latency.

I left the scan parameters out on purpose since I do not want to have two policy engines fighting over who decides which scan parameters to use. My expectation is that the scan parameters will be mainly driven by the daemon that decides on how to use them. Today, we have already this. Userspace configured them and it is up to the kernel to just enforce it.

For connection establishment without a whitelist, you pick parameters with scan window and scan interval as the same value. Which essentially means a continues scan until the device has been found. So having extra scan parameters will not help you there. For the passive background scanning, userspace can happily tell the kernel and then the kernel can just adjust the scanning.

Regards

Marcel

