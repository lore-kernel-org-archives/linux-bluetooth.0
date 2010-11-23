Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Nov 2010 11:15:22 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Suraj Sumangala <suraj@Atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
Subject: Re: [PATCH] hciattach: download configuration at maximum baud rate
 possible
Message-ID: <20101123101522.GA32222@jh-x301>
References: <1290423480-29840-1-git-send-email-suraj@atheros.com>
 <20101123092346.GB28017@jh-x301>
 <4CEB9296.2060702@Atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CEB9296.2060702@Atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

On Tue, Nov 23, 2010, Suraj Sumangala wrote:
> The set_speed function is defined in hciattach.c as
> 
> int set_speed(...)
> {
> 	cfsetospeed(...);
> 	cfsetispeed(...);
> 	return tcsetattr(...);
> }
> 
> I think this function could end up returning Success even if the
> first two function calls failed?

Seems so, yes.

> Does it makes sense to rewrite it to
> 
> int set_speed(...)
> {
> 	if(cfsetospeed(...) < 0)
> 		return -errno;
> 	if(cfsetispeed(...) < 0)
> 		return -errno;

This looks fine, except for the coding style: space between if and (

> 	return tcsetattr(...);

I guess this should be a similar if statement as for the other two
calls, and then a final "return 0" at the end of the function. This
set_speed fix should be in a separate patch though.

Johan
