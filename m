Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Bastien Nocera <hadess@hadess.net>
Subject: Re: Warning fixes for GCC 4.6
Date: Fri, 6 May 2011 17:08:36 +0200
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
References: <1304620983.16101.16.camel@novo.hadess.net> <BANLkTinBw-qXODF03rtcW+M3GEjK7yC3NQ@mail.gmail.com> <1304693325.16101.34.camel@novo.hadess.net>
In-Reply-To: <1304693325.16101.34.camel@novo.hadess.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201105061708.36472.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> > Can't we just removed err here, Im afraid using
> > __attribute__((__unused__)) is not a good practice and we should try
> > to avoid using it.
> 
> We either get a warning that the return value is unused, or that we
> should be checking the return value. Which one do you prefer?

Maybe sth like this:

diff --git a/input/device.c b/input/device.c
index 316b2cc..2da2030 100644
--- a/input/device.c
+++ b/input/device.c
@@ -250,14 +250,14 @@ static int decode_key(const char *str)
 static void send_event(int fd, uint16_t type, uint16_t code, int32_t value)
 {
        struct uinput_event event;
-       int err;
 
        memset(&event, 0, sizeof(event));
        event.type      = type;
        event.code      = code;
        event.value     = value;
 
-       err = write(fd, &event, sizeof(event));
+       if (write(fd, &event, sizeof(event)) < 0)
+               error("input: send_event failed: %s", strerror(errno));
 }

-- 
BR
Szymon Janc
