Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: OBEX profile support
Date: Tue, 17 Feb 2009 09:05:56 +0800
Message-ID: <9F2B2656C8747B498D56A7B30FF5EB9FF291E9@CNMAIL13.cn.utstarcom.com>
In-Reply-To: <6b53b1990902160446s14960c17j32da4f778d623234@mail.gmail.com>
From: "Yao Ye" <yeyao@utstar.com>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> I have openobex compiled, but obexftp fail to compile due to its
bluetooth code.

> if gcc -DHAVE_CONFIG_H -I. -I. -I.. -I.. -I../includes    -g -O2 -W
> -Wundef -Wmissing-declarations -Wmissing-prototypes -Wall -MT
obexftpd.o -MD -MP -MF ".deps/obexftpd.Tpo" -c -o obexftpd.o obexftpd.c;
\
>         then mv -f ".deps/obexftpd.Tpo" ".deps/obexftpd.Po"; else rm
-f ".deps/obexftpd.Tpo"; exit 1; fi
> obexftpd.c:81: error: expected '=', ',', ';', 'asm' or '__attribute__'
> before '*' token
> obexftpd.c: In function 'start_server':
> obexftpd.c:891: warning: implicit declaration of function
'BtOBEX_ServerRegister'
> obexftpd.c:891: error: 'bt_src' undeclared (first use in this
function)

in obexftp-0.22-arm\apps\obexftpd.c, 
del static bdaddr_t *bt_src = NULL;
and add as below,
then compile again.


#ifdef HAVE_BLUETOOTH

//static bdaddr_t *bt_src = NULL; //del by yaoye

//add by yaoye
struct {
	uint8_t b[6];
} __attribute__((packed)) *bt_src = NULL;

#endif
