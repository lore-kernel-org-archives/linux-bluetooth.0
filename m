Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Dec 2013 10:01:32 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/6] android/a2dp: Fix possible NULL dereference
Message-ID: <20131209080131.GB6506@aemeltch-MOBL1>
References: <1386085993-22055-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZKRWtCvq_yg7dT+2iJFL5rvPauiOkqYP3diCc_6TN_SkA@mail.gmail.com>
 <20131204083622.GA18198@aemeltch-MOBL1>
 <CABBYNZ+pmDkN0EHuycjtSxaAfW0ZT94OtN7TRK1+pBo99ydM+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZ+pmDkN0EHuycjtSxaAfW0ZT94OtN7TRK1+pBo99ydM+g@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sun, Dec 08, 2013 at 05:39:37PM +0200, Luiz Augusto von Dentz wrote:
> I fixed this myself and applied 1-4, patch 5 is actually wrong since
> sdp_next_handle may return values bellow 0x10000 if we run out of

OK

> handles and patch 6 is not necessary since what is in android/avdtp.c
> is what we will be using in the future.

How are we going to use those local vars? If they would be global it probably
make some (little) sense ...


@@ -773,10 +773,9 @@ static int get_send_buffer_size(int sk)
 	socklen_t optlen = sizeof(size);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_SNDBUF, &size, &optlen) < 0) {
-		int err = -errno;
-		error("getsockopt(SO_SNDBUF) failed: %s (%d)", strerror(-err),
-									-err);
-		return err;
+		error("getsockopt(SO_SNDBUF) failed: %s (%d)", strerror(errno),
+									errno);
+		return -errno;
 	}
 
 	/*


Regards,
Andrei
