Return-Path: <cyrus@holtmann.org>
Date: Sat, 6 Mar 2010 21:50:05 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluez-4.61 fails to build if configured with
 "--disable-gstreamer --disable-alsa --enable-test"
Message-ID: <20100307005005.GA15923@vigoh>
References: <1267899275.32038.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1267899275.32038.33.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pacho,

* Pacho Ramos <pacho@condmat1.ciencias.uniovi.es> [2010-03-06 19:14:35 +0100]:

> It fails with:
>   CC     test/ipctest.o
>   CC     audio/ipc.o
>   CCLD   test/ipctest
> gcc: sbc/.libs/libsbc.a: No such file or directory
> make[1]: *** [test/ipctest] Error 1
> make: *** [all] Error 2
> 
> 
> Also, other combinations (like --enable-services, --enable-audio...) can
> end up with errors like:
> libtool: link: x86_64-pc-linux-gnu-gcc -I/usr/include/dbus-1.0
> -I/usr/lib64/dbus-1.0/include -I/usr/include/glib-2.0
> -I/usr/lib64/glib-2.0/include -DBLUETOOTH_PLUGIN_BUILTIN
> -DPLUGINDIR=\"/usr/lib64/bluetooth/plugins\" -O2 -march=athlon64-sse3
> -mtune=athlon64-sse3 -pipe -D_FORTIFY_SOURCE=2 -fPIC -Wl,-O1 -pie -o
> test/ipctest test/ipctest.o audio/ipc.o  /usr/lib64/libglib-2.0.so
> sbc/.libs/libsbc.a
> test/ipctest.o: In function `set_conf':
> ipctest.c:(.text+0x1462): undefined reference to `sbc_reinit'
> ipctest.c:(.text+0x14af): undefined reference to `sbc_init'
> ipctest.c:(.text+0x161b): undefined reference to `sbc_get_codesize'
> collect2: ld returned 1 exit status
> make[1]: *** [test/ipctest] Error 1
> make: *** [all] Error 2

Vinicius has a patch to fix this. Let's wait he send the patch to the
mailing list.


> 
> Thanks a lot for your help


-- 
Gustavo F. Padovan
http://padovan.org

ProFUSION embedded systems - http://profusion.mobi
