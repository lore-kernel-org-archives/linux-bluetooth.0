Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Oct 2012 22:48:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 00/18] neard plugin
Message-ID: <20121003194851.GB32176@x220.P-661HNU-F1>
References: <1349270311-31103-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349270311-31103-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Oct 03, 2012, Szymon Janc wrote:
> Next round of neard plugin patches.
> 
> Changes since v3:
> - enable neard support with --enable-neard
> - use g_memdup instead of g_malloc+memcpy
> - introduce oob_handler functionality that allows to register cb to be called
>   when certain adapter actions are completed (dbusoob plugin adjusted)
> - remove static pointers from neard plugin, this data is now passed to/from
>   callback as user data
> - other small fixes
> 
> Comments are welcome.
> 
> Szymon Janc (18):
>   Handle missing randomizer in mgmt_add_remote_oob_data
>   eir: Add support for parsing SSP hash and randomizer
>   eir: Store class in struct eir_data as uint32_t
>   eir: Add eir_parse_oob function
>   eir: Add support creating EIR with hash and randomizer fields
>   eir: Add support for creating EIR with CoD field
>   eir: Rename eir_create to eir_create_oob
>   eir: Remove support for creating EIR with tx_power fields
>   eir: Return number of bytes written by eir_create_oob
>   eir: Remove struct uuid_info
>   eir: Add support for creating proper OOB EIR
>   adapter: Add btd_adapter_get_services function
>   adapter: Rename btd_adapter_get_class to btd_adapter_read_class
>   adapter: Add btd_adapter_get_class function
>   oob: Refactor oob callback handling and move it to adapter code
>   Add initial neard plugin implementation
>   neard: Implement PushOOB function
>   neard: Implement RequestOOB function
> 
>  Makefile.am         |    8 +-
>  acinclude.m4        |    6 +
>  bootstrap-configure |    1 +
>  plugins/dbusoob.c   |   69 ++-----
>  plugins/neard.c     |  546 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/adapter.c       |   67 ++++++-
>  src/adapter.h       |   25 ++-
>  src/eir.c           |  153 ++++++++++++---
>  src/eir.h           |   21 +-
>  src/event.c         |   11 +-
>  src/event.h         |    2 +-
>  src/mgmt.c          |   16 +-
>  src/oob.c           |   41 ----
>  src/oob.h           |   32 ---
>  14 files changed, 801 insertions(+), 197 deletions(-)
>  create mode 100644 plugins/neard.c
>  delete mode 100644 src/oob.c
>  delete mode 100644 src/oob.h

I didn't find any major issues so all patches in this set have now been
applied. Thanks.

Johan
