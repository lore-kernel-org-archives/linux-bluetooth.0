Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1390999274-15631-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390999274-15631-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 29 Jan 2014 15:29:34 -0800
Message-ID: <CABBYNZKX1exqL=KpB=KUw2r+oezP+ikkWSJsM=jg-uCAYAc7hw@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] AVCTP test cases
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Jan 29, 2014 at 4:41 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Set of test cases which are feasible to implement with socketpair.
> Fragmentation of AVCTP is not supported yet.
>
> Andrei Emeltchenko (3):
>   unit/avctp: Add AVCTP unit test skeleton and first test
>   unit/avctp: Add TP/NFR/BV-02-C test
>   unit/avctp: Add TP/NFR/BI-01-C test
>
>  Makefile.am       |   8 ++
>  unit/test-avctp.c | 275 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 283 insertions(+)
>  create mode 100644 unit/test-avctp.c
>
> --
> 1.8.3.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
