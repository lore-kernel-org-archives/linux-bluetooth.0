Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Sep 2012 13:02:24 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH hcidump] amp: Decode Num Completed Data Blocks
Message-ID: <20120925100222.GD2509@aemeltch-MOBL1>
References: <1346398640-8423-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346398640-8423-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Fri, Aug 31, 2012 at 10:37:20AM +0300, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Adds decoding Number Of Completed Data Blocks Event
> 
> > HCI Event: Number Of Completed Data Blocks (0x48) plen 9
>     Total num blocks 4 Num handles 1
>       Handle 0x0001: Num complt pkts 1 Num complt blks 1
> ---
>  lib/hci.h    |   10 ++++++++++
>  parser/hci.c |   22 ++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/lib/hci.h b/lib/hci.h
> index d068a2f..7eacca5 100644
> --- a/lib/hci.h
> +++ b/lib/hci.h
> @@ -2197,6 +2197,16 @@ typedef struct {
>  #define EVT_FLOW_SPEC_MODIFY_COMPLETE_SIZE 3
>  
>  #define EVT_NUMBER_COMPLETED_BLOCKS		0x48
> +typedef struct {
> +	uint16_t		handle;
> +	uint16_t		num_cmplt_pkts;
> +	uint16_t		num_cmplt_blks;
> +} __attribute__ ((packed)) cmplt_handle;
> +typedef struct {
> +	uint16_t		total_num_blocks;
> +	uint8_t			num_handles;
> +	cmplt_handle		handles[0];
> +}  __attribute__ ((packed)) evt_num_completed_blocks;
>  
>  #define EVT_AMP_STATUS_CHANGE			0x4D
>  typedef struct {
> diff --git a/parser/hci.c b/parser/hci.c
> index 38794bd..19cd419 100644
> --- a/parser/hci.c
> +++ b/parser/hci.c
> @@ -3743,6 +3743,25 @@ static inline void flow_spec_modify_dump(int level, struct frame *frm)
>  	}
>  }
>  
> +static inline void num_completed_blocks_dump(int level, struct frame *frm)
> +{
> +	evt_num_completed_blocks *evt = frm->ptr;
> +	int i;
> +
> +	p_indent(level, frm);
> +	printf("Total num blocks %d Num handles %d\n",
> +			btohs(evt->total_num_blocks), evt->num_handles);
> +
> +	for (i = 0; i < evt->num_handles; i++) {
> +		cmplt_handle *h = &evt->handles[i];
> +
> +		p_indent(level + 1, frm);
> +		printf("Handle 0x%4.4x: Num complt pkts %d Num complt blks %d\n",
> +				btohs(h->handle), btohs(h->num_cmplt_pkts),
> +				btohs(h->num_cmplt_blks));
> +	}
> +}
> +
>  static inline void event_dump(int level, struct frame *frm)
>  {
>  	hci_event_hdr *hdr = frm->ptr;
> @@ -3969,6 +3988,9 @@ static inline void event_dump(int level, struct frame *frm)
>  	case EVT_FLOW_SPEC_MODIFY_COMPLETE:
>  		flow_spec_modify_dump(level + 1, frm);
>  		break;
> +	case EVT_NUMBER_COMPLETED_BLOCKS:
> +		num_completed_blocks_dump(level + 1, frm);
> +		break;
>  	default:
>  		raw_dump(level, frm);
>  		break;
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
