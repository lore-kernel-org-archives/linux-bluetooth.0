Return-Path: <cyrus@holtmann.org>
Message-ID: <53BFB51F.5010608@gmail.com>
Date: Fri, 11 Jul 2014 15:27:51 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
To: Alexander Aring <alex.aring@gmail.com>, netdev@vger.kernel.org
CC: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 linux-zigbee-devel@lists.sourceforge.net
Subject: Re: [Linux-zigbee-devel] [PATCH net-next 0/2] Introduce generic 6LoWPAN
 branch
References: <1405067059-18782-1-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1405067059-18782-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/11/2014 01:54 PM, Alexander Aring wrote:
> Hi,
>
> this patch series add a new branch "net/6lowpan" for generic 6LoWPAN code.
>
> Since commit 8df8c56a5abc70af5862aa7cac2875aeeb17a42b ("6lowpan: Moving
> generic compression code into 6lowpan_iphc.c") the IPHC compression is shared
> between bluetooth 6LoWPAN and IEEE 802.15.4 6LoWPAN. The new 6LoWPAN directory
> will contain generic code for 6LoWPAN and futhermore 6LoWPAN upper layer
> protocols.
>
> The shared code between bluetooth and 802.15.4 should be review from both
> communities. The current behaviour is that get_maintainers.pl returns the
> IEEE 802.15.4 community only.
>
>
> I request a new mailinglist for the IEEE 802.15.4 subsystem at vger but I didn't
> get a response now so I add the current sourceforge IEEE 802.15.4 mailinglist to
> the MAINTAINERS file. I will update them soon.
>
> - Alex
>
> Alexander Aring (2):
>    6lowpan: introduce new net/6lowpan directory
>    MAINTAINERS: add net/6lowpan/ maintainer entry
>
>   MAINTAINERS                                       | 7 +++++++
>   net/6lowpan/Kconfig                               | 6 ++++++
>   net/6lowpan/Makefile                              | 3 +++
>   net/{ieee802154/6lowpan_iphc.c => 6lowpan/iphc.c} | 0
>   net/Kconfig                                       | 1 +
>   net/Makefile                                      | 3 ++-
>   net/bluetooth/Kconfig                             | 3 +--
>   net/ieee802154/Kconfig                            | 9 +--------
>   net/ieee802154/Makefile                           | 5 ++---
>   9 files changed, 23 insertions(+), 14 deletions(-)
>   create mode 100644 net/6lowpan/Kconfig
>   create mode 100644 net/6lowpan/Makefile
>   rename net/{ieee802154/6lowpan_iphc.c => 6lowpan/iphc.c} (100%)
>
Tested-by: Varka Bhadram <varkab@cdac.in>

-- 
Regards,
Varka Bhadram.
