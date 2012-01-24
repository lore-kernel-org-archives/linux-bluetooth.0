Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jan 2012 10:57:26 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Greg Hazel <ghazel@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: BT_AMP_POLICY and RFCOMM
Message-ID: <20120124085719.GB19238@aemeltch-MOBL1>
References: <D0339DC2-78B0-427D-9FC3-704725A88020@gmail.com>
 <20120124082739.GA19238@aemeltch-MOBL1>
 <E07C31FC-9B74-4DBA-98F5-765E95B256B7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E07C31FC-9B74-4DBA-98F5-765E95B256B7@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Greg,

On Tue, Jan 24, 2012 at 12:36:23AM -0800, Greg Hazel wrote:
> On Jan 24, 2012, at 12:27 AM, Andrei Emeltchenko wrote:
> 
> > On Mon, Jan 23, 2012 at 08:15:16PM -0800, Greg Hazel wrote:
> >> Hi,
> >> 
> >> I'm trying to set BT_AMP_POLICY on an RFCOMM socket to
> >> BT_AMP_POLICY_PREFER_AMP. In return I'm getting "Operation not supported
> > 
> > BTW: Why would you need to set this? Functionality is not supported yet so
> > nothing will change.
> 
> Oh, I had not made it far enough into bluez to notice it had not been implemented. My question still stands I suppose, but is obviously predicated on support being added eventually.
> 
> Out of curiosity, is there a bluetooth stack which does support AMP yet?

Look at git://codeaurora.org/kernel/msm.git

Best regards 
Andrei Emeltchenko 
