Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170704150937.11701-1-luiz.dentz@gmail.com>
References: <20170704150937.11701-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 5 Jul 2017 14:34:57 +0300
Message-ID: <CABBYNZJ5ucr-V4VdV8z+SSPWWj24dDPRupEBU7tX-zMGBUx0bw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] gatt: Add AcquireWrite and AcquireNotify
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jul 4, 2017 at 6:09 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This set adds 2 new methods to GattCharacteristics1, thse deal with
> attributes that attempts to emulate a byte stream transfer, or a protocol
> on top of GATT, using write without response and notifications.
>
> v2:
> - Rename WriteLocked and NotifyLocked to WriteAcquired and NotifyAcquired
> - Make WriteAcquired and NotifyAcquired optional so they only appear if
> the required flags are supported.
> - Make sure O_CLOEXEC and O_NONBLOCK are set in the flags passed to pipe2.
>
> Luiz Augusto von Dentz (10):
>   doc/gatt-api: Add AcquireWrite and AcquireNotify
>   shared/gatt-client: Allow multiple ready callbacks
>   gatt: Add implementation of AcquireWrite
>   gatt: Add implementation of WriteAcquired
>   client: Add acquire-write command
>   client: Add release-write command
>   gatt: Add implementation of AcquireNotify
>   gatt: Add implementation of NotifyAcquired
>   client: Add acquire-notify command
>   client: Add release-notify command
>
>  Makefile.tools           |   4 +-
>  client/gatt.c            | 209 +++++++++++++++++++++++++++
>  client/gatt.h            |   6 +
>  client/main.c            |  48 +++++++
>  doc/gatt-api.txt         |  62 ++++++++
>  peripheral/gatt.c        |   4 +-
>  src/device.c             |  16 ++-
>  src/gatt-client.c        | 367 +++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/gatt-client.c |  60 ++++++--
>  src/shared/gatt-client.h |   4 +-
>  tools/btgatt-client.c    |   2 +-
>  unit/test-gatt.c         |   4 +-
>  12 files changed, 759 insertions(+), 27 deletions(-)
>
> --
> 2.9.4

Applied after adjusting documentation according to the review comments.


-- 
Luiz Augusto von Dentz
