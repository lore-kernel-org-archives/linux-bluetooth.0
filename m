Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1390998967-24610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390998967-24610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 29 Jan 2014 09:07:02 -0800
Message-ID: <CABBYNZL3H88gj04q0bdaKCBAwYeo6M4ejhUmwLNx=J8s2g0jEw@mail.gmail.com>
Subject: Re: [PATCHv2 0/8] Set of AVCTP fixes
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Jan 29, 2014 at 4:35 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> AVCTP issues found during writing test cases.
>
> Changes:
>         * v2: Added last 2 patches to series.
>
> Andrei Emeltchenko (8):
>   android/avctp: Use predefined HEADER_LENGTH instead of sizeof
>   android/avctp: Fix wrong error message
>   avctp: Use already calculated avc header
>   avctp: trivial: Do not break short line
>   avctp: Use predefined HEADER_LENGTH instead of sizeof
>   avctp: Fix wrong error message
>   android/avctp: Move AVC_HEADER_LENGTH from avctp header
>   avctp: Fix unchecked return value
>
>  android/avctp.c        | 16 +++++++------
>  android/avctp.h        |  1 -
>  profiles/audio/avctp.c | 64 +++++++++++++++++++++++++++++++++++---------------
>  3 files changed, 54 insertions(+), 27 deletions(-)
>
> --
> 1.8.3.2

Patches 1-7 applied, patch 8 needs some investigation if we can reduce
that many ioctl in a row.


-- 
Luiz Augusto von Dentz
