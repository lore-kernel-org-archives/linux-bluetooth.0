Return-Path: <loic.poulain@intel.com>
Subject: Re: [bug report] Bluetooth: Fix memory leaking when hdev->send
 returns an error
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20170523053400.GA3371@elgon.mountain>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
 Laura Abbott <labbott@redhat.com>
From: Loic Poulain <loic.poulain@intel.com>
Message-ID: <805c2633-93b8-440e-9600-d886f3c52159@intel.com>
Date: Tue, 23 May 2017 11:27:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170523053400.GA3371@elgon.mountain>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,


On 23/05/2017 07:34, Dan Carpenter wrote:
> The ti_st_send_frame() frees skb on error.  I'm surprised this bug
> wasn't found by KAsan when we found acf91ec384dd ("Bluetooth: btwilink:
> Save the packet type before sending").

Maybe an unreachable condition in the current ti_st implementation.
But yes this needs to be fixed.

> I don't totally understand how skb is freed on the success path either.
> bfusb_send_frame(), dtl1_hci_send_frame() and btqcomsmd_send() have
> calls to kfree_skb() but I can't find the calls in bpa10x_send_frame()
> or the other ->send functions.

bpa10x_send_frame stores a skb reference when filling urb, skb is then freed
asynchronously in the bpa10x_tx_complete callback.
What are the other send functions ? bt skb is often enqueued and not 
released
in the send function itself.

Regards,
Loic
