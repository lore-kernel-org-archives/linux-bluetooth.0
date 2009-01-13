Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: define of DBUS_SYSTEM_CONFIG_FILE ?
Date: Tue, 13 Jan 2009 14:57:35 +0800
Message-ID: <9F2B2656C8747B498D56A7B30FF5EB9FE557B9@CNMAIL13.cn.utstarcom.com>
In-Reply-To: <9F2B2656C8747B498D56A7B30FF5EB9FE556FC@CNMAIL13.cn.utstarcom.com>
From: "Yao Ye" <yeyao@utstar.com>
To: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have fixed this problem !
It is defined in Makefile, not in config.h !

[root@localhost dbus-1.2.6-arm]# grep -r 'DBUS_SYSTEM_CONFIG_FILE' ./
./ChangeLog.pre-1-2:    * dbus/Makefile.am (INCLUDES): move
DBUS_SYSTEM_CONFIG_FILE and
./dbus/Makefile.in:
-DDBUS_SYSTEM_CONFIG_FILE=\""$(configdir)/system.conf"\"
\
./dbus/Makefile:
-DDBUS_SYSTEM_CONFIG_FILE=\""$(configdir)/system.conf"\"
\
./dbus/Makefile.am:
-DDBUS_SYSTEM_CONFIG_FILE=\""$(configdir)/system.conf"\"
\
./dbus/dbus-sysdeps-unix.c: //     _dbus_warn
("\nDBUS_SYSTEM_CONFIG_FILE= %s!\n",  DBUS_SYSTEM_CONFIG_FILE);
./bus/Makefile.in:
-DDBUS_SYSTEM_CONFIG_FILE=\""$(configdir)/system.conf"\"        \
./bus/Makefile: -DDBUS_SYSTEM_CONFIG_FILE=\""$(configdir)/system.conf"\"
\
./bus/activation-helper.c://  if (!_dbus_string_append (&config_file,
DBUS_SYSTEM_CONFIG_FILE))
./bus/Makefile.am:
-DDBUS_SYSTEM_CONFIG_FILE=\""$(configdir)/system.conf"\" 

