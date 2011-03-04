Return-Path: <cyrus@holtmann.org>
Message-ID: <4D715062.1070508@codeaurora.org>
Date: Fri, 04 Mar 2011 12:49:38 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Andre Guedes <andre.guedes@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 0/6] LE advertising cache
References: <1299270913-8436-1-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1299270913-8436-1-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 11-03-04 12:35 PM, Andre Guedes wrote:
> During a LE connection establishment, the host should be able to infer the
> bdaddr type from a given bdaddr.
>
> To achieve that, during the LE scanning, the host stores the bdaddr and the
> bdaddr type gathered from advertising reports. The host keeps a list of
> advertising entry (bdaddr and bdaddr_type) for later lookup. This list will
> be called Advertising Cache.

My biggest problem with this is testing purposes.

While it is true that the bdaddr_type can be extracted from the LE Scan 
data, when you are at an event like UPF, there can be an awful lot of 
devices very close to you.

It would be nice to be able to explicitly specify both the bdaddr and 
bdaddr_type during these things.

But I agree that as a deployed device, caching from an LE scan makes the 
most sense.

Will this also work for (future) private addressing, where the address 
being connected to may not be the one initially seen in the scan?


>
> Since the penality to connect to an unreachable device is relatively high,
> we must keep only fresh advertising entries on the advertising cache. So,
> before each LE scanning the advertising cache is cleared. Also, after the LE
> scanning, a timer is set to clear the cache.
>
> Next steps include removing all advertising cache from userspace and
> implementing a mechanism to sync kernel and userspace advertising cache.
>
> Patches are rebased using Vinicius SMP patches, repo:
> git://git.infradead.org/users/vcgomes/linux-2.6.git for-next
>
> Anderson Briglia (1):
>    Bluetooth: Implement advertising report meta event
>
> Andre Guedes (5):
>    Bluetooth: LE advertising info caching
>    Bluetooth: Protect adv_entries with a RW semaphore
>    Bluetooth: Check advertising cache in hci_connect()
>    Bluetooth: Clear advertising cache before scanning
>    Bluetooth: Add a timer to clear the advertising cache
>
>   include/net/bluetooth/hci.h      |   20 ++++++++
>   include/net/bluetooth/hci_core.h |   16 +++++++
>   net/bluetooth/hci_conn.c         |   12 ++++-
>   net/bluetooth/hci_core.c         |   92 ++++++++++++++++++++++++++++++++++++++
>   net/bluetooth/hci_event.c        |   48 ++++++++++++++++++++
>   5 files changed, 185 insertions(+), 3 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
