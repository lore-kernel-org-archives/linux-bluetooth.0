Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Aug 2014 16:22:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 01/10] monitor: Fix segmentation fault with malformed
 packet
Message-ID: <20140811132233.GA27174@t440s>
References: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Aug 11, 2014, Andrei Emeltchenko wrote:
> Do not allow to read more then buffer size.
> This fixes segmentation fault reading capture from target (apparently
> end of the trace was broken).
> ---
>  monitor/btsnoop.c    | 7 +++++++
>  src/shared/btsnoop.c | 5 +++++
>  src/shared/btsnoop.h | 2 ++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/monitor/btsnoop.c b/monitor/btsnoop.c
> index fafeff8..ec19812 100644
> --- a/monitor/btsnoop.c
> +++ b/monitor/btsnoop.c
> @@ -304,6 +304,13 @@ int btsnoop_read_hci(struct timeval *tv, uint16_t *index, uint16_t *opcode,
>  	}
>  
>  	toread = be32toh(pkt.size);
> +	if (toread > MAX_PACKET_SIZE) {
> +		perror("Packet len suspicially big: %u", toread);
> +		close(btsnoop_fd);
> +		btsnoop_fd = -1;
> +		return -1;
> +	}
> +
>  	flags = be32toh(pkt.flags);
>  
>  	ts = be64toh(pkt.ts) - 0x00E03AB44A676000ll;
> diff --git a/src/shared/btsnoop.c b/src/shared/btsnoop.c
> index 17a872c..521be10 100644
> --- a/src/shared/btsnoop.c
> +++ b/src/shared/btsnoop.c
> @@ -415,6 +415,11 @@ bool btsnoop_read_hci(struct btsnoop *btsnoop, struct timeval *tv,
>  	}
>  
>  	toread = be32toh(pkt.size);
> +	if (toread > MAX_PACKET_SIZE) {
> +		btsnoop->aborted = true;
> +		return false;
> +	}
> +
>  	flags = be32toh(pkt.flags);
>  
>  	ts = be64toh(pkt.ts) - 0x00E03AB44A676000ll;

The above two chunks should probably be in separate patches. One for
shared/btsnoop and the other for btmon.

> diff --git a/src/shared/btsnoop.h b/src/shared/btsnoop.h
> index 2c55d02..9f73913 100644
> --- a/src/shared/btsnoop.h
> +++ b/src/shared/btsnoop.h
> @@ -44,6 +44,8 @@
>  #define BTSNOOP_OPCODE_SCO_TX_PKT	6
>  #define BTSNOOP_OPCODE_SCO_RX_PKT	7
>  
> +#define MAX_PACKET_SIZE (1486 + 4)

Where does this number come from? At least provide an explanation in the
form of a code comment so that the reader can determine that it is
correct. Also, you're violating the name space used by this header file.
Everything else in it is prefixed by btsnoop_* or BTSNOOP_*.

Johan
