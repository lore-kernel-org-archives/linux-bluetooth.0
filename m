Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez: libtool error with current git
From: Marcel Holtmann <marcel@holtmann.org>
To: Eric Rannaud <eric.rannaud@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090123213005.GB6670@nc050>
References: <20090123213005.GB6670@nc050>
Content-Type: text/plain
Date: Wed, 28 Jan 2009 06:47:57 +0100
Message-Id: <1233121677.18259.10.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eric,

> On current git c90eb5b, './boostrap-configure && make' fails on F10.
> 
> Linux nc050 2.6.27.9-159.fc10.x86_64 #1 SMP Tue Dec 16 14:47:52 EST 2008 x86_64 x86_64 x86_64 GNU/Linux
> 
> With:
> 
> /bin/sh ../libtool --tag=CC   --mode=link gcc -I../include -I/usr/include/dbus-1.0 -I/usr/lib64/dbus-1.0/include   -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I../gdbus  -Wall -O2 -D_FORTIFY_SOURCE=2 -Werror -Wextra -Wno-sign-compare -Wno-unused-parameter -Wno-missing-field-initializers -Wdeclaration-after-statement -Wmissing-declarations -Wredundant-decls -Wcast-align -D_FORTIFY_SOURCE=2 -fPIC -g -O0 -module -avoid-version -no-undefined -export-symbols-regex bluetooth_plugin_desc -pie -o hal.la -rpath /usr/lib/bluetooth/plugins hal.lo  
> generating symbol list for `hal.la'
> /usr/bin/nm -B  .libs/hal.o  |  | /bin/sed 's/.* //' | sort | uniq > .libs/hal.exp
> ../libtool: eval: line 4373: syntax error near unexpected token `|'
> ../libtool: eval: line 4373: `/usr/bin/nm -B  .libs/hal.o  |  | /bin/sed 's/.* //' | sort | uniq > .libs/hal.exp'
> make[2]: *** [hal.la] Error 1
> make[2]: Leaving directory `/home/e/dev/linux/bluez/plugins'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/e/dev/linux/bluez'
> make: *** [all] Error 2
> 
> 
> In ./libtool:
> 
> # Take the output of nm and produce a listing of raw symbols and C names.
> global_symbol_pipe=""
> ...
> # The commands to list exported symbols.
> export_symbols_cmds="\$NM \$libobjs \$convenience | \$global_symbol_pipe | \$SED 's/.* //' | sort | uniq > \$export_symbols"
> 
> 
> Forcing global_symbol_pipe="cat -" lets the build complete.

I have seen these when enabling maintainer-mode, but I have no idea why
it happens or how to fix it. It also only happens on Fedora and not with
Ubuntu.

Regards

Marcel


