Return-Path: <cyrus@holtmann.org>
Date: Fri, 26 Feb 2010 11:38:29 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Liang Bao <tim.bao@gmail.com>, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Allow disable park state in main.conf
Message-ID: <20100226143829.GA17869@jh-x301>
References: <6aeb672b1002260532v6e209d7dr8370003463334b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6aeb672b1002260532v6e209d7dr8370003463334b3@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Feb 26, 2010, Liang Bao wrote:
> Currently BlueZ is hard-coding the default link policy to include
> hold mode, role switch, sniff mode and park state. However, some
> device will have problem to maintain the connection or setup SCO
> if they are in park state. Making the park state configurable in
> main.conf improves flexibility so it can be disabled when needed.
> 
> Signed-off-by: Tim Bao <tim.bao@gmail.com>
> ---
>  src/main.c    |   13 +++++++++----
>  src/main.conf |    5 +++++
>  2 files changed, 14 insertions(+), 4 deletions(-)

In principle the patch looks ok to me, however we might want to discuss
a little bit about the naming of the parameter in the config file and
its possible values. E.g. would it make sense to be able to define the
link policy more flexibly than just toggling park mode on and off.
Marcel, do you have any thoughts on this?

Johan
