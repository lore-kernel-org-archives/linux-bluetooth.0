Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Apr 2013 10:38:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH BlueZ v0] doc: Fix optional properties not marked as such
Message-ID: <20130425073817.GA9094@x220>
References: <1366875235-12077-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366875235-12077-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Apr 25, 2013, Mikel Astiz wrote:
> Commit 826023de56896e83f35ae69a73d6a120a2f5b11e made some of the
> device's properties optional but the documentation was not updated
> accordingly. More specifically, the properties 'Name' and 'UUIDs' won't
> be present if the information is not available.
> ---
>  doc/device-api.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
