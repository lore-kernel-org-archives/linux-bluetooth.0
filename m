Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 7 Oct 2009 12:01:09 -0300
Message-ID: <6b53b1990910070801p6fa975c8i4ee5ffcf36cf96f7@mail.gmail.com>
Subject: bluez build error
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

I'm getting this error when doing a ./bootstrapconfigure and the make:


tools/kword.c:36:20: error: parser.h: No such file or directory
tools/kword.c:41: error: 'K_BIND' undeclared here (not in a function)
tools/kword.c:42: error: 'K_DEVICE' undeclared here (not in a function)
tools/kword.c:43: error: 'K_CHANNEL' undeclared here (not in a function)
tools/kword.c:44: error: 'K_COMMENT' undeclared here (not in a function)
tools/kword.c:46: error: 'K_YES' undeclared here (not in a function)
tools/kword.c:47: error: 'K_NO' undeclared here (not in a function)
make[1]: *** [tools/kword.o] Error 1
make[1]: *** Waiting for unfinished jobs....
updating tools/parser.h
make: *** [all] Error 2



A second make goes fine and everything compiles.


-- 
Gustavo F. Padovan
http://padovan.org
