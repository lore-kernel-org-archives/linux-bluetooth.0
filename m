Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Jul 2012 13:46:16 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org
Subject: Re: [RFCv0 16/19] Bluetooth: Add function to derive AMP key using
 hmac
In-Reply-To: <20120713071124.GA2729@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1207161339390.2846@mathewm-linux>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1340981212-21709-17-git-send-email-Andrei.Emeltchenko.news@gmail.com> <20120712143029.GA1141@aemeltch-MOBL1> <alpine.DEB.2.02.1207121637410.28444@mathewm-linux>
 <20120713071124.GA2729@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Andrei -

On Fri, 13 Jul 2012, Andrei Emeltchenko wrote:

> Hi Mat,
>
> On Thu, Jul 12, 2012 at 04:55:35PM -0700, Mat Martineau wrote:
>>
>> Andrei -
>>
>> On Thu, 12 Jul 2012, Andrei Emeltchenko wrote:
>>
>>> Hi Mat,
>>>
>>> On Fri, Jun 29, 2012 at 05:46:49PM +0300, Andrei Emeltchenko wrote:
>>>> From: Dmitry Kasatkin <dmitry.kasatkin@intel.com>
>>>>
>>>> hmac(sha256) will be used for AMP key generation.
>>>
>>> What do you think about this approach for key generation?
>>
>> I think it makes a lot of sense to use the synchronous API for
>> generating the key.  As long as it generates the right key, this
>> code looks good to me.
>
> Thanks for looking at it. Dmitry told me that ahash uses shash internally
> anyway so there is no change.
>
> BTW: Do you have some comment concerning the code?

No comments beyond the sync/async one.  I'm not very familiar with 
the crypto APIs or AMP key generation.


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
