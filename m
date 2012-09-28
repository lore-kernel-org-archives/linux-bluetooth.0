Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 12:58:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v3 4/6] hog: Create a FIFO for dummy suspend
Message-ID: <20120928095814.GC2518@x220>
References: <1348587260-431-1-git-send-email-claudio.takahasi@openbossa.org>
 <1348587260-431-5-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348587260-431-5-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Sep 25, 2012, Claudio Takahasi wrote:
> This patch creates a FIFO on "/tmp/hogsuspend" to allow the users to
> test the HoG suspend(HID Control Point) when the dummy back-end is
> enabled.
> ---
>  profiles/input/suspend-dummy.c | 102 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 101 insertions(+), 1 deletion(-)

Patches 1-3 have been applied but this one has issues:

Applying: hog: Create a FIFO for dummy suspend
WARNING:LONG_LINE: line over 80 characters
#64: FILE: profiles/input/suspend-dummy.c:84:
+	 * or output operation. When the remote closes the channel, hup signal is

Please fix and resend.

Johan
