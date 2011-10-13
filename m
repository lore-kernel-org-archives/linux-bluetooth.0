Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Oct 2011 15:54:58 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/11] Bluetooth: New mgmt messages for SMP Keys
Message-ID: <20111013185458.GB31083@samus.indt.org>
References: <1313798895-8705-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313798895-8705-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 21:08 Fri 19 Aug, Vinicius Costa Gomes wrote:
> Hi,
> 
> Using new messages for SMP keys allow for simpler code as it is always
> clear from context the kind of key that is necessary.

I guess it's time to bring some threads back from the dead. How about
starting with this one.

I think that the most controversial thing about this series are how the
new messages are organized (the union thing). Comments are very welcome
:-)

> 
> Along with this are some fixes for problems found while implementing the
> Proximity Profile.
> 
> --
> 
> Vinicius Costa Gomes (11):
>   Bluetooth: Use the LTK after receiving a LE Security Request
>   Revert "Bluetooth: Add support for communicating keys with userspace"
>   Bluetooth: Add structures for the new SMP messages
>   Bluetooth: Add support for cleaning the SMP key list
>   Bluetooth: Add handlers for the new mgmt messages
>   Bluetooth: Rename smp_key_size to enc_size
>   Bluetooth: Use the smp_keys list for accessing SMP keys
>   Bluetooth: Remove the link key if LE pairing fails
>   Bluetooth: Fix not setting a pending security level
>   Bluetooth: Fix setting the connection sec_level when encryption fails
>   Bluetooth: Remove support for other SMP keys than the LTK
> 
>  include/net/bluetooth/hci.h      |    1 +
>  include/net/bluetooth/hci_core.h |   39 ++++++---
>  include/net/bluetooth/mgmt.h     |   26 ++++++-
>  net/bluetooth/hci_core.c         |  103 ++++++++++++++++---------
>  net/bluetooth/hci_event.c        |   13 ++-
>  net/bluetooth/l2cap_core.c       |    6 +-
>  net/bluetooth/mgmt.c             |  159 +++++++++++++++++++++++++++-----------
>  net/bluetooth/smp.c              |   78 +++++++++++--------
>  8 files changed, 291 insertions(+), 134 deletions(-)
> 
> --
> 1.7.6
> 

Cheers,
-- 
Vinicius
