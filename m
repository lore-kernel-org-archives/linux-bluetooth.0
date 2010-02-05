Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Feb 2010 17:12:14 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Set OPUSH SDP record supported format list to 0xff
 (any object type).
Message-ID: <20100205011214.GA24142@jh-x301>
References: <1265224887-48653-1-git-send-email-npelly@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1265224887-48653-1-git-send-email-npelly@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

On Wed, Feb 03, 2010, Nick Pelly wrote:
> This fixed an issue with sending an image from OSX. OSX would show a warning
> that the bluez stack does not support this file type, but offer to send it
> anyway (which works). This change to advertise support for all object types
> will remove this warning.
> 
> The list of file types that can be advertised in the SDP record is very limited
> anyway. It is best to list that we support all file types here, and then filter
> at the OPP/OBEX connection instead.
> 
> For reference:
> 0x01 = vCard 2.1
> 0x02 = vCard 3.0
> 0x03 = vCal 1.0
> 0x04 = iCal 2.0
> 0x05 = vNote
> 0x06 = vMessage
> 0xFF = any type of object.
> ---
>  tools/sdptool.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)

This patch is now pushed upstream. Thanks.

Johan
