Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1393941735-12187-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393941735-12187-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 5 Mar 2014 10:24:36 +0200
Message-ID: <CABBYNZ+taZtCf+OGZnYJ6jjBDT+p3FHKBv4Xy5h8o0USQMMMGQ@mail.gmail.com>
Subject: Re: [PATCHv2 00/10] AVRCP test patches rebased
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Mar 4, 2014 at 4:02 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> This is rebased version of my previous patch set rebased after
> latest modifications of avrcp-lib.
>
> Andrei Emeltchenko (10):
>   avrcp: Fix possible buffer overflow
>   unit/avrcp: Add /TP/PAS/BV-06-C test
>   unit/avrcp: Add /TP/PAS/BV-08-C test
>   android/avrcp: Add avrcp_get_current_player_value() function
>   unit/avrcp: Add /TP/PAS/BV-09-C test
>   unit/avrcp: Add /TP/PAS/BV-10-C test
>   android/avrcp: Add avrcp_set_player_value() function
>   unit/avrcp: Add /TP/PAS/BV-11-C test
>   unit/avrcp: Add /TP/PAS/BI-01-C test
>   doc: Update test coverage document
>
>  android/avrcp-lib.c    |  39 +++++++++++++
>  android/avrcp-lib.h    |  14 +++++
>  doc/test-coverage.txt  |   2 +-
>  profiles/audio/avrcp.c |   3 +
>  unit/test-avrcp.c      | 156 +++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 213 insertions(+), 1 deletion(-)
>
> --
> 1.8.3.2

Pushed, not that the first I did not apply since there already a check
if attributes are within the valid range before calling that function,
also change some parameter and code placement to be more consistent
and don't use VLA for buffers.


-- 
Luiz Augusto von Dentz
