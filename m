Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Dec 2010 19:53:58 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 4/5] Bluetooth: clean up hci code
Message-ID: <20101201215358.GK16125@vigoh>
References: <1291215506-11398-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1291215506-11398-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291215506-11398-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-12-01 16:58:25 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> Do not use assignment in IF condition, remove extra spaces,
> fixing typos, simplify code.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  include/net/bluetooth/hci.h      |    4 +-
>  include/net/bluetooth/hci_core.h |   14 ++++----
>  net/bluetooth/hci_conn.c         |   23 ++++++++----
>  net/bluetooth/hci_core.c         |   66 ++++++++++++++++++++++++--------------
>  net/bluetooth/hci_event.c        |    8 +++--
>  net/bluetooth/hci_sock.c         |   17 ++++++---
>  6 files changed, 82 insertions(+), 50 deletions(-)

Applied.

-- 
Gustavo F. Padovan
http://profusion.mobi
