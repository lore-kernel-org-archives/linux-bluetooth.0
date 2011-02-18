Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Feb 2011 12:02:09 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org,
	David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Replace batostr() with ba2str() to avoid memleaks
Message-ID: <20110218150209.GB31689@jh-x301>
References: <1297983986-10131-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297983986-10131-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Fri, Feb 18, 2011, David Herrmann wrote:
> batostr() returns dynamically allocated strings. Replace it with
> ba2str() wherever possible to avoid heap allocations and fix
> memleaks.
> ---
>  compat/bnep.c |    5 +++--
>  test/hciemu.c |    4 +++-
>  2 files changed, 6 insertions(+), 3 deletions(-)

Thanks. The patch has been pushed upstream with a couple of minor coding
style corrections.

Johan
