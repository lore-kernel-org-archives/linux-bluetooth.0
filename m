Return-Path: <cyrus@holtmann.org>
Message-ID: <4E4E2821.5040206@linux.intel.com>
Date: Fri, 19 Aug 2011 11:08:49 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] doc: add org.bluez.Handsfree interface
References: <1313155680-10759-1-git-send-email-frederic.danis@linux.intel.com> <20110812135543.GA4168@joana>
In-Reply-To: <20110812135543.GA4168@joana>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Gustavo,

Le 12/08/2011 15:55, Gustavo Padovan a écrit :
> * Frédéric Danis<frederic.danis@linux.intel.com>  [2011-08-12 15:28:00 +0200]:
>
>> This change allows to share the same interface for both Handsfree HF
>> and AG (only diffrence is interface name), and most part of the code.
>>
>> This will imply to rename and update audio/gateway.[ch] to be more hfp
>> generic (moving it to audio/hfp.[ch], renaming APIs from gateway_...()
>> to hfp_...()).
>
> what will be the future of the current implementation of the HFP Audio Gateway
> implementation in BlueZ. Will it be  deprecated?
>
> 	Gustavo

I do not know what will be the future, this proposal just add a new 
interface allowing an external application (like oFono) to implement the 
Handsfree Audio Gateway profile in a similar way than for current 
Handsfree headset.

This allows the application to focus on profile implementation, letting 
management of Bluetooth part (SDP advertisement, connection, 
authentication, authorization, ...) to BlueZ.

Fred

-- 
Frederic Danis                            Open Source Technology Centre
frederic.danis@intel.com                              Intel Corporation

