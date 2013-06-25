Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: Re: regression in sdp lib
Date: Tue, 25 Jun 2013 21:54:29 +0200
Message-ID: <1429697.uq0A3eL4HE@athlon>
In-Reply-To: <20130625184848.GA29741@x220.P-661HNU-F1>
References: <1560638.biMD7yTzvv@athlon> <20130625184848.GA29741@x220.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tuesday 25 June 2013 21:48:48 Johan Hedberg wrote:
> Hi Szymon,
> 
> On Fri, Jun 21, 2013, Szymon Janc wrote:
> > commit 'lib: Add range check for SDP_SVC_ATTR_RSP/SDP_SVC_SEARCH_ATTR_RSP'
> > 1796f00e846561af broke sdp with Nokia BH217 headset.
> 
> Since there evidently wasn't any progress on this issue and we want to
> get a new release out (due to also another severe regression) I've gone
> ahead and simply reverted the original patch. Nevertheless, I'm still
> looking forward to seeing a proper fix for this issue.

Maybe it would be enough to verify size only if there is no continuation?

                /* Valid range for rsp_count is 0x0002-0xFFFF */
-               if (rsp_count < 0x0002) {
+               if (t->rsp_concat_buf.data_size == 0 && rsp_count < 0x0002) {
                        t->err = EPROTO;


Seems to be working for me but I'm that much familiar sdp code..

-- 
Szymon K. Janc
szymon.janc@gmail.com
