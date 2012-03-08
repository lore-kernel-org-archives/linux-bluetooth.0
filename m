Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Thu, 8 Mar 2012 09:43:56 +0900
Message-ID: <CABMQnV+pQqS97OLcBnUNK4xu735Gqikirdr0o0CbcGG_j+2sHw@mail.gmail.com>
Subject: bluez: Build fail with -std=c99 on using bluez application
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

When I built application using bluez with -std=c99 option, build failed.
It can build, when not checking c99. I tested with bluez 4.99.
Do you recommend not to checking c99?

Best regards,
  Nobuhiro
-----
$ cat t.c
#include <bluetooth/bluetooth.h>
$ gcc -std=c99 -c t.c
In file included from t.c:1:0:
/usr/include/bluetooth/bluetooth.h: In function ‘bt_get_le64’:
/usr/include/bluetooth/bluetooth.h:159:9: error: expected
specifier-qualifier-list before ‘typeof’
/usr/include/bluetooth/bluetooth.h:159:9: error: called object
‘typeof(__p)’ is not a function
/usr/include/bluetooth/bluetooth.h:159:9: error: ‘struct <anonymous>’
has no member named ‘__v’
/usr/include/bluetooth/bluetooth.h: In function ‘bt_get_be64’:
/usr/include/bluetooth/bluetooth.h:164:9: error: expected
specifier-qualifier-list before ‘typeof’
/usr/include/bluetooth/bluetooth.h:164:9: error: called object
‘typeof(__p)’ is not a function
/usr/include/bluetooth/bluetooth.h:164:9: error: ‘struct <anonymous>’
has no member named ‘__v’
/usr/include/bluetooth/bluetooth.h: In function ‘bt_get_le32’:
/usr/include/bluetooth/bluetooth.h:169:9: error: expected
specifier-qualifier-list before ‘typeof’
/usr/include/bluetooth/bluetooth.h:169:9: error: called object
‘typeof(__p)’ is not a function
/usr/include/bluetooth/bluetooth.h:169:9: error: ‘struct <anonymous>’
has no member named ‘__v’
/usr/include/bluetooth/bluetooth.h: In function ‘bt_get_be32’:
/usr/include/bluetooth/bluetooth.h:174:9: error: expected
specifier-qualifier-list before ‘typeof’
/usr/include/bluetooth/bluetooth.h:174:9: error: called object
‘typeof(__p)’ is not a function
/usr/include/bluetooth/bluetooth.h:174:9: error: ‘struct <anonymous>’
has no member named ‘__v’
/usr/include/bluetooth/bluetooth.h: In function ‘bt_get_le16’:
/usr/include/bluetooth/bluetooth.h:179:9: error: expected
specifier-qualifier-list before ‘typeof’
/usr/include/bluetooth/bluetooth.h:179:9: error: called object
‘typeof(__p)’ is not a function
/usr/include/bluetooth/bluetooth.h:179:9: error: ‘struct <anonymous>’
has no member named ‘__v’
/usr/include/bluetooth/bluetooth.h: In function ‘bt_get_be16’:
/usr/include/bluetooth/bluetooth.h:184:9: error: expected
specifier-qualifier-list before ‘typeof’
/usr/include/bluetooth/bluetooth.h:184:9: error: called object
‘typeof(__p)’ is not a function
/usr/include/bluetooth/bluetooth.h:184:9: error: ‘struct <anonymous>’
has no member named ‘__v’
-----
