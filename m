Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Jan 2014 12:36:44 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] Initial avctp test
Message-ID: <20140128103641.GB9043@aemeltch-MOBL1>
References: <1390838187-25006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZKusSmbTTEVLmU2Xa4+L5dOaKCHt8dFaeT2jP_==uL+jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZKusSmbTTEVLmU2Xa4+L5dOaKCHt8dFaeT2jP_==uL+jw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Jan 27, 2014 at 10:36:42AM -0800, Luiz Augusto von Dentz wrote:
> Hi Andrei,
> 
> On Mon, Jan 27, 2014 at 7:56 AM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > This is initial invalid packet size test, sent as RFC since I am not
> > sure what might be tested for avctp.
> >
> > Andrei Emeltchenko (1):
> >   unit/avctp: Add initial AVCTP test setup
> >
> >  Makefile.am       |   8 ++
> >  unit/test-avctp.c | 262 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 270 insertions(+)
> >  create mode 100644 unit/test-avctp.c
> >
> > --
> > 1.8.3.2
> 
> You should follow the testing spec:
> https://www.bluetooth.org/docman/handlers/DownloadDoc.ashx?doc_id=40404
> 
> Please follow the same name convention that is used by the testing
> spec and for now do not introduce any other test that is not part of
> the testing spec.

I have this AVCTP.TS spec but what might be tested for example with test
case "TP/CCM/BV-01-C"?

Even looking at session_cb() for AVCTP there seems to be only packet
length check. In contrast for AVDTP there is command parser so you might
be able to test something.

Shall we test AVRCP instead?

Best regards 
Andrei Emeltchenko 
