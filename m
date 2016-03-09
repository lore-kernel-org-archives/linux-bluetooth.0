Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Wed, 9 Mar 2016 17:42:17 +0100
Message-ID: <CAEZxfGPBv4YJwMEMVSeJQmy5fwzgd6ANpwBUXeZeiv2Pox865Q@mail.gmail.com>
Subject: Feature Request: Clean the cache upon device disconnection
To: BlueZ development <linux-bluetooth@vger.kernel.org>,
	ortuno@google.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As we've discovered recently
(https://github.com/thegecko/web-bluetooth-dfu/issues/12#issuecomment-194348474),
it looks like BlueZ trunk doesn't clean/update its cache upon device
disconnection.

Is this on purpose?
If not, can it be fixed?
