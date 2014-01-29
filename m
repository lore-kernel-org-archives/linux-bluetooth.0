Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Jan 2014 09:56:42 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] android/avctp: Move struct definitions to header
Message-ID: <20140129075635.GC9043@aemeltch-MOBL1>
References: <1390912485-16357-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZKKvD2=OGYoTdbH7=buaZMpaDN51aWd4aRrFR+7rWVSoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZKKvD2=OGYoTdbH7=buaZMpaDN51aWd4aRrFR+7rWVSoQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jan 28, 2014 at 06:56:25AM -0800, Luiz Augusto von Dentz wrote:
> Hi Andrei,
> 
> On Tue, Jan 28, 2014 at 4:34 AM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > There is currently inconsistence in the avctp code with
> > AVC_HEADER_LENGTH defined in avctp.h but AVCTP_HEADER_LENGTH defined in
> > avctp.c. The patch moves structure definitions to the header in
> > consistent way.
> 
> I wonder why you did not do the opposite, move AVC_HEADER_LENGTH into
> avctp.c since the AVC packet control is all done inside avctp.c it
> should probably not be exposed.

I do actually think that avctp.c is wrong place to deal with AVC since
AVCTP shouldn't handle it but anyway I will move it there.

Best regards 
Andrei Emeltchenko 
