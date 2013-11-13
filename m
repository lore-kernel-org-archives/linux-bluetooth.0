Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Nov 2013 15:56:22 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv1 4/9] android/hal-sock: Initial listen handle
Message-ID: <20131113135620.GH21468@aemeltch-MOBL1>
References: <1384178627-25991-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1384178627-25991-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20131113121537.GA11291@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131113121537.GA11291@x220.p-661hnu-f1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Nov 13, 2013 at 02:15:37PM +0200, Johan Hedberg wrote:
> > +struct rfcomm_slot {
> > +	int fd;
> > +	int hal_fd;
> > +	int real_sock;
> > +	uint32_t channel;
> > +};
> 
> You should really have comments here for what each struct member is used
> for (you have this info in your cover letter but it should also be part
> of the code). Why do you keep hal_fd here? Shouldn't we close it on our
> side as soon as we've handed it over to the HAL?

Basically hal_fd is needed until it is passed to the Android framework.

Do you want it to be like this:

int hal_fd;
rfslot = create_rfslot(&hal_fd, int sock);

send(hal_fd);
close(hal_fd);

Best regards 
Andrei Emeltchenko 

