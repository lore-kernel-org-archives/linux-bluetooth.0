Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v14 2/3] Bluetooth: Extract generic start and stop discovery
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1417642384-24850-2-git-send-email-jpawlowski@google.com>
Date: Thu, 4 Dec 2014 10:21:55 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3A12498E-8FAF-4E33-92EF-00DE2B73A9E4@holtmann.org>
References: <1417642384-24850-1-git-send-email-jpawlowski@google.com> <1417642384-24850-2-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> This commit extract generic_start_discovery and generic_stop_discovery
> in preparation for start and stop service discovery. The reason behind
> that is that both functions will share big part of code, and it would
> be much easier to maintain just one generic method.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> net/bluetooth/mgmt.c | 39 ++++++++++++++++++++-------------------
> 1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 77cf0ef..a035c0d 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3746,8 +3746,8 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
> 	queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable, timeout);
> }
> 
> -static int start_discovery(struct sock *sk, struct hci_dev *hdev,
> -			   void *data, u16 len)
> +static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
> +				   void *data, u16 len, u16 opcode)

so I have been looking at this for a while now and never got a good feeling about handling the command like this. Every time I look at the resulting code it is not easy to read and understand anymore. And we need to be able to do that in the future.

I spent some time with your patches and massaged them into something that I think is more in the direction on how we want to have this look from a code base point of view. Functional wise it is still the same.

For now I skipped the scan restart and the filtering since I am treating them as two independent areas of review actually. My re-work just focused on getting the command handling correct.

The result is the 6 patches that I just posted. When they originated from your work, I gave the author credit to you, but I did fix up some of your error handling mistakes along the way ;)

Regards

Marcel

