Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Nov 2012 20:24:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/1] gdbus: Fix compilation error due to missing
 #defines
Message-ID: <20121114182454.GA23087@x220.P-661HNU-F1>
References: <1352898430-3383-1-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1352898430-3383-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Wed, Nov 14, 2012, Syam Sidhardhan wrote:
> Since these are simple #define strings, we are defining it here
> instead of upgrading to D-Bus 1.5 or later.
> 
> Log:
>   CC     gdbus/object.o
> gdbus/object.c: In function ‘properties_set’:
> gdbus/object.c:876:7: error: ‘DBUS_ERROR_UNKNOWN_PROPERTY’ undeclared
>  (first use in this function)
> gdbus/object.c:876:7: note: each undeclared identifier is reported
>  only once for each function it appears in
> gdbus/object.c:881:6: error: ‘DBUS_ERROR_PROPERTY_READ_ONLY’
>  undeclared (first use in this function)
> make[1]: *** [gdbus/object.o] Error 1
> make: *** [all] Error 2
> ---
>  gdbus/object.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
