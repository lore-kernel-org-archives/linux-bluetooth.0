Return-Path: <cyrus@holtmann.org>
Date: Mon, 15 Jul 2013 12:25:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] core: Use proper header for S_IRUSR/S_IWUSR
Message-ID: <20130715092517.GA28987@x220.p-661hnu-f1>
References: <1373355600-12674-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373355600-12674-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Jul 09, 2013, Szymon Janc wrote:
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
> ---
>  src/attrib-server.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
