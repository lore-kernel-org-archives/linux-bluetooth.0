Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Jul 2013 07:37:25 +0200
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org
Subject: Re: [PATCH v2 2/7] rfcomm: Move the tty initialization and cleanup
 out of open/close
Message-ID: <20130725053725.GA7214@sottospazio.it>
References: <1374510435-12149-1-git-send-email-gianluca@sottospazio.it>
 <1374510435-12149-2-git-send-email-gianluca@sottospazio.it>
 <51F0550A.1000402@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51F0550A.1000402@hurleysoftware.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jul 24, 2013 at 06:28:26PM -0400, Peter Hurley wrote:
> Gianluca,
> 
> The code you intend to keep in rfcomm_tty_open() should not be moved to
> rfcomm_tty_install() in this patch and then moved back to rfcomm_tty_open()
> in 4/7. It should stay in rfcomm_tty_open().
> 
> Likewise, the code being deleted in rfcomm_tty_install() in 4/7 should
> remain in rfcomm_tty_open() here, and be deleted from rfcomm_tty_open() in
> 4/7 instead.
> 
> IOW, there's a much smaller changeset that will achieve the same end
> product.

Hello,

sorry I'm not very used to submit patches "the right way" and I missed the
point that I have to keep the changes to the minimum.

I also resent the tty_port patch, I hope it's fine now, I assumed it
was accepted but it wasn't and I also missed your last comment... I should lose
this bad habit to read only the the visible part of the mail body. :D

Ok, I'll rearrange the code and resend the rfcomm patches.

Thank you,
Gianluca
