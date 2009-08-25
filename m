Return-Path: <cyrus@holtmann.org>
Subject: Re: After EXTRA_DIST commit man files are not following --prefix
From: Marcel Holtmann <marcel@holtmann.org>
To: "Ruslan N. Marchenko" <rufferson@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <a70b8cd30908250516r60256f48q7d363886af31004@mail.gmail.com>
References: <a70b8cd30908250516r60256f48q7d363886af31004@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 25 Aug 2009 07:44:16 -0700
Message-Id: <1251211456.2950.89.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ruslan,

> commit 8ddf2e8466abf785d7ffa3da44cf7ce8791c6297
> Author: Marcel Holtmann <marcel@holtmann.org>
> Date:   Mon Aug 24 14:56:11 2009 -0700
> 
>     All manual pages need a special EXTRA_DIST statement
> 
> man pages are not following --prefix
> I'm doing
> ./bootstrap-configure --prefix=/opt/bluez --disable-audio
> and then
> make install
> which results into
> ...
>  /usr/bin/install -c -m 644 'lib/hidp.h' '/opt/bluez/include/bluetooth/hidp.h'
> test -z "/usr/share/man/man1" || /bin/mkdir -p "/usr/share/man/man1"
>  /usr/bin/install -c -m 644 'rfcomm/rfcomm.1' '/usr/share/man/man1/rfcomm.1'
> /usr/bin/install: cannot create regular file
> `/usr/share/man/man1/rfcomm.1': Permission denied
>  /usr/bin/install -c -m 644 'tools/hcitool.1' '/usr/share/man/man1/hcitool.1'
> /usr/bin/install: cannot create regular file
> `/usr/share/man/man1/hcitool.1': Permission denied
>  /usr/bin/install -c -m 644 'tools/sdptool.1' '/usr/share/man/man1/sdptool.1'
> /usr/bin/install: cannot create regular file
> `/usr/share/man/man1/sdptool.1': Permission denied
>  /usr/bin/install -c -m 644 'tools/ciptool.1' '/usr/share/man/man1/ciptool.1'
> /usr/bin/install: cannot create regular file
> `/usr/share/man/man1/ciptool.1': Permission denied
>  /usr/bin/install -c -m 644 'test/rctest.1' '/usr/share/man/man1/rctest.1'
> /usr/bin/install: cannot create regular file
> `/usr/share/man/man1/rctest.1': Permission denied
>  /usr/bin/install -c -m 644 'test/hciemu.1' '/usr/share/man/man1/hciemu.1'
> /usr/bin/install: cannot create regular file
> `/usr/share/man/man1/hciemu.1': Permission denied
>  /usr/bin/install -c -m 644 'compat/hidd.1' '/usr/share/man/man1/hidd.1'
> /usr/bin/install: cannot create regular file
> `/usr/share/man/man1/hidd.1': Permission denied
>  /usr/bin/install -c -m 644 'compat/pand.1' '/usr/share/man/man1/pand.1'
> /usr/bin/install: cannot create regular file
> `/usr/share/man/man1/pand.1': Permission denied
>  /usr/bin/install -c -m 644 'compat/dund.1' '/usr/share/man/man1/dund.1'
> /usr/bin/install: cannot create regular file
> `/usr/share/man/man1/dund.1': Permission denied
> make[1]: *** [install-man1] Error 1
> make: *** [install-am] Error 2
> 
> I.e. i have specific directory in /opt/bluez and compiling bluez not
> from root. But man files are tending to be installed to system prefix.

just use ./configure --mandir. Why the prefix detection is broken is
unclear to me. Maybe the dist_man_MANS causes more problems actually.

Regards

Marcel


