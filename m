Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1390912485-16357-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390912485-16357-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 28 Jan 2014 06:56:25 -0800
Message-ID: <CABBYNZKKvD2=OGYoTdbH7=buaZMpaDN51aWd4aRrFR+7rWVSoQ@mail.gmail.com>
Subject: Re: [RFC] android/avctp: Move struct definitions to header
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Jan 28, 2014 at 4:34 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> There is currently inconsistence in the avctp code with
> AVC_HEADER_LENGTH defined in avctp.h but AVCTP_HEADER_LENGTH defined in
> avctp.c. The patch moves structure definitions to the header in
> consistent way.

I wonder why you did not do the opposite, move AVC_HEADER_LENGTH into
avctp.c since the AVC packet control is all done inside avctp.c it
should probably not be exposed.
