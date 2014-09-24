Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Sep 2014 21:33:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/13] Compilation with musl C library
Message-ID: <20140924183320.GA22729@t440s.P-661HNU-F1>
References: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Sep 19, 2014, Szymon Janc wrote:
> This patchset constains set of rather trivial fixes for compiling BlueZ
> with musl C library. Musl is quite strict WRT to includes and standard
> compliance.
> 
> All patches except last 3 are missing includes fixes. Last 2 also remove
> glibc extensions.
> 
> BR
> Szymon Janc
> 
> 
> Szymon Janc (13):
>   sap: Fix compilation errors with musl
>   lib: Fix compilation error with musl
>   android/hal-audio: Fix compilation errors with musl
>   tools: Fix compilation errors  with musl
>   shared: Fix compilation errors  with musl
>   alert: Fix compilation error with musl
>   core: Fix compilation error with musl
>   obexd: Fix compilation error with musl
>   android/pan: Fix compilation error with musl
>   android/client: Fix compilation errors with musl
>   health: Use proper type for tid
>   emulator: Fix compilation error with musl
>   android/emulator: Fix compilation error with musl
> 
>  android/client/if-bt.c         | 2 ++
>  android/client/if-gatt.c       | 2 ++
>  android/client/if-hh.c         | 1 +
>  android/client/if-hl.c         | 1 +
>  android/client/if-pan.c        | 2 --
>  android/client/if-rc.c         | 1 +
>  android/client/if-sock.c       | 1 +
>  android/client/tabcompletion.c | 1 +
>  android/hal-audio-sbc.c        | 1 +
>  android/pan.c                  | 1 +
>  android/system-emulator.c      | 4 ++--
>  emulator/hfp.c                 | 1 +
>  emulator/le.c                  | 1 +
>  emulator/serial.c              | 3 ++-
>  lib/hci.c                      | 2 +-
>  obexd/plugins/filesystem.c     | 2 +-
>  profiles/alert/server.c        | 3 +++
>  profiles/health/hdp.c          | 2 +-
>  profiles/sap/sap-u8500.c       | 1 +
>  src/shared/hci.c               | 1 +
>  src/systemd.c                  | 1 +
>  tools/amptest.c                | 2 +-
>  tools/btattach.c               | 2 +-
>  tools/btsnoop.c                | 1 +
>  tools/ciptool.c                | 2 +-
>  tools/cltest.c                 | 2 +-
>  tools/hciattach.c              | 2 +-
>  tools/hciattach_qualcomm.c     | 2 +-
>  tools/hciattach_tialt.c        | 2 +-
>  tools/hcidump.c                | 2 +-
>  tools/l2ping.c                 | 2 +-
>  tools/l2test.c                 | 2 +-
>  tools/rfcomm.c                 | 2 +-
>  33 files changed, 38 insertions(+), 19 deletions(-)

I've applied patches 1-11 from this set. The last two require some more
discussion.

Johan
