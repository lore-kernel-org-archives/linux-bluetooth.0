Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Mar 2012 12:20:06 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Detect Wii Remotes by device name
Message-ID: <20120316152006.GB20650@x220>
References: <1329942591-2485-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329942591-2485-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Wed, Feb 22, 2012, David Herrmann wrote:
> We currently detect Wii Remotes by DID information. However, not all
> Wii Remotes (especially 3rd party Wii Remotes) provide DID
> information. Moreover, they provide no way of identifying them aside
> from their device name. Hence, this adds an experimental
> name-detection for Wii Remotes.
> ---
>  plugins/wiimote.c |   13 ++++++++-----
>  1 files changed, 8 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan
