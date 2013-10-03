Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Oct 2013 09:56:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH bluez v2 1/2] plugin: handle ENOSYS as not-supported
Message-ID: <20131003065630.GA21419@x220.p-661hnu-f1>
References: <1380729451-2266-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380729451-2266-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Wed, Oct 02, 2013, David Herrmann wrote:
> Allow plugins to return -ENOSYS during registration and handle it as
> "not-supported" error. It makes the error messages slightly more useful in
> case kernel-support is missing for a particular subsystem.
> ---
>  src/plugin.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Both patches have been applied after a couple of minor tweaks: remove
one of the three logs in the bnep failure case (we don't need that many)
and restrict scope of the err variable in plugin.c.

Johan
