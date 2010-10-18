Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Oct 2010 12:22:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix linkage failure for bluetoothd
Message-ID: <20101018092231.GA17402@jh-x301>
References: <1287171971-32246-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287171971-32246-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Oct 15, 2010, Gustavo F. Padovan wrote:
> Adding -lrt fix the following errors in one of my systems:
> 
> health/mcap_sync.o: In function `initialize_caps':
> /root/bluez/health/mcap_sync.c:341: undefined reference to `clock_getres'
> /root/bluez/health/mcap_sync.c:350: undefined reference to `clock_gettime'
> /root/bluez/health/mcap_sync.c:358: undefined reference to `clock_gettime'
> /root/bluez/health/mcap_sync.c:363: undefined reference to `clock_gettime'
> health/mcap_sync.o: In function `reset_tmstamp':
> /root/bluez/health/mcap_sync.c:163: undefined reference to `clock_gettime'
> health/mcap_sync.o: In function `mcap_get_timestamp':
> /root/bluez/health/mcap_sync.c:309: undefined reference to `clock_gettime'
> health/mcap_sync.o:/root/bluez/health/mcap_sync.c:514: more undefined references to `clock_gettime' follow
> collect2: ld returned 1 exit status
> make[1]: *** [src/bluetoothd] Error 1
> make: *** [all] Error 2
> ---
>  Makefile.am |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
