Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Dec 2010 19:52:30 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 2/5] Bluetooth: clean up rfcomm code
Message-ID: <20101201215230.GI16125@vigoh>
References: <1291215506-11398-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1291215506-11398-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291215506-11398-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-12-01 16:58:23 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> Remove extra spaces, assignments in if statement, zeroing static
> variables, extra braces. Fix includes.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  include/net/bluetooth/rfcomm.h |    4 ++--
>  net/bluetooth/rfcomm/core.c    |    8 ++++----
>  net/bluetooth/rfcomm/sock.c    |    5 +++--
>  net/bluetooth/rfcomm/tty.c     |   28 ++++++++++++++++------------
>  4 files changed, 25 insertions(+), 20 deletions(-)

Applied, thanks for clean up this.

-- 
Gustavo F. Padovan
http://profusion.mobi
