Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Mar 2012 13:13:10 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	Szymon Janc <szymon.janc@tieto.com>,
	linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Subject: Re: [PATCH 2/2] Bluetooth: mgmt: Don't allow to set invalid value to
 DeviceID source
Message-ID: <20120316161310.GC22160@x220>
References: <1331910177-11513-1-git-send-email-szymon.janc@tieto.com>
 <1331910177-11513-2-git-send-email-szymon.janc@tieto.com>
 <20120316150615.GB19444@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120316150615.GB19444@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Mar 16, 2012, Gustavo Padovan wrote:
> * Szymon Janc <szymon.janc@tieto.com> [2012-03-16 16:02:57 +0100]:
> 
> > Reply with MGMT_STATUS_INVALID_PARAMS when userspace is trying to set
> > source with out-of-scope value.
> > 
> > Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> > ---
> >  net/bluetooth/mgmt.c |    9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> This one should go to bluetooth.git first.
> 
> Acked-by: Gustavo Padovan <gustavo@padovan.org>

I went ahead and applied both directly to my bluetooth-next tree. I
don't think this one is critical enough to deserve to go to
bluetooth.git.

Johan
