Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Jul 2014 17:08:09 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hal-health: Clear NONBLOCK flag from fd
Message-ID: <20140703140807.GG7283@aemeltch-MOBL1>
References: <1404383493-8174-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <700D9D34-C873-4A39-858C-68265704A8EB@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <700D9D34-C873-4A39-858C-68265704A8EB@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jul 03, 2014 at 12:38:29PM +0200, Marcel Holtmann wrote:
> > +
> > +	fcntl(fd, F_SETFL, flags & ~O_NONBLOCK);
> > +
> 
> Same here. Might check the return error and print an error if it fails.
> At least then someone can debug it.

I have some other patch hanging in my tree checking return from ioctl()
for avctp. I will send it in a moment.

Best regards 
Andrei Emeltchenko 
