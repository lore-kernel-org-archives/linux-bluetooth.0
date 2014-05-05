Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 May 2014 10:50:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 01/11] attrib: Add simpler call for descriptors discovery
Message-ID: <20140505075035.GB24502@t440s.lan>
References: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Fri, May 02, 2014, Andrzej Kaczmarek wrote:
> This patch adds gatt_discover_desc() function which performs descriptor
> discovery in a manner similar to gatt_discover_char(), i.e. it does
> complete discovery procedure and returns list of descriptors found when
> finished. For 16-bit UUIDs in addition to string UUID, short UUID is
> provided.
> 
> It's also possible to specify single descriptor UUID to look for and
> discovery procedure is interrupted as soon as UUID is found. This way
> no more than one descriptor is returned which is useful when searching
> for common descriptors like CCC.
> ---
>  attrib/gatt.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  attrib/gatt.h |  10 ++++
>  2 files changed, 156 insertions(+)

All patches in this set have been applied. Thanks.

Johan
