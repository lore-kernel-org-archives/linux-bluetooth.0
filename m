Return-Path: <cyrus@holtmann.org>
Date: Sun, 22 Feb 2009 21:59:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: current git segfaults, gdb backtraces included, pl;ease help
Message-ID: <20090222195906.GA22899@jh-x301>
References: <499FDB3E.3040202@powercraft.nl> <20090221215945.GA10295@jh-x301> <49A15C9C.6040907@powercraft.nl> <20090222151619.GA18302@jh-x301> <1235317521.3878.1123.camel@cookie.hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1235317521.3878.1123.camel@cookie.hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Sun, Feb 22, 2009, Bastien Nocera wrote:
> Make BT_IO_OPT_INVALID be 0 in the enum, and you can use the GCC
> sentinel feature. Otherwise, it would have to wait for:
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=28319

Thanks for the tip! However, there's still the problem that gcc seems to
want this parameter be of type char* and with gcc 4 gives the warning
"warning: missing sentinel in function call" because it is not. The
following page has some info about it:
http://www.linuxonly.nl/docs/2/0_Page_1.html

Johan
