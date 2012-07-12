Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Jul 2012 16:55:35 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org
Subject: Re: [RFCv0 16/19] Bluetooth: Add function to derive AMP key using
 hmac
In-Reply-To: <20120712143029.GA1141@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1207121637410.28444@mathewm-linux>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1340981212-21709-17-git-send-email-Andrei.Emeltchenko.news@gmail.com> <20120712143029.GA1141@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Andrei -

On Thu, 12 Jul 2012, Andrei Emeltchenko wrote:

> Hi Mat,
>
> On Fri, Jun 29, 2012 at 05:46:49PM +0300, Andrei Emeltchenko wrote:
>> From: Dmitry Kasatkin <dmitry.kasatkin@intel.com>
>>
>> hmac(sha256) will be used for AMP key generation.
>
> What do you think about this approach for key generation?

I think it makes a lot of sense to use the synchronous API for 
generating the key.  As long as it generates the right key, this code 
looks good to me.


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

