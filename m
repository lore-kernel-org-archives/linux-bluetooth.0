Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Feb 2010 08:39:24 -0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Handle unanswered AVDTP request on disconnect
Message-ID: <20100210103924.GA17473@jh-x301>
References: <eb7933e21002090851m4d3b41f9kfa2f578bb0e4f825@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <eb7933e21002090851m4d3b41f9kfa2f578bb0e4f825@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Tue, Feb 09, 2010, Daniel Örstadius wrote:
> From: Daniel Orstadius <daniel.orstadius@gmail.com>
> Date: Tue, 9 Feb 2010 18:23:50 +0200
> Subject: [PATCH] Handle unanswered AVDTP request on disconnect
> 
> If the connection is lost when there is an AVDTP request the
> remote has not replied to and which has not timed out, then at
> least in some cases the callback for the request is not called
> leading to no Error response being sent on the Audio API.
> 
> This patch checks if there is an outstanding request when the stream
> state goes to idle and in that case triggers the corresponding callback
> with an error.
> ---
>  audio/avdtp.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-

I applied the patch with a few minor cosmetic changes. Thanks.

Johan
