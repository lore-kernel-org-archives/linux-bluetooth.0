Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416396393-19997-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416396393-19997-1-git-send-email-marcin.kraglak@tieto.com>
Date: Wed, 19 Nov 2014 18:56:13 +0200
Message-ID: <CABBYNZKwjXtAqdH7w1fVx=5jFZs36mFUb--MWy6WgRkcZB_r3w@mail.gmail.com>
Subject: Re: [PATCHv2 0/9] Read-by-type functionality
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Nov 19, 2014 at 1:26 PM, Marcin Kraglak
<marcin.kraglak@tieto.com> wrote:
> It allows user to perform Read By Type requests with given UUID
>
> v2:
>         Implementation moved to gatt-helpers instead of gatt-client
>         after conversation with Arman and Luiz.
>
> Marcin Kraglak (9):
>   shared/gatt-helpers: Add read-by-type functionality
>   shared/gatt-helpers: Add iterator to read_by_type results
>   unit/test-gatt: Add /TP/GAR/CL/BV-03-C-1 test
>   unit/test-gatt: Add /TP/GAR/CL/BV-03-C-2 test
>   unit/test-gatt: Add /TP/GAR/CL/BI-06-C test
>   unit/test-gatt: Add /TP/GAR/CL/BI-07-C test
>   unit/test-gatt: Add /TP/GAR/CL/BI-09-C test
>   unit/test-gatt: Add /TP/GAR/CL/BI-10-C test
>   unit/test-gatt: Add /TP/GAR/CL/BI-11-C test
>
>  src/shared/gatt-helpers.c | 152 ++++++++++++++++++++++++++++++++++++++++++-
>  src/shared/gatt-helpers.h |   9 +++
>  unit/test-gatt.c          | 160 ++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 316 insertions(+), 5 deletions(-)
>
> --
> 1.9.3

Applied, thanks.



-- 
Luiz Augusto von Dentz
