Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <001a01d08bda$91503ab0$b3f0b010$@samsung.com>
References: <001a01d08bda$91503ab0$b3f0b010$@samsung.com>
Date: Mon, 11 May 2015 14:36:23 +0300
Message-ID: <CABBYNZJ_SJowxX47YGWAvHa5D1a2SwDD5cE90UE6=fHLTwTsTQ@mail.gmail.com>
Subject: Re: Query regarding bneptest tool
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Bhusan Panda <bharat.panda@samsung.com>,
	cpgs@samsung.com,
	Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Mon, May 11, 2015 at 2:06 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Hi All,
>
> I am testing BlueZ bnep test tool (tools/bneptest) using PTS 6.1.0.
> The BNEP client test cases are not passing in BT_IO_SEC_MEDIUM security
> level.
> My PTS PICS and PIXIT are same as android/pixit-bnep.txt,
> android/pics-bnep.txt.
> Whereas when the security level is BT_IO_SEC_LOW, it is passing.
> If it is a valid fix, then I will send a patch for the same.
> This is tested in Linux, not sure about android.

It might be related to pairing then, do you have any agent registered
in the system? Check the HCI logs with btmon, it should tell us what
is happening.

>
> diff --git a/tools/bneptest.c b/tools/bneptest.c
> index 98ee9b1..fccecd2 100644
> --- a/tools/bneptest.c
> +++ b/tools/bneptest.c
> @@ -477,7 +477,7 @@ static int bnep_client_connect(void)
>                                         BT_IO_OPT_SOURCE_BDADDR, &src_addr,
>                                         BT_IO_OPT_DEST_BDADDR, &dst_addr,
>                                         BT_IO_OPT_PSM, BNEP_PSM,
> -                                       BT_IO_OPT_SEC_LEVEL,
> BT_IO_SEC_MEDIUM,
> +                                       BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
>                                         BT_IO_OPT_OMTU, BNEP_MTU,
>                                         BT_IO_OPT_IMTU, BNEP_MTU,
>                                         BT_IO_OPT_INVALID);
>
>
> Regards,
> Gowtham Anandha Babu
>



-- 
Luiz Augusto von Dentz
