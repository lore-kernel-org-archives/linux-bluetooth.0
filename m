Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Mar 2011 10:30:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH v6 2/6] Add support for Out of Band (OOB) association
 model in mgmtops
Message-ID: <20110325083057.GB30796@jh-x301>
References: <1300974459-24076-1-git-send-email-szymon.janc@tieto.com>
 <1300974459-24076-3-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300974459-24076-3-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Mar 24, 2011, Szymon Janc wrote:
> @@ -1132,6 +1185,10 @@ static void mgmt_cmd_status(int sk, uint16_t index, void *buf, size_t len)
>  	opcode = btohs(bt_get_unaligned(&ev->opcode));
>  
>  	DBG("status %u opcode %u (index %u)", ev->status, opcode, index);
> +
> +	if (opcode == MGMT_OP_READ_LOCAL_OOB_DATA)
> +		read_local_oob_data_failed(sk, index);
> +
>  }

Firstly, unnecessary empty line at the end of the function. Secondly,
since it's likely that we'll have to deal with cmd_status messages for
other commands as well I think it'd make sense to start a swtich
statement here (with just one case entry for now).

Johan
