Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6887eb5d0902162058g57d5dedel7071bcbb845ddd78@mail.gmail.com>
References: <6887eb5d0902160425g5f3155bbr65d1e5002e32d45a@mail.gmail.com>
	 <9F2B2656C8747B498D56A7B30FF5EB9FF291F4@CNMAIL13.cn.utstarcom.com>
	 <6887eb5d0902162058g57d5dedel7071bcbb845ddd78@mail.gmail.com>
Date: Tue, 17 Feb 2009 10:29:31 +0530
Message-ID: <6887eb5d0902162059r2ae49b2enf3f6a6f027be2235@mail.gmail.com>
Subject: Fwd: openobex-1.4 installation related
From: Kartikey Parmar <kartikey2781@gmail.com>
To: Yao Ye <yeyao@utstar.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thank u very much...
It is successfully installed on Fedora 9

hey can I use obexftp directly to browse my mobile via bluetooth?

I tried one option: "obexftp -b -C Images -g Image0003.jpt" that give
me:-> error Connect()
Connection not available???

Any idea?

On Tue, Feb 17, 2009 at 6:44 AM, Yao Ye <yeyao@utstar.com> wrote:
>
>> After that when I attempt to install obexftp-0.22 - in its
> configuration it shows an error
>> like "openobex-config" not found, probably openobex is not
> installed...
>
> you should use export PKG_CONFIG_PATH as below:
>
> obexftp-0.22:
>        export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig;
>        export PKG_CONFIG_LIBDIR=/usr/local/lib/pkgconfig;
>        cd obexftp-0.22;
>        ./configure --disable-perl --disable-python --disable-ruby
> --disable-tcl
>        make;
>        make install;
>
> openobex-1.5:
>        export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig;
>        export PKG_CONFIG_LIBDIR=/usr/local/lib/pkgconfig;
>        cd openobex-1.5;
>        ./configure --disable-usb --enable-apps
>        make;
>        make install;
>
>
>

--
Kartikey Parmar
R&D Software Engg
Matrix Telecom Pvt Ltd
Baroda, Gujarat (India)
09879095390 (M)



-- 
Kartikey Parmar
R&D Software Engg
Matrix Telecom Pvt Ltd
Baroda, Gujarat (India)
09879095390 (M)
