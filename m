Return-Path: <cyrus@holtmann.org>
Date: Sat, 23 Feb 2013 12:48:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: Re: [PATCH] gdbus: Always unreference the message in
 g_dbus_send_message()
Message-ID: <20130223104854.GA2663@x220.P-661HNU-F1>
References: <1360331890-21983-1-git-send-email-tomasz.bursztyka@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360331890-21983-1-git-send-email-tomasz.bursztyka@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomasz,

On Fri, Feb 08, 2013, Tomasz Bursztyka wrote:
> ---
> 
> Hi,
> 
> A quick fix on g_dbus_send_message(), if check_signal() fails it returns FALSE without unreferencing
> the message as it should. This patch fixes it.
> 
>  gdbus/object.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Thanks. Applied, though I had to move the comment part into the actual
commit message.

Johan
