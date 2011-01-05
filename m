Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Jan 2011 14:01:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add option to set leadv peripheral role for hciconfig
Message-ID: <20110105120148.GA18929@jh-x301>
References: <1294090797-20456-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294090797-20456-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Mon, Jan 03, 2011, Sheldon Demario wrote:
> --- a/lib/sdp.h
> +++ b/lib/sdp.h
> @@ -407,6 +407,15 @@ extern "C" {
>  #define SDP_INVALID_PDU_SIZE		0x0004
>  #define SDP_INVALID_CSTATE		0x0005
>  
> +/* EIR and Advertising flags descriptions (Vol 3/Part C/Appendix C) */
> +#define EIR_LIM_DISC                0x01 /* LE Limited Discoverable Mode */
> +#define EIR_GEN_DISC                0x02 /* LE General Discoverable Mode */
> +#define EIR_BREDR_UNSUP             0x04 /* BR/EDR Not Supported */
> +#define EIR_SIM_CONTROLLER          0x08 /* Simultaneous LE and BR/EDR to Same
> +					    Device Capable (Controller) */
> +#define EIR_SIM_HOST                0x10 /* Simultaneous LE and BR/EDR to Same
> +					    Device Capable (Host) */

Since these are not really SDP related I don't think sdp.h is the right
place for them. Probably hci.h would be better.

Johan
