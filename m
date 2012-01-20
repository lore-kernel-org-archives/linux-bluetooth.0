Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Jan 2012 15:25:50 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>,
	linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Subject: Re: [PATCH 1/2] Bluetooth: Make l2cap_ertm_data_rcv static
Message-ID: <20120120132547.GA11112@aemeltch-MOBL1>
References: <1326796951-16377-1-git-send-email-szymon.janc@tieto.com>
 <20120117122250.GA18057@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120117122250.GA18057@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Jan 17, 2012 at 02:22:53PM +0200, Andrei Emeltchenko wrote:
> Hi Szymon,
> 
> On Tue, Jan 17, 2012 at 11:42:30AM +0100, Szymon Janc wrote:
> > It is not used outside of l2cap_core.c.
> 
> Actually I am going to use it outside of l2cap_core. I will send my
> patches implementing A2MP without using kernel sockets soon.

I reworked my code so that I do not call l2cap_ertm_data_rcv directly. So
the patches looks OK now though I would merge them together.

Best regards 
Andrei Emeltchenko 
