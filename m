Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Sep 2011 17:17:24 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 3/7] Bluetooth: EFS: add disable_flowspec kernel param
Message-ID: <20110913201724.GE16856@joana>
References: <1314875256-6904-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1314875256-6904-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314875256-6904-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-09-01 14:07:32 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Make extended flowspec option kernel parameter. Disabled by default.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index be30c32..4167cb0 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -57,6 +57,7 @@
>  #include <net/bluetooth/smp.h>
>  
>  int disable_ertm;
> +int disable_flowspec = 1;

I'm not sure if we need one parameter for each feature, I think a
disable_hs (for high speed) could work. This is only to keep the code upstream
while it is not qualified.

	Gustavo
