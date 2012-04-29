Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Apr 2012 22:40:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix adaptername shutdown
Message-ID: <20120429194041.GA5851@x220.P-661HNU-F1>
References: <1335626216.14431.3.camel@sirocco.config>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335626216.14431.3.camel@sirocco.config>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Sat, Apr 28, 2012, Bastien Nocera wrote:
> An inotify watch descriptor isn't a file descriptor, so don't
> treat it as such and remove it properly.
> ---
>  plugins/adaptername.c |   13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan
