Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Feb 2012 15:29:58 +0100
From: Tino Keitel <tino.keitel@tikei.de>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	Milan Crha <mcrha@redhat.com>, ying.an.deng@intel.com,
	ulf.hofemeier@intel.com, ning.w.wang@intel.com,
	Rohan Garg <rohan16garg@gmail.com>
Subject: Re: bluez 4.97: build failure when used in C++ apps
Message-ID: <20120205142958.GA13091@x61.home>
References: <1326702341.3360.107.camel@pohly-mobl1.fritz.box>
 <1326705845.6454.274.camel@aeonflux>
 <1326708597.3360.133.camel@pohly-mobl1.fritz.box>
 <1328439363.32199.20.camel@pohly-mobl1.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328439363.32199.20.camel@pohly-mobl1.fritz.box>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Feb 05, 2012 at 11:56:03 +0100, Patrick Ohly wrote:

[...]

> How do we move forward with this? More and more distros are picking up
> the broken header file.
> 
> In MeeGo and Tizen we applied the patch that I had suggested.

FYI, Debian also applied a patch and syncevolution builds fine.

Regards,
Tino
