Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 May 2011 11:37:23 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Jaikumar Ganesh <jaikumar@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add BT_POWER L2CAP socket option.
Message-ID: <20110524083723.GB2480@null>
References: <1306199164-28310-1-git-send-email-jaikumar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306199164-28310-1-git-send-email-jaikumar@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaikumar,

On Mon, May 23, 2011 at 06:06:04PM -0700, ext Jaikumar Ganesh wrote:
> Add BT_POWER socket option used to control the power
> characteristics of the underlying ACL link. When the remote end
> has put the link in sniff mode and the host stack wants to send
> data we need need to explicitly exit sniff mode to work well with
> certain devices (For example, A2DP on Plantronics Voyager 855).
> However, this causes problems with HID devices.
> 
> Hence, moving into active mode when sending data, irrespective
> of who set the sniff mode has been made as a socket option. By
> default, we will move into active mode. HID devices can set the
> L2CAP socket option to prevent this from happening.
> 

I would prefer keeping old way the default way. Otherwise you need to update
all socket users in user space. Other that that this looks good to me.

-- 
Ville
