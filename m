Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Feb 2011 11:44:13 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/6] Move pcsuite drivers to its own plugin
Message-ID: <20110223144413.GA26355@jh-x301>
References: <1298454881-7941-1-git-send-email-luiz.dentz@gmail.com>
 <1298454881-7941-5-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298454881-7941-5-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Feb 23, 2011, Luiz Augusto von Dentz wrote:
> This make it easier to enable/disable this funcionality as a whole.
> ---
>  Makefile.am            |    6 +-
>  configure.ac           |    9 +-
>  plugins/ftp.c          |  165 ++------------------------
>  plugins/nokia-backup.c |  309 ------------------------------------------------
>  4 files changed, 16 insertions(+), 473 deletions(-)
>  delete mode 100644 plugins/nokia-backup.c

It seems like you've forgotten to do git add plugins/pcsuite.c?

Anyway, I went ahead and applied patches 1-4.

Johan
