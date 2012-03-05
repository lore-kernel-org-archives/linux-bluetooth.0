Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1330953167.3457.13.camel@pohly-mobl1.fritz.box>
References: <1326708715.3360.135.camel@pohly-mobl1.fritz.box>
	<1330903638.3392.141.camel@aeonflux>
	<1330932819.4028.59.camel@pohly-mobl1.fritz.box>
	<CAOcK=CNZofxZtUp4Zh5eiGMM_TYrbGOwseA3tcwAnAFDvLEFxg@mail.gmail.com>
	<1330953167.3457.13.camel@pohly-mobl1.fritz.box>
Date: Mon, 5 Mar 2012 15:53:19 +0100
Message-ID: <CAOcK=CPM4Kyy6+Fs10ADs7dJdyqF35co_b1bX-VJeKGjGUjcVQ@mail.gmail.com>
Subject: Re: [PATCH] bluetooth.h: fix compile issue when using in C++
From: Markus Rathgeb <maggu2810@googlemail.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

2012/3/5 Patrick Ohly <patrick.ohly@intel.com>:
> I'm fine with using __typeof__ instead of typeof. I verified that g++
> 4.6.2 and clang++ 3.0 grok __typeof__, with and without -std=c++0x. I
> also checked that gcc accepts it without -std, with -std=gnu89, and with
> -std=c99. It rejects the header file with -std=c89 because of the inline
> keyword.

The gcc documentation states also this for the typeof C extension:

"If you are writing a header file that must work when included in ISO
C programs, write __typeof__ instead of typeof."

Source: http://gcc.gnu.org/onlinedocs/gcc/Typeof.html
