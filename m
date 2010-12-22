Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Dec 2010 00:41:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 3/18] Move primary service storage to device.c
Message-ID: <20101222224134.GA10702@jh-x301>
References: <20101222115722.GC27483@jh-x301>
 <1293055273-21076-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293055273-21076-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Wed, Dec 22, 2010, Sheldon Demario wrote:
> Discover All Primary Services has beed moved to device.c in order
> to follow a similar approach of BR/EDR service records.
> ---
>  attrib/att.h      |    6 ++++++
>  attrib/client.c   |   41 -----------------------------------------
>  attrib/gattrib.c  |    1 +
>  src/device.c      |   44 +++++++++++++++++++++++++++++++++++++++++++-
>  src/glib-helper.c |   24 ++++++++++++++++--------
>  5 files changed, 66 insertions(+), 50 deletions(-)

Pushed upstream. Thanks.

Johan
