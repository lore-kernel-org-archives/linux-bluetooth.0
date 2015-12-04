Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1449066349-2852-1-git-send-email-gowtham.ab@samsung.com>
References: <1449066349-2852-1-git-send-email-gowtham.ab@samsung.com>
Date: Fri, 4 Dec 2015 14:31:51 +0200
Message-ID: <CABBYNZKP4xAQ9Y_mWdkQJEJG6CyxdKKLh2C0ANqn_oY4bVb5-A@mail.gmail.com>
Subject: Re: [PATCH] test: Fix ftp-client not printing progress
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Wed, Dec 2, 2015 at 4:25 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> This patch fixes the keyError while printing transfer progress.
> ---
>  test/ftp-client | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/test/ftp-client b/test/ftp-client
> index 78c32b3..4540602 100755
> --- a/test/ftp-client
> +++ b/test/ftp-client
> @@ -77,16 +77,18 @@ class FtpClient:
>                 if path != self.transfer_path:
>                         return
>
> -               if properties['Status'] == 'complete' or \
> -                               properties['Status'] == 'error':
> +               if "Status" in properties and \
> +                               (properties['Status'] == 'complete' or \
> +                               properties['Status'] == 'error'):
>                         if self.verbose:
>                                 print("Transfer %s" % properties['Status'])
>                         mainloop.quit()
>                         return
>
> -               if properties["Transferred"] == None:
> +               if "Transferred" not in properties:
>                         return
>
> +               value = properties["Transferred"]
>                 speed = (value - self.transferred) / 1000
>                 print("Transfer progress %d/%d at %d kBps" % (value,
>                                                         self.transfer_size,
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
