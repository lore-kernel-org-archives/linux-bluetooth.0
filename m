Return-Path: <cyrus@holtmann.org>
Message-ID: <125720.17686.qm@web52606.mail.re2.yahoo.com>
References: <444018.59197.qm@web52606.mail.re2.yahoo.com> <AANLkTinA-E6v157y0DOf2gBzKykvT22vEn=9TddSvgy7@mail.gmail.com>
Date: Wed, 28 Jul 2010 07:04:29 -0700 (PDT)
From: Ed Tsang <netdesign_98@yahoo.com>
Subject: Re: How to past connect complete event status (page timeout) to apps
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
In-Reply-To: <AANLkTinA-E6v157y0DOf2gBzKykvT22vEn=9TddSvgy7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Luiz, Got it working now EHOSTDOWN, ETIMEOUT... I could not fix the git, as my 
private branch out of 0.14. 

    What I did is inject  at some of the call back (service_callback, 
rfcomm_callback..).  

     if (cond & (G_IO_NVAL | G_IO_ERR)) {
        int err = 0, sock = g_io_channel_unix_get_fd(io);
        socklen_t len = sizeof(err);

        if (getsockopt(sock, SOL_SOCKET, SO_ERROR, &err, &len) < 0)
            err = errno;  /* then send it to the agent via a new method*/
        }

--------
  Basically I will see G_IO_ERR when it fail (for those test case that I am 
working on).
   One question that I hope you could help me is to how to tune the timing for 
ETIMEOUT, GW_OBEX_ERROR_TIMEOUT. I tried to search (timeout|TIMEOUT) and did not 
get too far.

Cheers
Ed



