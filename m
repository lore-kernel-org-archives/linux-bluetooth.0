Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Jun 2011 13:47:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hendrik Sattler <post@hendrik-sattler.de>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 4/4] Add copy and move support for filesystem plugin
Message-ID: <20110617104655.GE28423@dell.ger.corp.intel.com>
References: <1308292007-2111-1-git-send-email-luiz.dentz@gmail.com>
 <1308292007-2111-4-git-send-email-luiz.dentz@gmail.com>
 <20110617122836.75292sf1oprtrhwk@mail.hendrik-sattler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110617122836.75292sf1oprtrhwk@mail.hendrik-sattler.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hendrik,

On Fri, Jun 17, 2011, Hendrik Sattler wrote:
> Additionally, the obex spec says that the copy/move actions also
> copies/moves directories recursively.

Where exactly do you see that? To my understanding Action isn't intended
for directories at all. E.g. in section 3.4.8.1 of IrOBEX 1.4 there's
just the following:

"The Name header specifies the source file name and the DestName header
specifies the destination file name. These two headers are mandatory for
this action."

I.e. it doesn't talk about directories at all.

Johan
