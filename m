Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Apr 2012 16:33:53 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv6 05/26] Bluetooth: A2MP: Build and Send msg helpers
Message-ID: <20120411133351.GA22183@aemeltch-MOBL1>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120406224439.GE2915@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120406224439.GE2915@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Apr 06, 2012 at 07:44:39PM -0300, Gustavo Padovan wrote:
> > +static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
> > +		      void *data)
> > +{
> > +	struct a2mp_cmd *cmd;
> > +
> > +	cmd = __a2mp_build(code, ident, len, data);
> > +	if (!cmd)
> > +		return;
> > +
> > +	__a2mp_send(mgr, (u8 *)cmd, len + sizeof(*cmd));
> 
> Do you really need __a2mp_send(), are you going to use it somewhere else? If
> not just inline its code here.

Will do this way.

Best regards 
Andrei Emeltchenko 
