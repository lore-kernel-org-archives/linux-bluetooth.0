Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Dec 2012 12:24:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] audio: Fix interface names
Message-ID: <20121206102400.GA2342@x220.Elisa>
References: <1354749489-25442-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354749489-25442-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, Dec 05, 2012, Vinicius Costa Gomes wrote:
> In some places, the old names of the interfaces were still being used.
> So we update them to use the new names.
> ---
> Hi,
> 
> This patch is more to confirm the intended names, in this patch I am
> supposing that the correct names are 'org.bluez.MediaEndpoint1' and
> 'org.bluez.MediaPlayer1'. As I think that the double numbering would
> cause even more confusion.
> 
> Cheers,
> 
>  src/bluetooth.conf   |  4 ++--
>  test/simple-endpoint | 10 +++++-----
>  test/simple-player   | 10 +++++-----
>  3 files changed, 12 insertions(+), 12 deletions(-)

Applied. Thanks.

Johan
