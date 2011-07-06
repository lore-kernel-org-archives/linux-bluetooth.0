Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Jul 2011 17:04:05 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/8] Permanent storage of SMP keys
Message-ID: <20110706200405.GA10598@piper>
References: <1309547558-9617-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309547558-9617-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 16:12 Fri 01 Jul, Vinicius Costa Gomes wrote:
> This is the companion series for userspace to add support for
> storing SMP keys.
> 
> Notes:
>  - Only Long Term Keys (LTKs) are stored at the moment;
>  - A new file was created for storing LTKs;
> 
> Cheers,
> 
> Vinicius Costa Gomes (8):
>   Add stubs for storing SMP keys
>   Add support for storing SMP keys
>   Add support for creating the device from the SMP keys
>   Define macros for link key types
>   Fix using "magic" values for key types
>   Add support for getting the Encryption Key Size via btio
>   Add support for passing the CID to btiotest
>   Add support for btiotest to returning the key size

Please ignore this, a v2 should appear soon.

> 
>  btio/btio.c       |   21 +++++++++++++++
>  btio/btio.h       |    1 +
>  doc/mgmt-api.txt  |    2 +
>  lib/bluetooth.h   |    1 +
>  lib/hci.h         |   13 +++++++++
>  lib/mgmt.h        |    2 +
>  plugins/hciops.c  |   12 +++++---
>  plugins/mgmtops.c |   33 +++++++++++++++++------
>  src/adapter.c     |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  src/adapter.h     |    2 +
>  src/event.c       |   61 ++++++++++++++++++++++++++++++++++++++++---
>  src/event.h       |    2 +-
>  src/storage.c     |   28 ++++++++++++++++++++
>  src/storage.h     |    2 +
>  test/btiotest.c   |   24 +++++++++++++++--
>  15 files changed, 253 insertions(+), 25 deletions(-)
> 
> --
> 1.7.6
> 

Cheers,
-- 
Vinicius
