Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Feb 2014 15:12:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 0/6] RFCOMM data transfer support in bthost
Message-ID: <20140219131226.GA7630@x220.p-661hnu-f1>
References: <1392709855-32600-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392709855-32600-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Tue, Feb 18, 2014, Marcin Kraglak wrote:
> v2:
>  - Added rfcomm prefixes in API functions and internal structs
>  - Values returned by read() and write stored in local variables
> for clarity
>  - Few coding style fixes
> 
> Marcin Kraglak (6):
>   emulator/bthost: Add api to handle RFCOMM data on bthost
>   tools/rfcomm-tester: Add RFCOMM client write test case
>   tools/rfcomm-tester: Add RFCOMM server write test case
>   emulator/bthost: Add function to send RFCOMM UIH frames from bthost
>   tools/rfcomm-tester: Add RFCOMM client read test case
>   tools/rfcomm-tester: Add RFCOMM server read test case
> 
>  emulator/bthost.c     | 167 ++++++++++++++++++++++++++++++++++++++-
>  emulator/bthost.h     |  13 ++++
>  tools/rfcomm-tester.c | 212 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 387 insertions(+), 5 deletions(-)

All patches in this set have been applied. I also applied a couple of
extra cleanup/fix patches on top of it to avoid yet another review
round.

Johan
