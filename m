Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 Apr 2011 10:28:02 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fixing characteristic read by uuid
Message-ID: <20110409172802.GB26311@jh-x301>
References: <1302028684-5267-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302028684-5267-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Tue, Apr 05, 2011, Sheldon Demario wrote:
> When the charecteristic to be read was the last one of a given range,
> it was not being listed.
> ---
>  src/attrib-server.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

This one has also been pushed. Thanks.

Johan
