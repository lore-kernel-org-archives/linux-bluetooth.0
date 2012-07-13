Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Jul 2012 10:11:31 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org
Subject: Re: [RFCv0 16/19] Bluetooth: Add function to derive AMP key using
 hmac
Message-ID: <20120713071124.GA2729@aemeltch-MOBL1>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1340981212-21709-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120712143029.GA1141@aemeltch-MOBL1>
 <alpine.DEB.2.02.1207121637410.28444@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1207121637410.28444@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Jul 12, 2012 at 04:55:35PM -0700, Mat Martineau wrote:
> 
> Andrei -
> 
> On Thu, 12 Jul 2012, Andrei Emeltchenko wrote:
> 
> >Hi Mat,
> >
> >On Fri, Jun 29, 2012 at 05:46:49PM +0300, Andrei Emeltchenko wrote:
> >>From: Dmitry Kasatkin <dmitry.kasatkin@intel.com>
> >>
> >>hmac(sha256) will be used for AMP key generation.
> >
> >What do you think about this approach for key generation?
> 
> I think it makes a lot of sense to use the synchronous API for
> generating the key.  As long as it generates the right key, this
> code looks good to me.

Thanks for looking at it. Dmitry told me that ahash uses shash internally
anyway so there is no change.

BTW: Do you have some comment concerning the code?

Best regards 
Andrei Emeltchenko 

