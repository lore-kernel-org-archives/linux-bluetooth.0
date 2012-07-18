Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jul 2012 15:02:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v13 03/14] audio: Simplify org.bluez.Headset
Message-ID: <20120718120230.GE15775@x220.ger.corp.intel.com>
References: <1342532440-730-1-git-send-email-frederic.danis@linux.intel.com>
 <1342532440-730-4-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1342532440-730-4-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Tue, Jul 17, 2012, Frédéric Danis wrote:
> +properties	string State [readonly]
>  
> +			Possible values: "disconnected", "connecting",
> +			"connected", "playing"
>  
> +		boolean Connected [readonly]
>  
> +			Indicates if there is an active connection to the
> +			AG service on the remote device.
>  
> +		boolean Playing  [readonly]
> +			Indicates if an audio connection to the headset
> +			is active.

I guess we don't really need the Connected and Playing properties
anymore since these are covered by the State property. Right?

Johan
