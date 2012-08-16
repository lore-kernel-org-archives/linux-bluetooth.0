Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Aug 2012 12:43:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 0/9] GObexApparam API
Message-ID: <20120816094305.GA3566@x220>
References: <1344508353-24647-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1344508353-24647-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Aug 09, 2012, Luiz Augusto von Dentz wrote:
> GObexApparam can encode/decode OBEX application parameter in a generic
> way, only the tags are expecific to each profile.
> 
> Some remarks:
> 
>   - Tag data is stored in network order/big endian because its type is
>     not known.
>   - Internally it uses a GHashTable to store the values which doesn't
>     guarantee the order of the tag will be exact the same as inserted.
> 
> Luiz Augusto von Dentz (9):
>   gobex: Introduce GObexApparam API
>   gobex: Add unit tests for GObexApparam API
>   gobex: Integrate GObexApparam with GObexHeader
>   gobex: Add unit test for encoding/decoding apparam headers
>   gobex: Add debug option to apparam
>   client: Port PBAP module to use GObexApparam
>   PBAP: Make use of GObexApparam API
>   MAP: Make use of GObexApparam API
>   core: Remove map_ap.c
> 
>  Makefile.am               |  18 +-
>  client/pbap.c             | 181 +++++-------------
>  gobex/gobex-apparam.c     | 355 +++++++++++++++++++++++++++++++++++
>  gobex/gobex-apparam.h     |  59 ++++++
>  gobex/gobex-debug.h       |   7 +-
>  gobex/gobex-header.c      |  25 +++
>  gobex/gobex-header.h      |   3 +
>  gobex/gobex.c             |  11 +-
>  plugins/mas.c             |  81 ++++----
>  plugins/pbap.c            | 180 ++++--------------
>  plugins/phonebook.h       |   2 +-
>  src/map_ap.c              | 466 ----------------------------------------------
>  src/map_ap.h              |  63 -------
>  unit/test-gobex-apparam.c | 422 +++++++++++++++++++++++++++++++++++++++++
>  unit/test-gobex-header.c  |  46 +++++
>  15 files changed, 1058 insertions(+), 861 deletions(-)
>  create mode 100644 gobex/gobex-apparam.c
>  create mode 100644 gobex/gobex-apparam.h
>  delete mode 100644 src/map_ap.c
>  create mode 100644 unit/test-gobex-apparam.c

All patches in this set have been applied. Thanks.

Johan
