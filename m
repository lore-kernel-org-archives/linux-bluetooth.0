Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Nov 2010 19:25:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Attrib server should truncate attribute value to pdu
 length
Message-ID: <20101129172515.GB23846@jh-x301>
References: <1291034662-6138-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291034662-6138-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Mon, Nov 29, 2010, Sheldon Demario wrote:
> When the size of attribute value is greater than pdu size, it should be
> truncated to the pdu length - 2
> ---
>  attrib/att.c |   15 +++++++--------
>  1 files changed, 7 insertions(+), 8 deletions(-)

Pushed upstream. Thanks.

Johan
