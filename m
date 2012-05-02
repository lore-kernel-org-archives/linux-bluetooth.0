Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335783741-7398-1-git-send-email-jaganath.k@samsung.com>
References: <1335783741-7398-1-git-send-email-jaganath.k@samsung.com>
Date: Wed, 2 May 2012 15:32:04 +0300
Message-ID: <CABBYNZ+DeySnQQvmgu9i9YX8_KHw50vnQigqiJnSetyLFHMjtA@mail.gmail.com>
Subject: Re: [PATCH obexd 1/3] gobex: Add callback and userdata parameter to g_obex_cancel_transfer()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Mon, Apr 30, 2012 at 2:02 PM, Jaganath Kanakkassery
<jaganath.k@samsung.com> wrote:
> +free:
> +       transfer_free(transfer);
> +       return ret;
>  }

Just be completely save here name the label something else than free
(e.g. done).

-- 
Luiz Augusto von Dentz
