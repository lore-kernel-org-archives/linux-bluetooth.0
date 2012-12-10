Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Dec 2012 22:39:55 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2] build: Fix 'hcitool' and 'bdaddr' compilation
Message-ID: <20121210203955.GB15853@x220.P-661HNU-F1>
References: <1355171052-9218-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355171052-9218-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, Dec 10, 2012, Vinicius Costa Gomes wrote:
> Now with the addition of src/oui.c that depends on udev, these tools
> should also be linked against libudev, in case libudev includes the
> function udev_hwdb_new().
> 
> Build error:
>   CCLD     tools/hcitool
>   CCLD     tools/sdptool
>   CCLD     tools/ciptool
>   CCLD     tools/bccmd
> src/oui.o: In function `batocomp':
> /home/vinicius/work/bluez/src/oui.c:42: undefined reference to `udev_new'
> /home/vinicius/work/bluez/src/oui.c:46: undefined reference to `udev_hwdb_new'
> /home/vinicius/work/bluez/src/oui.c:50: undefined reference to `udev_hwdb_get_properties_list_entry'
> /home/vinicius/work/bluez/src/oui.c:53: undefined reference to `udev_list_entry_get_name'
> /home/vinicius/work/bluez/src/oui.c:52: undefined reference to `udev_list_entry_get_next'
> /home/vinicius/work/bluez/src/oui.c:61: undefined reference to `udev_hwdb_unref'
> /home/vinicius/work/bluez/src/oui.c:64: undefined reference to `udev_unref'
> /home/vinicius/work/bluez/src/oui.c:56: undefined reference to `udev_list_entry_get_value'
> collect2: error: ld returned 1 exit status
> make[1]: *** [tools/hcitool] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [all] Error 2
> ---
>  Makefile.tools | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
