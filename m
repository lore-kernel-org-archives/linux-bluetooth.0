Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 27 Nov 2017 15:39:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: Re: [PATCH 1/3 v2] doc/mgmt-api: Add support for Get PHY information
 command
Message-ID: <20171127133930.GB24336@x1c.home>
References: <1511173617-25442-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1511173617-25442-2-git-send-email-jaganathx.kanakkassery@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1511173617-25442-2-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Mon, Nov 20, 2017, Jaganath Kanakkassery wrote:
> +Get PHY Information Command
> +==========================
> +
> +	Command Code:		0x0043
> +	Controller Index:	<controller id>
> +	Command Parameters:
> +	Return Parameters:	Supported_phys (1 Octet)
> +				Selected_phys (1 Octet)

Shouldn't the command have "Default" in its name, to be consistent with
your second patch? If it's not the default that this is returning, then
shouldn't there be a reference to which connection it applies to
(assuming this is intended to map to the HCI_LE_Set_PHY command)?

What about the PHY_options HCI parameter, where is that planned to be
specified?

Johan
