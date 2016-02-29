Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Rob Herring <robh@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Nishant Sarmukadam <nishants@marvell.com>,
	"wnhuang@chromium.com" <wnhuang@chromium.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Cathy Luo <cluo@marvell.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Xinming Hu <huxm@marvell.com>
Subject: RE: [PATCH v4 1/3] mwifiex: register platform specific driver
Date: Mon, 29 Feb 2016 14:04:44 +0000
Message-ID: <6e3955140c3d46e0ab3094432ae941ec@SC-EXCH04.marvell.com>
References: <1455614079-4263-1-git-send-email-akarwar@marvell.com>
 <20160218143803.GX9654@rob-hp-laptop>
In-Reply-To: <20160218143803.GX9654@rob-hp-laptop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rob,

> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Thursday, February 18, 2016 8:08 PM
> To: Amitkumar Karwar
> Cc: linux-bluetooth@vger.kernel.org; Nishant Sarmukadam;
> wnhuang@chromium.com; devicetree@vger.kernel.org; Cathy Luo; linux-
> kernel@vger.kernel.org; Xinming Hu
> Subject: Re: [PATCH v4 1/3] mwifiex: register platform specific driver
> 
> On Tue, Feb 16, 2016 at 01:14:37AM -0800, Amitkumar Karwar wrote:
> > From: Xinming Hu <huxm@marvell.com>
> >
> > Platform device and driver provides easy way to interact with
> > device-tree-enabled system.
> >
> > This patch registers platform driver and reorganise existing device
> > tree specific code. Corresponding device tree binding file is also
> > created.
> >
> > Signed-off-by: Xinming Hu <huxm@marvell.com>
> > Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> > ---
> > v3: Don't update adapter->dt_node if mwifiex_plt_dev is NULL
> > v4: Corrected the 'name' and 'compatible' property names.(Arnd
> Bergmann and Rob
> >     Herring)
> >     Patch description wraped in 72 columns(Rob Herring)
> >     Moved DT binding file to bindings/net/wireless/(Rob Herring)
> > ---

Thanks for reviewing mwifiex and btmrvl patch series.
We are working on a updated version which will address your review comments.

Regards,
Amitkumar
