Return-Path: <cyrus@holtmann.org>
Date: Fri, 31 Oct 2014 10:39:08 +0200
From: Johan Hedberg <johan.hedberg@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Cc: marcel@holtmann.org, gustavo@padovan.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: HCI H5 peer reset detection
Message-ID: <20141031083908.GB18888@t440s.P-661HNU-F1>
References: <1412780068-19449-1-git-send-email-loic.poulain@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412780068-19449-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

On Wed, Oct 08, 2014, Loic Poulain wrote:
> This patch resets the HCI H5 driver data/state to unitialized and
> reports an HCI hardware error event to notify the upper stack that
> HCI synchronization has been lost. H5 will be re-synchronized and
> upper stack should generate an HCI Reset command.

I couldn't find anywhere where we'd currently do this "upper stack"
behavior that you describe (there . Did you have some follow-up patches to
implement that?

Johan
