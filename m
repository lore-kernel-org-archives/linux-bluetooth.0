Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 Jan 2009 13:30:06 -0800
From: Eric Rannaud <eric.rannaud@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: bluez: libtool error with current git
Message-ID: <20090123213005.GB6670@nc050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On current git c90eb5b, './boostrap-configure && make' fails on F10.

Linux nc050 2.6.27.9-159.fc10.x86_64 #1 SMP Tue Dec 16 14:47:52 EST 2008 x86_64 x86_64 x86_64 GNU/Linux

With:

/bin/sh ../libtool --tag=CC   --mode=link gcc -I../include -I/usr/include/dbus-1.0 -I/usr/lib64/dbus-1.0/include   -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I../gdbus  -Wall -O2 -D_FORTIFY_SOURCE=2 -Werror -Wextra -Wno-sign-compare -Wno-unused-parameter -Wno-missing-field-initializers -Wdeclaration-after-statement -Wmissing-declarations -Wredundant-decls -Wcast-align -D_FORTIFY_SOURCE=2 -fPIC -g -O0 -module -avoid-version -no-undefined -export-symbols-regex bluetooth_plugin_desc -pie -o hal.la -rpath /usr/lib/bluetooth/plugins hal.lo  
generating symbol list for `hal.la'
/usr/bin/nm -B  .libs/hal.o  |  | /bin/sed 's/.* //' | sort | uniq > .libs/hal.exp
../libtool: eval: line 4373: syntax error near unexpected token `|'
../libtool: eval: line 4373: `/usr/bin/nm -B  .libs/hal.o  |  | /bin/sed 's/.* //' | sort | uniq > .libs/hal.exp'
make[2]: *** [hal.la] Error 1
make[2]: Leaving directory `/home/e/dev/linux/bluez/plugins'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/e/dev/linux/bluez'
make: *** [all] Error 2


In ./libtool:

# Take the output of nm and produce a listing of raw symbols and C names.
global_symbol_pipe=""
...
# The commands to list exported symbols.
export_symbols_cmds="\$NM \$libobjs \$convenience | \$global_symbol_pipe | \$SED 's/.* //' | sort | uniq > \$export_symbols"


Forcing global_symbol_pipe="cat -" lets the build complete.

Thanks.
