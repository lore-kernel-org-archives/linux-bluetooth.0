Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Mar 2010 15:05:18 +0100
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: pacho@condmat1.ciencias.uniovi.es
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluez-hcidump-1.42 fails to build against bluez-4.61
Message-ID: <20100308150518.7f5b79a5@strolchi>
In-Reply-To: <1268056614.7822.4.camel@localhost.localdomain>
References: <1267998239.3712.11.camel@localhost.localdomain>
	<1268056614.7822.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 08 Mar 2010 14:56:54 +0100
Pacho Ramos <pacho@condmat1.ciencias.uniovi.es> wrote:

> We should then simply wait for bluez-4.62 and, then, no patches would be
> needed for bluez-hcidump, not? (or I have missed anything?)

Yes, I verified this already: after I had updated bluez to 4.62 in the
openSUSE buildservice, I could safely drop the two patches from the
bluez-hcidump package and it still builds fine.
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
