Return-Path: <cyrus@holtmann.org>
From: =?koi8-r?Q?=F2=CF=CD=C1=CE?= <obivankinobi@mail.ru>
To: linux-bluetooth@vger.kernel.org
Subject: Configure bug
Mime-Version: 1.0
Date: Fri, 22 May 2009 13:24:36 +0400
Reply-To: =?koi8-r?Q?=F2=CF=CD=C1=CE?= <obivankinobi@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1M7QzU-0001CY-00.obivankinobi-mail-ru@f83.mail.ru>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!
I use Ubuntu Jauntry.
Configure pass with no errors when I try to install bluez-4.40.tar.gz.
But an error apear when I do "make":

libtool: link: cannot find the library `../sbc/libsbc.la' or unhandled argument `../sbc/libsbc.la'

The problem solved when I installed    libasound2-dev.
It would be good if Configure will check for libasound2-dev installed in system.

Thanks.
