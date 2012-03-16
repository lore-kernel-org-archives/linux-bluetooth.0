Return-Path: <cyrus@holtmann.org>
Message-ID: <1331914282.14217.158.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: mgmt: Don't allow to set invalid value
 to DeviceID source
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Date: Fri, 16 Mar 2012 09:11:22 -0700
In-Reply-To: <20120316150615.GB19444@joana>
References: <1331910177-11513-1-git-send-email-szymon.janc@tieto.com>
	 <1331910177-11513-2-git-send-email-szymon.janc@tieto.com>
	 <20120316150615.GB19444@joana>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

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

why? What would it be doing there?

This code is not even scheduled for 3.4 anymore.

Regards

Marcel


