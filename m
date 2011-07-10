Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 10 Jul 2011 16:10:22 +0200
Message-ID: <CAAbSJMWHNbSV9r7Cw3+3NHoZMzWth3h1_GWrxDf9ANGA=cLnfQ@mail.gmail.com>
Subject: Compile failure
From: Mickael Chazaux <mickael.chazaux@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

git://git.kernel.org/pub/scm/bluetooth/bluez.git, branch master,
commit c34e7956441 fails to build :

  CC     tools/lexer.o
cc1: warnings being treated as errors
tools/lexer.c: In function ‘yy_get_next_buffer’:
tools/lexer.c:1095: erreur: comparaison entre des expressions entières
signée et non signée
tools/lexer.c: In function ‘yy_init_buffer’:
tools/lexer.c:1415: erreur: implicit declaration of function ‘isatty’
make[1]: *** [tools/lexer.o] Erreur 1

Regards,

Mickael
