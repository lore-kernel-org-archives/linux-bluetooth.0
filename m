Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416402095-5137-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416402095-5137-1-git-send-email-marcin.kraglak@tieto.com>
Date: Thu, 20 Nov 2014 12:23:55 +0200
Message-ID: <CABBYNZ+0TLcQjA-PSiYWcm5Shj6BdWJt0gdUG=OWQKSZJKJ+hQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Implement Read Multiple in gatt-client
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Nov 19, 2014 at 3:01 PM, Marcin Kraglak
<marcin.kraglak@tieto.com> wrote:
> This implementation is done in gatt-client and functionality
> is exposed in btgatt-client tool.
> This implementation was tested against PTS and corresponding
> unit tests are added too.
>
> Comments are welcome
>
> Marcin Kraglak (8):
>   shared/gatt-client: Implement Read Multiple request
>   tools/btgatt-client: Add read_multiple_cmd
>   unit/test-gatt: Add /TP/GAR/CL/BV-05-C test
>   unit/test-gatt: Add /TP/GAR/CL/BI-18-C test
>   unit/test-gatt: Add /TP/GAR/CL/BI-19-C test
>   unit/test-gatt: Add /TP/GAR/CL/BI-20-C test
>   unit/test-gatt: Add /TP/GAR/CL/BI-21-C test
>   unit/test-gatt: Add /TP/GAR/CL/BI-22-C test
>
>  src/shared/gatt-client.c |  65 ++++++++++++++++++++++++++++
>  src/shared/gatt-client.h |   7 +++
>  tools/btgatt-client.c    |  60 ++++++++++++++++++++++++++
>  unit/test-gatt.c         | 109 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 241 insertions(+)
>
> --
> 1.9.3

Applied, thanks.


-- 
Luiz Augusto von Dentz
