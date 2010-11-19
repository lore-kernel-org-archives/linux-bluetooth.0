Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Nov 2010 17:25:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Implement Characteristic Value Read using UUID in
 the gatttool
Message-ID: <20101119152554.GC28815@jh-x301>
References: <1290173697-20097-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290173697-20097-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Fri, Nov 19, 2010, Sheldon Demario wrote:
> Sub-procedure used to read a Characteristic Value when the client
> only knows the characteristic UUID and doesn't know the handle.
> More than one handle and attribute value pair can be returned,
> it is up to the user define the handles range based on the service
> handles range.
> 
> Usage example:
> $gatttool --char-read --uuid=2a00 -i hcix -b xx:xx:xx:xx:xx:xx
> ---
>  attrib/gatt.c     |   15 ++++++++++++---
>  attrib/gatt.h     |    4 ++++
>  attrib/gatttool.c |   39 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+), 3 deletions(-)

Pushed upstream. Thanks.

Johan
