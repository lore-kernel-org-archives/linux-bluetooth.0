Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHFy418JQ=TW2ZRsSPFe5BFidgnq-kBiempYv=9TviX8uPN-VQ@mail.gmail.com>
References: <1456925319-16594-1-git-send-email-josephsih@chromium.org>
	<CABBYNZ+jSLy_YaK99Ov_E2M68yU0xZUxp9t+0cnUFp1sDEaKDA@mail.gmail.com>
	<CABBYNZ+eLxZXkMLuupfBGDthDmuLwKr5Z0tP+sXrmxnL6JTdUg@mail.gmail.com>
	<CAHFy41-4o+01KSTB1G-FKRLu2Ym9-QBtqhEeWPV0EsR1bWLtvw@mail.gmail.com>
	<CABBYNZJuS3zHhqf=nr=Zqb6HO=3eaaDUZH=855HsLGL62=JBbQ@mail.gmail.com>
	<CAHFy418JQ=TW2ZRsSPFe5BFidgnq-kBiempYv=9TviX8uPN-VQ@mail.gmail.com>
Date: Thu, 3 Mar 2016 13:55:28 +0200
Message-ID: <CABBYNZ+w04trQ8fR5Ey6ZejdBvZk1fDM-Lctjdt0Bjoq3CTtNQ@mail.gmail.com>
Subject: Re: [PATCH] shared/att: change security as needed
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Joseph Hwang <josephsih@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joseph,

On Thu, Mar 3, 2016 at 12:45 PM, Joseph Hwang <josephsih@google.com> wrote:
> Hi Luiz:
>
>   I try to apply your one-liner locally.
>
> +       bt_att_set_security(dev->att, BT_ATT_SECURITY_AUTO);
>
>   However, bt_att_set_security() failed  in device_attach_att() in
> src/device.c. It cannot set BT_ATT_SECURITY_AUTO successfully here.
>
>   But bt_att_set_security() would succeed in change_security() in
> src/shared/att.c as in my patch.

No top posting in the mailing list, respond inline. Btw, Ive sent a
new patch about this.

-- 
Luiz Augusto von Dentz
