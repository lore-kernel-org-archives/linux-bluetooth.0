Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 May 2012 16:44:58 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/9] Fix indentation and tab misuse
Message-ID: <20120510234458.GA11800@x220.colubris.lan>
References: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Apr 27, 2012, Anderson Lizardo wrote:
> Hi,
> 
> These are minor style fixes found "semi-automatically" while reviewing code.
> 
> Best Regards,
> 
> Anderson Lizardo (9):
>   lib: Fix tab misuse
>   tools: Fix tab misuse
>   event: Fix tab misuse
>   device: Fix tab misuse
>   sap: Fix tab misuse
>   monitor: Fix tab misuse
>   deviceinfo: Fix indentation and tab misuse
>   audio: Fix tab misuse
>   hidd: Fix indentation
> 
>  audio/pcm_bluetooth.c   |    2 +-
>  compat/hidd.c           |    2 +-
>  deviceinfo/deviceinfo.c |    4 ++--
>  lib/hci.c               |    2 +-
>  lib/hci_lib.h           |    2 +-
>  monitor/packet.c        |    2 +-
>  sap/server.c            |    2 +-
>  src/device.c            |    2 +-
>  src/event.c             |    2 +-
>  src/event.h             |    2 +-
>  tools/hciattach_ath3k.c |    2 +-
>  tools/sdptool.c         |    2 +-
>  12 files changed, 13 insertions(+), 13 deletions(-)

All patches in this set have been applied. Thanks.

Johan
