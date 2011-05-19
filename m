Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 May 2011 09:58:04 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Suraj Sumangala <suraj@Atheros.com>
cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	Arun Kumar SINGH <arunkr.singh@stericsson.com>,
	Anurag Gupta <anurag1303@gmail.com>,
	Peter Krystad <pkrystad@codeaurora.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: BT 3.0 HS Support in BlueZ
In-Reply-To: <4DD4AB14.9050401@Atheros.com>
Message-ID: <alpine.DEB.2.00.1105190939240.22147@localhost6.localdomain6>
References: <BANLkTimKJNo9WgwkfC2Hci-dW6kjF3VWGw@mail.gmail.com> <20110419180425.GA2476@joana> <AFCDDB4A3EA003429EEF1E7B211FDBBA3395937A4C@EXDCVYMBSTM005.EQ1STM.local> <20110505201531.GE2098@joana> <alpine.DEB.2.00.1105051548540.4213@localhost6.localdomain6>
 <20110509225246.GB2203@joana> <alpine.DEB.2.00.1105181352000.32548@localhost6.localdomain6> <4DD4AB14.9050401@Atheros.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On Thu, 19 May 2011, Suraj Sumangala wrote:

> Hi Mat,
>
> On 5/19/2011 2:28 AM, Mat Martineau wrote:
>> 
>> Gustavo,
>> 
>> On Mon, 9 May 2011, Gustavo F. Padovan wrote:
>>

... snip ...

>>> 
>>> Isn't Extended Flow Specification a required feature for AMP? I haven't 
>>> seen
>>> it in your implementation.
>> 
>> Extended Flowspec is needed to create an L2CAP channel directly on
>> AMP, but the implementation you're looking at does not implement the
>> "create channel" feature.  Channels are created on BR/EDR and moved
>> to AMP, which does not require extended flowspec.
>> 
>
> Why don't we have to use EFS for channels moved from BDR? Is it because we 
> assume that the QoS provided by AMP will be better than BDR?

Only "Best Effort" is supported by this implementation so QoS is 
equivalent on either controller type.  EFS is optional when creating 
channels on BR/EDR, and the spec does not require EFS when moving to a 
Best Effort AMP link.  We've extensively interop'd AMP channel moves 
without EFS.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
