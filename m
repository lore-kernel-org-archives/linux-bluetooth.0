Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v5 0/4] Handling extended headers of bnep control frames
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1428056095-21978-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Date: Fri, 3 Apr 2015 10:56:07 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EAF4DFCC-417B-4014-9ABA-295BAA2189FF@holtmann.org>
References: <1428056095-21978-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

> This patch set adds support for handling extended headers of bnep control
> frames which is mandatory. Until now extended headers for control messages was
> ignored.
> 
> Patch [1/4] adds setting of err variable if control message is not understood.
> Patch [2/4] adds additional ioctl for get supported bnep features. This is
> needed for user space to know if handling of sending success setup response
> frame should be handled by kernel or by user space.
> Patch [3/4] adds support for handling extended headers of bnep control frames.
> Patch [4/4] adds support for handling connection setup request.
> 
> Patch set tested with PTS bnep test cases. No regression, issues found during
> testing.
> 
> v2.
> - Added ioctl definition to compat_ioctl,
> - Distinct bnep session flags and bnep features.
> 
> v3.
> - Splited extended header, connection setup request handling into separated
> 	patches,
> - Fixed flags, supported features defines as Marcel pointed,
> - Extended commit messages,
> - Remove copying flags from us to kernel bnep session,
> - Fix setting bnep session bits as Marcel pointed.
> 
> v4.
> - Unify internal/us flags usage like in HIDP, CMTP,
> - Refactor send setup response as Marcel suggested,
> - Make supported feature variable as local ioctl variable and set it while
> adding session if required.
> 
> v5.
> - Rebase on top of "flags validation check" patch set,
> - Remove blank line style fix,
> - Add session flag setting after validation flag check.
> 
> Grzegorz Kolodziejczyk (4):
>  Bluetooth: bnep: Return err value while sending cmd is not understood
>  Bluetooth: bnep: Add support for get bnep features via ioctl
>  Bluetooth: bnep: Add support to extended headers of control frames
>  Bluetooth: bnep: Handle BNEP connection setup request
> 
> fs/compat_ioctl.c         |  1 +
> net/bluetooth/bnep/bnep.h |  4 +++
> net/bluetooth/bnep/core.c | 64 ++++++++++++++++++++++++++++++++++++-----------
> net/bluetooth/bnep/sock.c |  7 ++++++
> 4 files changed, 62 insertions(+), 14 deletions(-)

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel

