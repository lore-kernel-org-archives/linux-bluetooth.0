Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1390838187-25006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390838187-25006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 27 Jan 2014 10:36:42 -0800
Message-ID: <CABBYNZKusSmbTTEVLmU2Xa4+L5dOaKCHt8dFaeT2jP_==uL+jw@mail.gmail.com>
Subject: Re: [RFC] Initial avctp test
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Jan 27, 2014 at 7:56 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> This is initial invalid packet size test, sent as RFC since I am not
> sure what might be tested for avctp.
>
> Andrei Emeltchenko (1):
>   unit/avctp: Add initial AVCTP test setup
>
>  Makefile.am       |   8 ++
>  unit/test-avctp.c | 262 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 270 insertions(+)
>  create mode 100644 unit/test-avctp.c
>
> --
> 1.8.3.2

You should follow the testing spec:
https://www.bluetooth.org/docman/handlers/DownloadDoc.ashx?doc_id=40404

Please follow the same name convention that is used by the testing
spec and for now do not introduce any other test that is not part of
the testing spec.

-- 
Luiz Augusto von Dentz
