Return-Path: <gregkh@linuxfoundation.org>
Date: Thu, 7 Sep 2017 14:30:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>
Cc: robh@kernel.org, marcel@holtmann.org, sre@kernel.org,
	loic.poulain@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [RFC 1/3] serdev: Add ACPI support
Message-ID: <20170907123030.GA20922@kroah.com>
References: <1504786214-1866-1-git-send-email-frederic.danis.oss@gmail.com>
 <1504786214-1866-2-git-send-email-frederic.danis.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1504786214-1866-2-git-send-email-frederic.danis.oss@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Sep 07, 2017 at 02:10:12PM +0200, Frédéric Danis wrote:
> Signed-off-by: Frédéric Danis <frederic.danis.oss@gmail.com>
> ---
>  drivers/tty/serdev/core.c | 99 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 94 insertions(+), 5 deletions(-)

I can not take patches without any changelog text, and you should feel
bad about trying to get me to do so :)

thanks,

greg k-h
