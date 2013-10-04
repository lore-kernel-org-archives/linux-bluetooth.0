Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Oct 2013 10:16:30 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 06/14] android: Create HAL API header skeleton
Message-ID: <20131004071628.GD2804@aemeltch-MOBL1>
References: <1380639799-25790-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1380639799-25790-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <4501039.OZxtA2WV21@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4501039.OZxtA2WV21@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

On Thu, Oct 03, 2013 at 04:07:08PM +0200, Szymon Janc wrote:
> > +
> > +/* Core Service */
> > +
> > +struct hal_msg_rsp {
> > +	struct hal_msg_hdr hdr;
> > +	uint8_t status;
> > +} __packed;
> 
> Non-error response to request has no status field, just header.

I have removed the structure in the following patches but I still have
doubts that this is a good approach.

So in a case of error we get:

struct error_rsp {
	struct hal_msg_hdr hdr;
	uint8_t status;
}

and in a case of success we get:

struct rsp {
        struct hal_msg_hdr hdr;
}

Does it make sense to omit status? We could read error_rsp and check
status for error while in the current design we have to check for size
received. Are we gonna save uint8_t?

Best regards 
Andrei Emeltchenko 

