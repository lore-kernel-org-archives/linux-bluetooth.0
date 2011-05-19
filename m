Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 May 2011 06:57:55 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix TRACKER_LIBS value in configure.ac
Message-ID: <20110519135755.GA5919@dell.Hilton.com>
References: <1305796207-13094-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305796207-13094-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Thu, May 19, 2011, Radoslaw Jablonski wrote:
> This fixes problem with building obexd introduced by commit
> 6134dcbbb5acfa1b567aebb798597e9f96cf47ce (Add support for tracker-0.10)
> ---
>  configure.ac |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks! The patch has been pushed upstream.

Johan
