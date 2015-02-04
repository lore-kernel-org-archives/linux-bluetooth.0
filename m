Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [RFC] Bluetooth: Remove Read Local Supported Features from AMP controller
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1423041640-28763-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 4 Feb 2015 10:04:00 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <542FB12F-47F7-4BB8-96AD-9C798FBDFF43@holtmann.org>
References: <1423041640-28763-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1423041640-28763-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Commit f6996cfe2f1db60a74765449f9b53c7591bcdc87 added reading Local
> Supported Features which is causing errors for msm prima SoftAMP.
> 
> ...
> < HCI Command: Reset (0x03|0x0003) plen 0                       [hci1]
> 6.492798
>> HCI Event: Command Complete (0x0e) plen 4                     [hci1]
>> 6.501161
>      Reset (0x03|0x0003) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Read Local Version Infor.. (0x04|0x0001) plen 0  [hci1]
> 6.501832
>> HCI Event: Command Complete (0x0e) plen 12                    [hci1]
>> 6.516970
>      Read Local Version Information (0x04|0x0001) ncmd 1
>        Status: Success (0x00)
>        HCI version: Bluetooth 3.0 (0x05) - Revision 0 (0x0000)
>        PAL version: Bluetooth 3.0 (0x01) - Subversion 0 (0x0000)
>        Manufacturer: Qualcomm (29)
> < HCI Command: Read Local Supported Com.. (0x04|0x0002) plen 0  [hci1]
> 6.517092
>> HCI Event: Command Complete (0x0e) plen 68                    [hci1]
>> 6.525821
>      Read Local Supported Commands (0x04|0x0002) ncmd 1
>        Status: Success (0x00)
>        Commands: 34 entries
>          Reset (Octet 5 - Bit 7)
>          Flush (Octet 6 - Bit 1)
>          Read Connection Accept Timeout (Octet 7 - Bit 2)
>          Write Connection Accept Timeout (Octet 7 - Bit 3)
>          Read Link Supervision Timeout (Octet 11 - Bit 0)
>          Write Link Supervision Timeout (Octet 11 - Bit 1)
>          Read Local Version Information (Octet 14 - Bit 3)
>          Read Buffer Size (Octet 14 - Bit 7)
>          Read Failed Contact Counter (Octet 15 - Bit 2)
>          Reset Failed Contact Counter (Octet 15 - Bit 3)
>          Read Link Quality (Octet 15 - Bit 4)
>          Read RSSI (Octet 15 - Bit 5)
>          Enhanced Flush (Octet 19 - Bit 6)
>          Create Physical Link (Octet 21 - Bit 0)
>          Accept Physical Link (Octet 21 - Bit 1)
>          Disconnect Physical Link (Octet 21 - Bit 2)
>          Create Logical Link (Octet 21 - Bit 3)
>          Accept Logical Link (Octet 21 - Bit 4)
>          Disconnect Logical Link (Octet 21 - Bit 5)
>          Logical Link Cancel (Octet 21 - Bit 6)
>          Flow Specifcation Modify (Octet 21 - Bit 7)
>          Read Logical Link Accept Timeout (Octet 22 - Bit 0)
>          Write Logical Link Accept Timeout (Octet 22 - Bit 1)
>          Set Event Mask Page 2 (Octet 22 - Bit 2)
>          Read Location Data (Octet 22 - Bit 3)
>          Write Location Data (Octet 22 - Bit 4)
>          Read Local AMP Info (Octet 22 - Bit 5)
>          Read Local AMP ASSOC (Octet 22 - Bit 6)
>          Write Remote AMP ASSOC (Octet 22 - Bit 7)
>          Read Flow Control Mode (Octet 23 - Bit 0)
>          Write Flow Control Mode (Octet 23 - Bit 1)
>          Read Data Block Size (Octet 23 - Bit 2)
>          Read Best Effort Flush Timeout (Octet 24 - Bit 2)
>          Write Best Effort Flush Timeout (Octet 24 - Bit 3)
> < HCI Command: Read Local Supported Fea.. (0x04|0x0003) plen 0  [hci1]
> 6.525974
>> HCI Event: Command Status (0x0f) plen 4                       [hci1]
>> 6.542668
>      Read Local Supported Features (0x04|0x0003) ncmd 1
>        Status: Unknown HCI Command (0x01)
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
> net/bluetooth/hci_core.c | 3 ---
> 1 file changed, 3 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 3322d3f..e695be5 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -400,9 +400,6 @@ static void amp_init(struct hci_request *req)
> 	/* Read Local Supported Commands */
> 	hci_req_add(req, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
> 
> -	/* Read Local Supported Features */
> -	hci_req_add(req, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
> -
> 	/* Read Local AMP Info */
> 	hci_req_add(req, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);

can we turn this into a 2 stage init process for AMP controllers. So we do HCI Reset, HCI Read Local Version and HCI Read Local Supported Commands and then based on the supported commands we decide which other commands we issue during init sequence.

If we can read the features page, I really prefer that we actually read it. Even while for AMP controllers in most cases it will be zero. According to a Core spec it is a valid command.

Regards

Marcel

