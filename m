Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Feb 2013 10:29:22 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/4] Bluetooth: Use mode to create SCO connection
Message-ID: <20130201162922.GB24448@x220>
References: <1359561800-12870-1-git-send-email-frederic.dalleau@linux.intel.com>
 <1359561800-12870-3-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1359561800-12870-3-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Wed, Jan 30, 2013, Frédéric Dalleau wrote:
> +		switch (mode) {
> +		case 0:
> +			cp.max_latency    = __constant_cpu_to_le16(0xffff);
> +			cp.content_format = cpu_to_le16(hdev->voice_setting);
> +			cp.retrans_effort = 0xff;
> +			break;
> +		case 1:
> +			if (conn->pkt_type & ESCO_2EV3)
> +				cp.max_latency = __constant_cpu_to_le16(0x0008);
> +			else
> +				cp.max_latency = __constant_cpu_to_le16(0x000D);
> +			cp.content_format = __constant_cpu_to_le16(0x0003);
> +			cp.retrans_effort = 0x02;
> +			break;
> +		}

Why are you using 0 and 1 here instead of your nice defines?

Johan
