Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Jul 2012 15:02:25 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 00/13] Rebased remaining HoG patches
Message-ID: <20120713140225.GA22363@x220>
References: <1341947825-14789-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1341947825-14789-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João Paulo,

On Tue, Jul 10, 2012, João Paulo Rechi Vita wrote:
> Rebasing against upstream after the input directory move.
> 
> Additionally there are two patches from Vinicius to improve re-connection time,
> only discovering characteristics when probing the HoG device.
> 
> Claudio Takahasi (4):
>   hog: Use real values for vendor and product IDs
>   hog: Add read Report Reference descriptor
>   hog: Add HID Information Characteristic read
>   hog: Use hardware country code
> 
> João Paulo Rechi Vita (6):
>   hog: HID I/O driver
>   hog: Prepend Report ID to the HID report
>   hog: Add support for uHID events
>   hog: Handle output reports
>   hog: Handle output events
>   hog: Handle feature reports
> 
> Paulo Alcantara (1):
>   hog: Handle HID devices operating in Boot Protocol Mode
> 
> Vinicius Costa Gomes (2):
>   hog: Fix re-discovering HoG characteristics when reconnecting
>   hog: Fix destroying the uhid device when disconnecting
> 
>  acinclude.m4                |    9 +-
>  configure.ac                |    2 +
>  profiles/input/hog_device.c |  416 +++++++++++++++++++++++++++++++++++++++----
>  profiles/input/main.c       |    2 +
>  profiles/input/manager.c    |    2 +
>  5 files changed, 393 insertions(+), 38 deletions(-)

All patches from this set are now upstream.

Johan
