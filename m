Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: openobex-1.4 installation related
Date: Tue, 17 Feb 2009 09:14:02 +0800
Message-ID: <9F2B2656C8747B498D56A7B30FF5EB9FF291F4@CNMAIL13.cn.utstarcom.com>
In-Reply-To: <6887eb5d0902160425g5f3155bbr65d1e5002e32d45a@mail.gmail.com>
From: "Yao Ye" <yeyao@utstar.com>
To: "Kartikey Parmar" <kartikey2781@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 
> After that when I attempt to install obexftp-0.22 - in its
configuration it shows an error
> like "openobex-config" not found, probably openobex is not
installed...

you should use export PKG_CONFIG_PATH as below:

obexftp-0.22:
	export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig;
	export PKG_CONFIG_LIBDIR=/usr/local/lib/pkgconfig;
	cd obexftp-0.22;
	./configure --disable-perl --disable-python --disable-ruby
--disable-tcl
	make;
	make install;
	
openobex-1.5:
	export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig;
	export PKG_CONFIG_LIBDIR=/usr/local/lib/pkgconfig;
	cd openobex-1.5;
	./configure --disable-usb --enable-apps
	make;
	make install;
	

