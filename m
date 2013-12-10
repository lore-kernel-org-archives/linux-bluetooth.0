Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Dec 2013 10:33:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Fix eir parsing function.
Message-ID: <20131210083350.GA21174@x220.p-661hnu-f1>
References: <20131129082247.GA6800@x220.p-661hnu-f1>
 <1386663340-12730-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386663340-12730-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Dec 10, 2013, Andrei Emeltchenko wrote:
> Currently eir_parse always return 0 but it is checked throughout the code
> (in android/bluetooth code as well in src/adapteri, etc) for return value
> (err < 0) which never happens. Make function eir_parse return void. This
> fixes warnings from static analyzer tools.
> ---
>  android/bluetooth.c | 7 +------
>  src/adapter.c       | 7 +------
>  src/eir.c           | 8 +++-----
>  src/eir.h           | 2 +-
>  unit/test-eir.c     | 8 ++------
>  5 files changed, 8 insertions(+), 24 deletions(-)

Applied (after fixing up the subject a bit). Thanks.

Johan
