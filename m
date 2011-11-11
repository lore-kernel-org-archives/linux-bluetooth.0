Return-Path: <cyrus@holtmann.org>
Message-ID: <4EBD5378.7080303@codeaurora.org>
Date: Fri, 11 Nov 2011 08:55:20 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/8] Bluetooth: Add a custom type for Short Term Keys
References: <1320973436-13399-1-git-send-email-vinicius.gomes@openbossa.org> <1320973436-13399-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1320973436-13399-3-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 11/10/2011 5:03 PM, Vinicius Costa Gomes wrote:
> These keys are just used to encrypt the link, during SMP phase 2, they should
> not be stored nor reused. We use the same list as the LTKs to temporarily store
> them, but as soon as they are used they are removed from the list.
>
> Signed-off-by: Vinicius Costa Gomes<vinicius.gomes@openbossa.org>
> ---
>   include/net/bluetooth/hci.h |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 139ce2a..069768c 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -260,6 +260,7 @@ enum {
>   #define HCI_LK_AUTH_COMBINATION		0x05
>   #define HCI_LK_CHANGED_COMBINATION	0x06
>   /* The spec doesn't define types for SMP keys */
> +#define HCI_LK_SMP_STK			0x80
>   #define HCI_LK_SMP_LTK			0x81
>   #define HCI_LK_SMP_IRK			0x82
>   #define HCI_LK_SMP_CSRK			0x83


At some point, we will also need to expand this list to include key 
types for both Initiator and Responder (or rather, keys Locally 
generated, and keys Remotely generated).  Although there are 3 base 
types of LE keys (4 if you count the STK), there are in fact 6 different 
keys for different situations (7 if you count STK).

LTKs might be considered an exception, since most devices will only ever 
be a Master or a Slave, and IRKs will often only need to be saved for 
remote privacy supporting peripherals, if the local side does not use 
privacy.

However, for the CSRKs, I suspect that we will need to strongly 
differentiate between Locally and Remotely generated signing keys.  If 
we have a server with a "Signed Write Cmd" Characteristic and the remote 
device has one too, we will need to sign the outbound Write Cmds with 
the key the remote side distributed to us, and they will use the key 
that we sent them, so we need to keep them separate.

And once you start down that path, you should at least consider the 
possibility of needing to distinguish between remote and local LTKs and 
IRKs as well.  STKs at least do not have that problem: them are jointly 
derived.

Should we add _LCL_ and _REM_ to the naming conventions, and expand the 
enumeration out to 0x86?

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
