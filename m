Return-Path: <SRS0+5d25a609d40da48894fc+478+infradead.org+hch@pentafluge.srs.infradead.org>
Date: Tue, 14 Dec 2004 09:45:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Adrian Bunk <bunk@stusta.de>, Max Krasnyansky <maxk@qualcomm.com>,
   bluez-devel@lists.sourceforge.net,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Network Development Mailing List <netdev@oss.sgi.com>
Subject: Re: [2.6 patch] net/bluetooth/: misc possible cleanups
Message-ID: <20041214094543.GA963@infradead.org>
References: <20041214041352.GZ23151@stusta.de> <1103009649.2143.65.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1103009649.2143.65.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, Dec 14, 2004 at 08:34:08AM +0100, Marcel Holtmann wrote:
> these functions must stay. They have users outside the mainline kernel
> that are not merged back yet. Otherwise they won't be exported ;)

But we traditionally don't keep APIs only for the sake of external modules.
Exceptions are made if you have short- to mid-term plans to merge them.
