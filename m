Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414768114-3775-8-git-send-email-gowtham.ab@samsung.com>
References: <1414768114-3775-1-git-send-email-gowtham.ab@samsung.com>
	<1414768114-3775-8-git-send-email-gowtham.ab@samsung.com>
Date: Mon, 3 Nov 2014 11:04:33 +0200
Message-ID: <CABBYNZJOur6QU0rzFQN8qWXC-T0iEBDQ7La9rOdrpb-c0Sz5Vw@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] monitor/rfcomm: Add rfcomm file in Android.mk
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Oct 31, 2014 at 5:08 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> ---
>  android/Android.mk | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/android/Android.mk b/android/Android.mk
> index aefe41c..eebd863 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -289,6 +289,7 @@ LOCAL_SRC_FILES := \
>         bluez/monitor/packet.c \
>         bluez/monitor/l2cap.c \
>         bluez/monitor/avctp.c \
> +       bluez/monitor/rfcomm.c \
>         bluez/monitor/uuid.c \
>         bluez/monitor/sdp.c \
>         bluez/monitor/vendor.c \
> --
> 1.9.1

Usually we try very hard to avoid breaking the build even within the
same patch-set, so if possible please squash this change.


-- 
Luiz Augusto von Dentz
