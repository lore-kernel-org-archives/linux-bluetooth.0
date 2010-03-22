Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Mar 2010 13:11:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix error not being propagated properly
Message-ID: <20100322111120.GA5347@jh-x301>
References: <2d5a2c101003050503j4e9bf8a0hdd91c8af4a9bb5a4@mail.gmail.com>
 <2d5a2c101003050536q61f16c12xb67a985234b3619@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2d5a2c101003050536q61f16c12xb67a985234b3619@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Mar 05, 2010, Luiz Augusto von Dentz wrote:
> Now with the correct patch attached
> 
> From 5dd57c233aa881faeaa6bfca147abcdb9e04dc93 Mon Sep 17 00:00:00 2001
> From: Luiz Augusto Von Dentz <luiz.dentz-von@nokia.com>
> Date: Fri, 5 Mar 2010 15:01:59 +0200
> Subject: [PATCH 11/11] Fix error not being propagated properly
> 
> ---
>  audio/headset.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

The first patch had some issues so I pushed my own fixed up version of
it. However, this second patch from you is now pushed (unchanged)
upstream.

Johan
