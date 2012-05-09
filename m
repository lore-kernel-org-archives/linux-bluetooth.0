Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 May 2012 20:41:34 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATC -v2 2/2] Bluetooth: Fix skb length calculation
Message-ID: <20120509234134.GC28375@joana>
References: <1336598836-28478-1-git-send-email-gustavo@padovan.org>
 <1336598836-28478-2-git-send-email-gustavo@padovan.org>
 <alpine.DEB.2.02.1205091627350.2090@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1205091627350.2090@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2012-05-09 16:28:53 -0700]:

> 
> On Wed, 9 May 2012, Gustavo Padovan wrote:
> 
> >When we add a fragment to a skb, len, data_len and truesize fields needs
> >to be updated.
> 
> truesize is not updated in this version of the patch.  Also, change
> "needs" to "need"

Thanks for the English fixes in both patches! I'll resend a v3 with those
fixes in.

	Gustavo
