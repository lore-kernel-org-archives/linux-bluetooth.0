Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Jul 2013 16:13:23 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC BlueZ v3 3/8] Bluetooth: Use defines instead of integer
 literals
Message-ID: <20130709151323.GA1772@joana>
References: <1372409794-24688-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1372409794-24688-4-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372409794-24688-4-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

* Mikel Astiz <mikel.astiz.oss@gmail.com> [2013-06-28 10:56:29 +0200]:

> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> Replace the occurrences of integer literals in hci_event.c with the
> newly introduced macros in hci.h.
> 
> Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
> ---
>  net/bluetooth/hci_event.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Patches 1 to 3 have been applied to bluetooth-next since they aren't harmful.
The other will have to wait, as Johan said. Thanks.

	Gustavo
