Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Sep 2010 10:58:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Store new local name before writing it to HCI
Message-ID: <20100903075817.GA1917@jh-x301>
References: <AANLkTi=KFGw_HQjUAb=s1Vf+tSW0BuFQWNwHrWBO7Wdq@mail.gmail.com>
 <AANLkTi=avFuiQjApV=Wm01KjVL4LmwJFQb6=iJostpGW@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTi=avFuiQjApV=Wm01KjVL4LmwJFQb6=iJostpGW@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Fri, Sep 03, 2010, Daniel Örstadius wrote:
> From: Daniel Orstadius <daniel.orstadius@nokia.com>
> Date: Mon, 30 Aug 2010 16:54:09 +0300
> Subject: [PATCH] Store new local name before writing it to adapter
> 
> Store new local name to the file system and emit property changed
> before actually writing the name to the adapter.
> 
> The reason for the patch is the scenario were an application sets
> the name and then immediately turns off the adapter. Previously the
> requested name change might not have been properly applied in that
> case. The new name was not written to storage until it had been
> read from the adapter and the adapter could have been turned off
> before the read command was completed.
> 
> Avoids writing the name twice by using a boolean variable in the
> btd_adapter struct. The name may be changed by using for example
> hciconfig and in that case the name needs to be updated to storage
> after reading.
> ---
>  src/adapter.c |   35 ++++++++++++++++++++++-------------
>  1 files changed, 22 insertions(+), 13 deletions(-)

Thanks for the patch. It's now in the upstream tree.

Johan
