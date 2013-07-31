Return-Path: <cyrus@holtmann.org>
Message-ID: <51F94E67.3040402@hurleysoftware.com>
Date: Wed, 31 Jul 2013 13:50:31 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: gustavo@padovan.org, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org,
 jslaby@suse.cz
Subject: Re: [PATCH v5 0/6] rfcomm: Implement rfcomm as a proper tty_port
References: <1375110493-5237-1-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1375110493-5237-1-git-send-email-gianluca@sottospazio.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/29/2013 11:08 AM, Gianluca Anzolin wrote:
> This patchset addresses an issue with the rfcomm tty driver in the
> current stable kernels that manifests itself as a sudden lockup of the
> whole machine or as a OOPS if we are lucky enough (I wasn't).
>
> Triggering the problem is very easy:
>
> 1) establish a bluetooth connection with a bluetooth host
> 2) open the tty it provides with some program
> 3) turn off the bluetooth host or take it out of range
>
> After a timeout the machine freezes.
>
> Another way to trigger these lockups is to simply release the rfcomm
> tty.
>
> This happens beacuse the underlying tty_struct objects and tty_port
> objects are freed while being used: the code doesn't take proper
> references to them.
>
> The following patches address the problem by implementing a proper
> tty_port driver for rfcomm.
>
> There are still some issues left: one relevant to flow control (which is
> also missing in the current code) and another relevant to a corner case
> in rfcomm_dev_state_change() that I intend to fix with a future patch.
> They are commented with a FIXME.
>
> Changes from v4:
>    [PATCH 3/6]: left the debug message in rfcomm_tty_open()
>    [PATCH 5/6]: always use !test_and_set_bit() to release the tty_port

I reviewed these changes and retested. All ok.

Regards,
Peter Hurley

>
> Thank you,
> Gianluca
>
> Gianluca Anzolin (6):
>    rfcomm: Take proper tty_struct references
>    rfcomm: Remove the device from the list in the destructor
>    rfcomm: Move the tty initialization and cleanup out of open/close
>    rfcomm: Implement .activate, .shutdown and .carrier_raised methods
>    rfcomm: Fix the reference counting of tty_port
>    rfcomm: Purge the dlc->tx_queue to avoid circular dependency
>
>   net/bluetooth/rfcomm/tty.c | 271 +++++++++++++++++++++------------------------
>   1 file changed, 126 insertions(+), 145 deletions(-)
>
