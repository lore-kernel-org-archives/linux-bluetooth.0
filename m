Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] core: Use proper header for S_IRUSR/S_IWUSR
Date: Wed, 31 Jul 2013 09:39:39 +0200
Message-ID: <1668276.7oGYD4Lvyj@uw000953>
In-Reply-To: <1373355600-12674-1-git-send-email-szymon.janc@tieto.com>
References: <1373355600-12674-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 09 of July 2013 09:40:00 Szymon Janc wrote:
> According to open() manual one should include <sys/stat.h>.
> This fix build with bionic library:
> 
> target thumb C: libbluetoothd <= external/bluetooth/bluez/src/attrib-server.c
> external/bluetooth/bluez/src/attrib-server.c: In function 'write_value':
> external/bluetooth/bluez/src/attrib-server.c:922:26: error: 'S_IRUSR'
> 	 undeclared (first use in this function)
> external/bluetooth/bluez/src/attrib-server.c:922:26: note: each undeclared
> 	identifier is reported only once for each function it appears in
> external/bluetooth/bluez/src/attrib-server.c:922:36: error: 'S_IWUSR'
> 	undeclared (first use in this function)

ping
