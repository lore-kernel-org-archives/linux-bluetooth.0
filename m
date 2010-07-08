Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/3] Extended support for generating dictionary value
 of service UUIDs
From: Marcel Holtmann <marcel@holtmann.org>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	rshaffer@codeaurora.org
In-Reply-To: <1278540518-18620-4-git-send-email-ingas@codeaurora.org>
References: <1278540518-18620-1-git-send-email-ingas@codeaurora.org>
	 <1278540518-18620-4-git-send-email-ingas@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 14:23:11 -0300
Message-ID: <1278609791.10421.36.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

>  src/adapter.c  |  103 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  src/adapter.h  |    4 +-
>  src/dbus-hci.c |    7 ++--
>  src/sdpd.h     |    2 +
>  4 files changed, 107 insertions(+), 9 deletions(-)

as requested please split these properly into multiple patches.

> diff --git a/src/sdpd.h b/src/sdpd.h
> index 8fd8bbe..38677d3 100644
> --- a/src/sdpd.h
> +++ b/src/sdpd.h
> @@ -39,6 +39,8 @@
>  
>  #define EIR_UUID16_SOME             0x02  /* 16-bit UUID, more available */
>  #define EIR_UUID16_ALL              0x03  /* 16-bit UUID, all listed */
> +#define EIR_UUID32_SOME             0x04  /* 32-bit UUID, more available */
> +#define EIR_UUID32_ALL              0x05  /* 32-bit UUID, all listed */
>  #define EIR_UUID128_SOME            0x06  /* 128-bit UUID, more available */
>  #define EIR_UUID128_ALL             0x07  /* 128-bit UUID, all listed */
>  #define EIR_NAME_SHORT              0x08  /* shortened local name */

And this should go into the initial patch listing all of these.

Regards

Marcel


