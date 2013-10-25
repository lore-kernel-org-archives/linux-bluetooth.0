Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1382618807-14605-2-git-send-email-jerzy.kasenberg@tieto.com>
References: <1382618807-14605-1-git-send-email-jerzy.kasenberg@tieto.com>
	<1382618807-14605-2-git-send-email-jerzy.kasenberg@tieto.com>
Date: Fri, 25 Oct 2013 13:36:44 +0300
Message-ID: <CABBYNZ+9Qn2sH46HiOZNQix__VoPuWg__2aPm1+eO9NuyvP3eA@mail.gmail.com>
Subject: Re: [PATCH 1/2] android/client: Add source command to haltest
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Thu, Oct 24, 2013 at 3:46 PM, Jerzy Kasenberg
<jerzy.kasenberg@tieto.com> wrote:
> New command allows to read script file into tool and
> execute its contents as if it was typed.
> ---
>  android/client/haltest.c |   50 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/android/client/haltest.c b/android/client/haltest.c
> index 189af0b..efed16e 100644
> --- a/android/client/haltest.c
> +++ b/android/client/haltest.c
> @@ -157,11 +157,47 @@ static void quit_p(int argc, const char **argv)
>         exit(0);
>  }
>
> +static int fd_stack[10];
> +static int fd_stack_pointer = 0;
> +
> +static void stdin_handler(struct pollfd *pollfd);
> +
> +static void process_file(const char *name)
> +{
> +       int fd = open(name, O_RDONLY);
> +
> +       if (fd == -1) {
> +               haltest_error("Can't open file: %s for reading\n", name);
> +               return;
> +       }

Usually for int returns we check errors with < 0, so please change the
code above to follow this practice.



-- 
Luiz Augusto von Dentz
