Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1338817828-12166-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338817828-12166-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 5 Jun 2012 00:13:35 +0300
Message-ID: <CABBYNZJ85cdN8J7DWtDcs9Dc0mBnjAd4u_noRe0fXmJDaQF1vA@mail.gmail.com>
Subject: Re: [PATCH obexd v2 00/15] client: Return transfer object in D-Bus API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Jun 4, 2012 at 4:50 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> This third version is very similar to the previous one but now python scripts make use of tabs instead of whitespaces.
>
> From original cover letter:
>
> This patch series proposes changes in the D-Bus API so that all transfer-initiating methods will return the transfer path. This has several benefits including the possibility to cancel the transfer.
>
> Along with the transfer path, the properties corresponding to this transfer will also be returned, for both performance reasons (avoid a call to GetProperties) and also race conditions (transfer might have been destroyed by the time the client calls to GetProperties).
>
> In addition, temporary files can now easily be used by the clients, by passing empty strings in the D-Bus API. The actual name of the created temporary file will be included in the transfer properties.
>
> Mikel Astiz (15):
>  client: Make transfer filename optional
>  client-doc: ObjectPush sessions return transfers
>  client: Support empty filename in obc_transfer_get
>  client: Expose D-Bus data in internal transfer API
>  client: ObjectPush sessions return transfers
>  client-doc: FileTransfer sessions return transfers
>  client: FileTransfer sessions return transfers
>  client-doc: Synchronization sessions return transfers
>  client: Synchronization sessions return transfers
>  client-doc: PhonebookAccess sessions return transfers
>  client: PhonebookAccess sessions return transfers
>  client-test: ftp-client uses new API
>  client-test: pbap-client uses new API
>  client-test: Add opp-client
>  client: Update copyright statement
>
>  client/ftp.c            |   46 +++------
>  client/opp.c            |   71 +++-----------
>  client/pbap.c           |  161 ++++++++++++++----------------
>  client/session.c        |    1 +
>  client/session.h        |    1 +
>  client/sync.c           |   92 ++++++-----------
>  client/transfer.c       |   92 ++++++++++++++---
>  client/transfer.h       |    4 +
>  doc/client-api.txt      |  116 ++++++++++++++++++----
>  test/ftp-client         |  259 ++++++++++++++++++++++++++---------------------
>  test/opp-client         |   97 ++++++++++++++++++
>  test/pbap-client        |  188 +++++++++++++++++++++++++++-------
>  test/pull-business-card |   40 -------
>  test/send-files         |   23 ----
>  14 files changed, 706 insertions(+), 485 deletions(-)
>  create mode 100755 test/opp-client
>  delete mode 100755 test/pull-business-card
>  delete mode 100755 test/send-files
>
> --
> 1.7.7.6

All patches has been applied, I fixed the code style of the script
myself and there was also an issue with make distcheck as some scripts
were removed but you forgot to remove them form Makefile.am.


-- 
Luiz Augusto von Dentz
