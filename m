Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1339620563-25161-1-git-send-email-szymon@janc.net.pl>
References: <1339620563-25161-1-git-send-email-szymon@janc.net.pl>
Date: Thu, 14 Jun 2012 14:34:56 +0300
Message-ID: <CABBYNZ+-0Q0WJB5b42f_=XTKmS5H+V-ZmyFNFqgMovGs7s+a_Q@mail.gmail.com>
Subject: Re: [PATCH obexd 1/7] phonebook-dummy: Fix use of uninitialized count variable
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon@janc.net.pl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Jun 13, 2012 at 11:49 PM, Szymon Janc <szymon@janc.net.pl> wrote:
> If opendir() call fails count would be passed to callback
> uninitialized.
> ---
>  plugins/phonebook-dummy.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/plugins/phonebook-dummy.c b/plugins/phonebook-dummy.c
> index 035ec35..6b9d040 100644
> --- a/plugins/phonebook-dummy.c
> +++ b/plugins/phonebook-dummy.c
> @@ -218,7 +218,7 @@ static gboolean read_dir(void *user_data)
>        struct dummy_data *dummy = user_data;
>        GString *buffer;
>        DIR *dp;
> -       uint16_t count, max, offset;
> +       uint16_t count = 0, max, offset;
>
>        buffer = g_string_new("");
>
> --
> 1.7.10.4

I went ahead and applied patches with exception of the one I commented.


-- 
Luiz Augusto von Dentz
