Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Jul 2012 11:10:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v12 13/13] audio: Add fast connectable to telephony
 interface
Message-ID: <20120717081021.GB368@x220>
References: <1342090438-20434-1-git-send-email-frederic.danis@linux.intel.com>
 <1342090438-20434-14-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1342090438-20434-14-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Thu, Jul 12, 2012, Frédéric Danis wrote:
> +# Telephony interface specific options (i.e. options which affect how the
> +# service interacts with remote devices)
> +[Telephony]
> +
> +# Set to true to enable agent to use of fast connectable mode (faster page
> +# scanning) when incoming call starts. Default settings should be restored
> +# after call is answered or rejected. Page scan interval is much shorter and
> +# page scan type changed to interlaced. Such allows faster connection
> +# initiated by a headset.
> +FastConnectable=false

I don't really see the point of making this configurable and add extra
code complexity because of it. There should be no reason why it couldn't
always be available to the telephony agent. So unless you have a really
good reason for keeping it could you please remove it.

Johan
