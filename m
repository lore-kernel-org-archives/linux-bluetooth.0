Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Dec 2010 19:53:01 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 3/5] Bluetooth: clean up l2cap code
Message-ID: <20101201215301.GJ16125@vigoh>
References: <1291215506-11398-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1291215506-11398-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291215506-11398-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-12-01 16:58:24 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> Do not initialize static vars to zero, macros with complex values
> shall be enclosed with (), remove unneeded braces.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  include/net/bluetooth/l2cap.h |   10 +++++-----
>  net/bluetooth/l2cap.c         |    7 +++----
>  2 files changed, 8 insertions(+), 9 deletions(-)

Applied, thanks for clean up this.

-- 
Gustavo F. Padovan
http://profusion.mobi
