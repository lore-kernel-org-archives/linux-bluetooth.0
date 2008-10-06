Return-Path: <cyrus@holtmann.org>
Message-ID: <48EA7ED9.9080801@pook.es>
Date: Mon, 06 Oct 2008 23:10:49 +0200
From: Stuart Pook <kernel6org@pook.es>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
 BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez/git + 2.6.27-rc8 + SCO headset -> SIGSEGV
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>	 <48E3B3BF.6070205@pook.es>	 <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>	 <48E752A7.70600@pook.es> <1223121068.11272.46.camel@violet.holtmann.net>	 <48E7FB1E.8000504@pook.es> <48B8929D-29F9-4352-9C81-E95FDBC09876@gmail.com>	 <48E91E6F.1030202@pook.es> <A34AC171-77C2-4377-A60C-60A2793A2297@gmail.com>	 <0ED1CF2A-40D0-4A82-BAED-21F90B6466ED@gmail.com> <48EA6D84.7020101@pook.es>	 <632D4195-1EFF-4191-98D9-4A0953223590@gmail.com> <48EA7B66.1050208@pook.es> <1223326990.11272.229.camel@violet.holtmann.net>
In-Reply-To: <1223326990.11272.229.camel@violet.holtmann.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

hi Marcel

>>> however could you try to get a backtrace with gdb as well since it seems 
>>> that valgrind either distorts or hides some errors.
>> I guess that I have forgotten how to use gdb because the backtrace
>> doesn't tell me much. Or perhaps I have to recompile with "-g".
> if you use ./bootstrap-configure it will automatically enable it. If not
> then give --enable-debug to configure. And make sure you do a make clean
> before that.

This what I did (from history)

    17  git clone git://git.kernel.org/pub/scm/bluetooth/bluez.git && cd bluez && ./bootstrap-configure && make
    18  ./bootstrap-configure && make

I ran the bootstrap-configure twice because I had to install gtk-doc.

:; grep ' -g' Makefile
CFLAGS = -Wall -O2 -D_FORTIFY_SOURCE=2 -fPIC -g -O0

I thus think that I did compile with -g and that I cannot get a stack trace
because someone has written all over the stack.

[I'm trying to remove btusb but I think that I'll need a reboot
:; lsmod | grep btusb
btusb                  12056  11465
bluetooth              49632  1 btusb
]

Stuart
