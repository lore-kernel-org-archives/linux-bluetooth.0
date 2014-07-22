Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Jul 2014 11:55:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v1 0/1] doc/gatt-api: New API properties and methods for
 the GATT D-Bus API.
Message-ID: <20140722085507.GA29664@t440s.lan>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405986034-29122-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Mon, Jul 21, 2014, Arman Uguray wrote:
>     - Replaced the "Authentication", "Authorization", and "Encryption" errors
>       with a simpler "NotPaired" error, since there's not much the external
>       application can do on these errors other than try to pair. bluetoothd will
>       automatically attempt to raise the security level of the connection on
>       these errors.

"Insufficient Authorization" seems different from the other two in that
it's something that can't be attempted to be "fixed" from the client
side. It effectively means that our request was rejected by the remote
user, doesn't it?

Johan

