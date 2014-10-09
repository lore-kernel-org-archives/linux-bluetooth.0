Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412849812-6498-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1412849812-6498-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 9 Oct 2014 12:56:19 +0200
Message-ID: <CAMv5Gbd8kj0BbgSKL7BkComzpB4qLEXrNX1dCSb5oviHGoH1dA@mail.gmail.com>
Subject: Re: [PATCH] android/tester: Fix possible NULL pointer passing to function
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On 9 October 2014 12:16, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Silence code analyzers and follow strict C standard where passing NULL
> pointer results in undefined behaviour.
> ---
>  android/tester-main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/android/tester-main.c b/android/tester-main.c
> index 30e1c59..ee3444f 100644
> --- a/android/tester-main.c
> +++ b/android/tester-main.c
> @@ -801,12 +801,12 @@ static bool match_data(struct step *step)
>                         return false;
>                 }
>
> -       if (exp->store_srvc_handle)
> +       if (exp->store_srvc_handle && step->callback_result.srvc_handle)
>                 memcpy(exp->store_srvc_handle,
>                                         step->callback_result.srvc_handle,
>                                         sizeof(*exp->store_srvc_handle));
>
> -       if (exp->store_char_handle)
> +       if (exp->store_char_handle && step->callback_result.char_handle)
>                 memcpy(exp->store_char_handle,
>                                         step->callback_result.char_handle,
>                                         sizeof(*exp->store_char_handle));
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


I think it can cause test cause bad behavior by not setting variable
if test step is obliged to do it.
Test cases are defined in this way that one step e.g. 'A' stores
service handle and step 'B' uses this handle.
If value is not set it cause wrong test case behavior in next steps.
This check of exp (if store of srvc handle is mandatory for this step)
and step srvc handle (received in callback) only mask problem
 with storing attribute handle value - in result it shows only that
memory was not duplicated well while copying data from incoming
callback handler.
Summarizing - we consciously force writing this srvc, char handle
value, if something is wrong - that means something with test
case is wrong and it should be fixed.

Best way to handle it - static analyzer and this logic safe is to do
it in this way:
  "if (exp->store_srvc_handle) {
              if (!step->callback_result.srvc_handle) {
                         tester_debug("wrong srvc handle received in callback");
                         return false;
              } else {
                         memcpy(exp->store_char_handle,
step->callback_result.char_handle,

           sizeof(*exp->store_char_handle));
              }
   }

Best Regards,
Grzegorz
