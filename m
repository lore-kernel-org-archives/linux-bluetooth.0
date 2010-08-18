Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Aug 2010 16:16:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Clear the off_requested flag
Message-ID: <20100818131655.GA6341@jh-x301>
References: <AANLkTimJAT2+gxQCOXwBmyF7a_9BU2FQW2uQn0KiLcgx@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTimJAT2+gxQCOXwBmyF7a_9BU2FQW2uQn0KiLcgx@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Wed, Aug 18, 2010, Daniel Örstadius wrote:
> From: Daniel Orstadius <daniel.orstadius@nokia.com>
> Date: Wed, 18 Aug 2010 15:46:11 +0300
> Subject: [PATCH] Clear the off_requested flag
> 
> Set the off_requested flag in struct btd_adapter to false when
> receiving confirmation that the adapter is off. The flag is used
> to indicate that the adapter is in the powering down state and
> should be cleared when it is actually down.
> ---
>  src/adapter.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Thanks. The patch is now upstream.

Johan
