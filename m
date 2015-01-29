Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1422360212-19812-1-git-send-email-luiz.dentz@gmail.com>
References: <1422360212-19812-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 29 Jan 2015 13:11:37 +0200
Message-ID: <CABBYNZK8nkbjZuJZz2Hn8OUTgrdOg1+fX_RF2dutEA39Qz0zeg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/9] Read Long client unit tests
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jan 27, 2015 at 2:03 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> These implement the unit tests for read long procedure as a client and
> fix the behavior for values over maximum length.
>
> Luiz Augusto von Dentz (9):
>   unit/gatt: Add TP/GAR/CL/BV-04-C test
>   unit/gatt: Add TP/GAR/CL/BV-04-C/512B test
>   shared/gatt-client: Fix read long value
>   unit/gatt: Add TP/GAR/CL/BI-12-C test
>   unit/gatt: Add TP/GAR/CL/BI-13-C test
>   unit/gatt: Add TP/GAR/CL/BI-14-C test
>   unit/gatt: Add TP/GAR/CL/BI-15-C test
>   unit/gatt: Add TP/GAR/CL/BI-16-C test
>   unit/gatt: Add TP/GAR/CL/BI-17-C test
>
>  src/shared/att-types.h   |   1 +
>  src/shared/gatt-client.c |  12 ++-
>  unit/test-gatt.c         | 224 ++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 229 insertions(+), 8 deletions(-)
>
> --
> 2.1.0

Applied.


-- 
Luiz Augusto von Dentz
