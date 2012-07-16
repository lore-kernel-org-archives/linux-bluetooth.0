Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Jul 2012 13:55:34 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>,
	linux-bluetooth@vger.kernel.org, s.syam@samsung.com
Subject: Re: [PATCH v1 1/2] Bluetooth: Move l2cap_chan_hold/put to
 l2cap_core.c
Message-ID: <20120716105527.GC5868@aemeltch-MOBL1>
References: <1342183675-27612-1-git-send-email-jaganath.k@samsung.com>
 <20120716105256.GB5868@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120716105256.GB5868@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jul 16, 2012 at 01:52:58PM +0300, Andrei Emeltchenko wrote:
> Hi Jaganath,
> 
> On Fri, Jul 13, 2012 at 06:17:54PM +0530, Jaganath Kanakkassery wrote:
> > Refactor the code in order to use the l2cap_chan_destroy()
> > from l2cap_chan_put() under the refcnt protection.
> > 
> > Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> > Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> 
> Both patches looks OK to me.
> 
> Reviewed-by: Emeltchenko Andrei <andrei.emeltchenko@nokia.com>

sorry old ab :(

Reviewed-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com> 
