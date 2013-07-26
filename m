Return-Path: <cyrus@holtmann.org>
Message-ID: <51F2D469.2020401@hurleysoftware.com>
Date: Fri, 26 Jul 2013 15:56:25 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: gustavo@padovan.org, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org,
 jslaby@suse.cz
Subject: Re: [PATCH v4 0/6] rfcomm: Implement rfcomm as a proper tty_port
References: <1374859138-19467-1-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1374859138-19467-1-git-send-email-gianluca@sottospazio.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/26/2013 01:18 PM, Gianluca Anzolin wrote:
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
> This happens because the underlying tty_struct objects and tty_port
> objects are freed while being used: the code doesn't take references
> properly.
>
> The following patches address the problem by implementing a proper
> tty_port driver for rfcomm.
>
> There are still some issues left: one relevant to flow control (which is
> also missing in the current code) and another relevant to a corner case
> in rfcomm_dev_state_change() that I intend to fix with a future patch.
> They are commented with a FIXME.
>
> Thank you,
> Gianluca

Gianluca,

Looks good, nice job :)  [ Thanks for the cover letter. ]

I tested device disconnect with i/o both in-progress and while idle.
I also tested remote disconnect and local device release.
Teardown was clean and complete with all tests.

[ Sorry that it took me a little while. I first had to review the
tools/rfcomm.c code to figure out the parameters expected! since
there were no examples on the man page. Then I had to disable the
pnat plugin because the error path when it's not installed closes
the wrong file! ]

I have a minor comment on 4/6 regarding one of the debug printks.
Other than that;

Reviewed-and-Tested-by: Peter Hurley <peter@hurleysoftware.com>

If Gustavo has you change stuff, please note changes in the cover
letter and in the patch itself below your sign-off line [example below],
so that I can follow along without re-reviewing the entire patch.

Regards,
Peter Hurley

--- >% ----
Implement .activate, .shutdown and .carrier_raised methods of tty_port
to manage the dlc, moving the code from rfcomm_tty_install() and
rfcomm_tty_cleanup() functions.

At the same time the tty .open()/.close() and .hangup() methods are
changed to use the tty_port helpers that properly call the
aforementioned tty_port methods.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---

  v5 - Fixed debug message in rfcomm_tty_activate()

  net/bluetooth/rfcomm/tty.c | 117 ++++++++++++++++++---------------------------
  1 file changed, 47 insertions(+), 70 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
.....
