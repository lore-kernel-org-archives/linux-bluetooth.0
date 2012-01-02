Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 2 Jan 2012 21:50:15 +0100
Message-ID: <CABMX=Ww6G0sofOfHKVTL_PgrMW_K4ByWQa0SF5XZijAp+r9PgQ@mail.gmail.com>
Subject: Re: bluez-4.97: check dependnecy
From: nello martuscielli <ppc.addon@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi,
i'm trying to build bluez-4.97 on my system (CRUX PPC 32bit) and i'd
like to build it without 'check' dependency.
I patched sources using :
build: Move libcheck under TEST conditional
author	Marcel Holtmann <marcel@holtmann.org>	
	Wed, 28 Dec 2011 04:09:56 +0000 (20:09 -0800)
commit	bf5d45f2fbd1b1463512f4eb8d30bffb3478ccc7

and adding --disable-test to my configure but i still receive:

[...]
checking whether yytext is a pointer... yes
checking for CHECK... configure: error: Package requirements (check >=
0.9.4) were not met:

No package 'check' found

Consider adjusting the PKG_CONFIG_PATH environment variable if you
installed software in a non-standard prefix.

Alternatively, you may set the environment variables CHECK_CFLAGS
and CHECK_LIBS to avoid the need to call pkg-config.
See the pkg-config man page for more details.



cheers,
nello
-- 
my blog: http://linuxpowerpc.blogspot.com/
--
Power Mac G4 AGP 450MHz - CRUX PPC (32bit)
