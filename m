Return-Path: <cyrus@holtmann.org>
Subject: Re: BT_AMP_POLICY and RFCOMM
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Greg Hazel <ghazel@gmail.com>
In-Reply-To: <20120124085719.GB19238@aemeltch-MOBL1>
Date: Tue, 24 Jan 2012 01:57:11 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8B1F83F9-649A-4B59-A620-774A60E64D2C@gmail.com>
References: <D0339DC2-78B0-427D-9FC3-704725A88020@gmail.com> <20120124082739.GA19238@aemeltch-MOBL1> <E07C31FC-9B74-4DBA-98F5-765E95B256B7@gmail.com> <20120124085719.GB19238@aemeltch-MOBL1>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Jan 24, 2012, at 12:57 AM, Andrei Emeltchenko wrote:
> On Tue, Jan 24, 2012 at 12:36:23AM -0800, Greg Hazel wrote:
>> On Jan 24, 2012, at 12:27 AM, Andrei Emeltchenko wrote:
>>> On Mon, Jan 23, 2012 at 08:15:16PM -0800, Greg Hazel wrote:
>>>> Hi,
>>>> 
>>>> I'm trying to set BT_AMP_POLICY on an RFCOMM socket to
>>>> BT_AMP_POLICY_PREFER_AMP. In return I'm getting "Operation not supported
>>> 
>>> BTW: Why would you need to set this? Functionality is not supported yet so
>>> nothing will change.
>> 
>> Oh, I had not made it far enough into bluez to notice it had not been implemented. My question still stands I suppose, but is obviously predicated on support being added eventually.
>> 
>> Out of curiosity, is there a bluetooth stack which does support AMP yet?
> 
> Look at git://codeaurora.org/kernel/msm.git

Ah, it looks like android-msm (which I am using) tracks that to some extent. At least it contains this commit https://www.codeaurora.org/gitweb/quic/le/?p=kernel/msm.git;a=commit;h=5bf61204e8567df6be8583a258dba36343f87cb5 which seems to be an implementation, although I haven't tried it.

Is this the right mailing list to ask about the AMP bluetooth work contained in msm and android-msm?

-Greg

