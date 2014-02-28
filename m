Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1393575778-28681-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393575778-28681-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 28 Feb 2014 10:04:21 +0100
Message-ID: <CABBYNZLxCXEQu0=7erRGdLCttCkPBKrzo4yZCUYNLgtJX8Nh8w@mail.gmail.com>
Subject: Re: [PATCHv2 0/9] Combined set of AVRCP test patches
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Feb 28, 2014 at 9:22 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Combined set of AVRCP function implementation and unit tests.
>
> Andrei Emeltchenko (9):
>   android/avrcp: Refactor get_caps() to allow parameter
>   unit/avrcp: Fix lengths byte order
>   unit/avrcp: Add /TP/CFG/BI-01-C test
>   android/avrcp: Add list player attributes command
>   unit/avrcp: Add /TP/PAS/BV-01-C test
>   unit/avrcp: Add /TP/PAS/BV-02-C test
>   android/avrcp: Implement get player attributes text
>   unit/avrcp: Add /TP/PAS/BV-03-C test
>   unit/avrcp: Add /TP/PAS/BV-04-C test
>
>  android/avrcp-lib.c | 23 ++++++++++++---
>  android/avrcp-lib.h |  7 ++++-
>  unit/test-avrcp.c   | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 105 insertions(+), 7 deletions(-)
>
> --
> 1.8.3.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
