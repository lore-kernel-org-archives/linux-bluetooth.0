Return-Path: <cyrus@holtmann.org>
From: Vikrampal <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com
Subject: BlueZ make error
Date: Tue, 03 Jun 2014 18:55:33 +0530
Message-id: <009101cf7f2f$5810a4f0$0831eed0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

While building the latest BlueZ, I'm getting below error:

krampal-ubuntu:~/bluez$ sudo make
make --no-print-directory all-am
  CC       client/main.o
client/main.c: In function 'cmd_version':
client/main.c:1098:28: error: 'VERSION' undeclared (first use in this
function)
  rl_printf("Version %s\n", VERSION);
                            ^
client/main.c:1098:28: note: each undeclared identifier is reported only
once for each function it appears in
client/main.c: In function 'main':
client/main.c:1489:18: error: 'VERSION' undeclared (first use in this
function)
   printf("%s\n", VERSION);
                  ^
make[1]: *** [client/main.o] Error 1
make: *** [all] Error 2

Please help me. Thanks!

Regards,
Vikram

