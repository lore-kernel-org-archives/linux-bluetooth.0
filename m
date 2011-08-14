Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 bluetooth-next] Added ioctl flow specification
 command on HCI socket
From: Marcel Holtmann <marcel@holtmann.org>
To: ilia.kolominsky@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Ilia Kolomisnky <iliak@ti.com>
Date: Sun, 14 Aug 2011 14:17:13 -0700
In-Reply-To: <1313325793-27866-1-git-send-email-iliak@ti.com>
References: <1313325793-27866-1-git-send-email-iliak@ti.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1313356642.3373.170.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilia,

> While it is possible to send flow specification HCI command
> from the user space directly via the send api of HCI socket,
> a more specific approach is preferable over the opaque
> HCI command, since it will allow for centralized mangament of
> flow specifiaction requests for different l2cap flows over
> the same acl link in future. This feature was used successfully
> for solving the qos A2DP issue in piconet with concurent file
> transfer.
> 
> Signed-off-by: Ilia Kolomisnky <iliak@ti.com>
> ---
>  include/net/bluetooth/hci.h      |   38 ++++++++++++++++++----
>  include/net/bluetooth/hci_core.h |    3 ++
>  net/bluetooth/hci_conn.c         |    1 +
>  net/bluetooth/hci_core.c         |   63 ++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/hci_event.c        |   37 ++++++++++++++++++++++
>  net/bluetooth/hci_sock.c         |    2 +
>  6 files changed, 137 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index be30aab..f0f90d5 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -109,6 +109,8 @@ enum {
>  #define HCISETLINKMODE	_IOW('H', 226, int)
>  #define HCISETACLMTU	_IOW('H', 227, int)
>  #define HCISETSCOMTU	_IOW('H', 228, int)
> +#define HCISETFLOWSPEC _IOW('H', 229, int)
> +

I am not accepting any new addition of ioctl() at this moment. We are
moving towards a proper defined management API. And that is how this
should be addressed.

And these kind of ictol() that have to execute a HCI command and wait
for the result are not a good for being an ioctl() in the first place.

Regards

Marcel


