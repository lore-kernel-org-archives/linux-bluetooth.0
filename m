Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Oct 2011 10:51:02 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Peter Krystad <pkrystad@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/4] Add parsing of L2CAP Fixed Channel list
Message-ID: <20111024075059.GC31896@aemeltch-MOBL1>
References: <1319239802-22457-1-git-send-email-pkrystad@codeaurora.org>
 <1319239802-22457-4-git-send-email-pkrystad@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319239802-22457-4-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Fri, Oct 21, 2011 at 04:30:01PM -0700, Peter Krystad wrote:
> Add DUMP_VERBOSE display of L2CAP Fixed Channel list.
> Example output:
> 
> 2011-10-21 12:01:50.423246 > ACL data: handle 39 flags 0x02 dlen 20
>     L2CAP(s): Info rsp: type 3 result 0
>       Fixed channel list
>         L2CAP
>         CONNLESS
>         A2MP

We can be more specific here since each channel is printed on new line

> ---
>  parser/l2cap.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/parser/l2cap.c b/parser/l2cap.c
> index 7915788..ce78d05 100644
> --- a/parser/l2cap.c
> +++ b/parser/l2cap.c
> @@ -811,6 +811,7 @@ static void info_opt(int level, int type, void *ptr, int len)
>  {
>  	uint32_t mask;
>  	int i;
> +	uint8_t list;
>  
>  	p_indent(level, 0);
>  
> @@ -830,6 +831,21 @@ static void info_opt(int level, int type, void *ptr, int len)
>  		break;
>  	case 0x0003:
>  		printf("Fixed channel list\n");
> +		list = get_val(ptr, 1);

We had discussion about this with Mat Martineau and agreed that we read 8
octets (there is one bit in 8th octet - AMP test manager)

> +		if (parser.flags & DUMP_VERBOSE) {
> +			if (list & L2CAP_FC_L2CAP) {
> +				p_indent(level + 1, 0);
> +				printf("L2CAP\n");
> +			}
> +			if (list & L2CAP_FC_CONNLESS) {
> +				p_indent(level + 1, 0);
> +				printf("CONNLESS\n");
> +			}
> +			if (list & L2CAP_FC_A2MP) {
> +				p_indent(level + 1, 0);
> +				printf("A2MP\n");
> +			}
> +		}

I know that this is common in hcidump but I do not like current approach.
I have sent similar patch and the difference (beyond mentioned above) is
that I define decode table:

+static struct features l2cap_fix_chan[] = {
+	{ "L2CAP Signalling Channel",		L2CAP_FC_L2CAP		},
+	{ "L2CAP Connless",			L2CAP_FC_CONNLESS	},
+	{ "AMP Manager Protocol",		L2CAP_FC_A2MP		},
+	{ 0 }
+};

then:

+		if (parser.flags & DUMP_VERBOSE)
+			for (i=0; l2cap_fix_chan[i].name; i++)
+				if (fc_mask & l2cap_fix_chan[i].flag) {
+					p_indent(level + 1, 0);
+					printf("%s\n", l2cap_fix_chan[i].name);
+				}

http://www.spinics.net/lists/linux-bluetooth/msg17247.html

This is the way how it is done is wireshark network packet analyzer.

Then if you want to add one extra feature (like AMP test manager) => you
just add new table entry. Otherwise you have to create new "if" branch.

Best regards 
Andrei Emeltchenko 
