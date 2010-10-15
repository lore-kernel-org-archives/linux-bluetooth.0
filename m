Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Oct 2010 14:10:17 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Type conversion in read and write obex streams
Message-ID: <20101015111017.GA13046@jh-x301>
References: <1287138458-10780-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1287138458-10780-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Fri, Oct 15, 2010, Dmitriy Paliy wrote:
> Integer types in obex_write_stream and obex_read_stream shell be the
> same as those returned by read and write function prototypes of
> obex_mime_type_driver.
> ---
>  src/obex.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Not good:

src/obex.c: In function ‘obex_write_stream’:
src/obex.c:647: error: format ‘%d’ expects type ‘int’, but argument 3 has type ‘ssize_t’

Always compile-check your patches with ./bootstrap-configure.

The correct format specifier for ssize_t is %zd

Johan
