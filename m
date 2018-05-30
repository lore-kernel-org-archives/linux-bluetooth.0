Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180507223524.32070-1-brian.gix@intel.com>
References: <20180507223524.32070-1-brian.gix@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 30 May 2018 10:23:34 +0300
Message-ID: <CABBYNZLkMnL=3fMOFajwoe6CH=Ptm1RLEiTWF3Pj35ekTiiUnQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/1] ECC Cleanup
To: Brian Gix <brian.gix@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Tue, May 8, 2018 at 1:35 AM, Brian Gix <brian.gix@intel.com> wrote:
> Revert ecc_make_key to original implementation, and cleanup API
>
> Brian Gix (1):
>   shared/ecc: Make ecc_make_key() a stand alone API
>
>  src/shared/ecc.c | 25 +++++++++++++++++--------
>  src/shared/ecc.h |  4 +++-
>  2 files changed, 20 insertions(+), 9 deletions(-)
>
> --
> 2.14.3

Applied, thanks.



-- 
Luiz Augusto von Dentz
