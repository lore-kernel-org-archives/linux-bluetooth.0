Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Jan 2014 21:23:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 00/12] Fixes detected by clang
Message-ID: <20140106192324.GA21263@x220.p-661hnu-f1>
References: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Jan 03, 2014, Anderson Lizardo wrote:
> The patches on this set (except for the last patch) fix issues detected while
> building BlueZ with clang. Note that these fixes were only compile tested (I
> did run "make check" but it obviously does not cover code touched by these
> patches). For strncat/sprintf/sscanf related patches, I did some tests with
> sample code to make sure the changes worked as expected.
> 
> The last patch is a fix that I think should be inoffensive (unless there is
> some clever hack going on there that I could not see.)
> 
> BTW, I've been experimenting with Travis CI for automatically running
> build/unit tests for commits made on my personal development tree:
> https://travis-ci.org/lizardo/bluez-devel. Enabling builds with clang (along
> with gcc) was a one-line change to the configuration file. I plan in near
> future to also run functional tests (right now it just runs "make check" and
> "make distcheck")
> 
> Best Regards,
> Anderson Lizardo
> 
> Anderson Lizardo (12):
>   tools: Fix strncat() usage in hciconfig/hcitool
>   avrcp: Remove unnecessary "if (...)"
>   health: Fix struct mcap_csp "csp_req" field type
>   attrib: Fix sprintf() format specification
>   core: Fix sscanf() format specification
>   tools: Fix unaligned memory access on smp-tester
>   tools: Fix possible uninitialized variable in obexctl
>   android/client: Fix incorrect usage of bt_state_t2str()
>   android/client: Remove duplicate "const" specifier
>   android/client: Use memcpy() for getting CMSG_DATA()
>   android/client: Fix uninitialized "sock_fd" variable
>   android/system-emulator: Remove useless "static" qualifier
> 
>  android/client/if-bt.c      |  2 +-
>  android/client/if-hh.c      | 16 ++++++++--------
>  android/client/if-pan.c     |  8 ++++----
>  android/client/if-sock.c    |  8 +++-----
>  android/system-emulator.c   |  3 +--
>  profiles/audio/avrcp.c      |  2 +-
>  profiles/health/mcap_sync.c |  2 +-
>  src/adapter.c               | 12 ++++++------
>  src/attrib-server.c         |  2 +-
>  tools/hciconfig.c           | 21 ++++++++++++++-------
>  tools/hcitool.c             | 23 +++++++++++++++--------
>  tools/obexctl.c             |  6 ++----
>  tools/smp-tester.c          | 16 +++++++++++-----
>  13 files changed, 68 insertions(+), 53 deletions(-)

All patches have been applied. Thanks.

Johan
