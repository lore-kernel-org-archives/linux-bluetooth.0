Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Mar 2012 20:05:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: james.steele@accenture.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/3] lib: Correct the HCI Testing OGF value
Message-ID: <20120328170506.GA14006@x220.P-661HNU-F1>
References: <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E11458@048-CH1MPN1-101.048d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E11458@048-CH1MPN1-101.048d.mgd.msft.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi James,

On Wed, Mar 28, 2012, james.steele@accenture.com wrote:
> This patch corrects the Testing OGF to match the value in the Bluetooth
> specification, bringing it in line with the other defined OGF values.
> ---
>  lib/hci.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Where did the git author name info disappear that you had in your
previous submissions? This needs to be part of the patches.

Furthermore, your patches do not actually apply:

error: patch failed: lib/hci.h:1428
error: lib/hci.h: patch does not apply
Patch failed at 0001 lib: Correct the HCI Testing OGF value

On closer inspection it looks like either your mail client or mail
server is converting tabs to spaces. Are you using git send-email?
(which is the preferred way to send patches). Please test sending to
yourself and applying with git am before resending to linux-bluetooth.

Johan
