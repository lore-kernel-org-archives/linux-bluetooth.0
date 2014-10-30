Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412898652-12281-5-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412898652-12281-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1412898652-12281-5-git-send-email-lukasz.rymanowski@tieto.com>
Date: Thu, 30 Oct 2014 10:43:47 +0100
Message-ID: <CABD6X-J29UQGOB792V2XC5by2RyQCw2ym3uAu+ot5m7od8KHzg@mail.gmail.com>
Subject: Re: [PATCH 4/8] shared/hfp: Add handling +CME ERROR to parser
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On 10 October 2014 01:50, Lukasz Rymanowski <lukasz.rymanowski@tieto.com> wrote:
> ---
>  src/shared/hfp.c | 22 +++++++++++++++++++---
>  src/shared/hfp.h |  2 ++
>  unit/test-hfp.c  |  2 ++
>  3 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/src/shared/hfp.c b/src/shared/hfp.c
> index 87e4017..6f2d28a 100644
> --- a/src/shared/hfp.c
> +++ b/src/shared/hfp.c
> @@ -903,7 +903,9 @@ static void hf_skip_whitespace(struct hfp_context *context)
>                 context->offset++;
>  }
>
> -static bool is_response(const char *prefix, enum hfp_result *result)
> +static bool is_response(const char *prefix, enum hfp_result *result,
> +                                               enum hfp_error *cme_err,
> +                                               struct hfp_context *context)
>  {
>         if (strcmp(prefix, "OK") == 0) {
>                 *result = HFP_RESULT_OK;
> @@ -940,6 +942,19 @@ static bool is_response(const char *prefix, enum hfp_result *result)
>                 return true;
>         }
>
> +       if (strcmp(prefix, "+CME ERROR") == 0) {
> +               uint32_t val;
> +
> +               *result = HFP_RESULT_CME_ERROR;
> +
> +               if (hfp_context_get_number(context, &val))
> +                       *cme_err = val;

maybe check if val <= HFP_ERROR_NETWORK_NOT_ALLOWED? otherwise we can pass
value bigger that enum. And maybe we could call resp_cb with context
intead of cme_err which is valid just in case of
CME ERROR response? What you think?
> +               else
> +                       *cme_err = HFP_ERROR_AG_FAILURE;
> +
> +               return true;
> +       }
> +
>         return false;
>  }
>
> @@ -972,6 +987,7 @@ static void hf_call_prefix_handler(struct hfp_hf *hfp, const char *data)
>         const char *separators = ";:\0";
>         struct hfp_context context;
>         enum hfp_result result;
> +       enum hfp_error cme_err = 0;

shouldn't we set set cme_err = HFP_RESULT_OK?

>         char lookup_prefix[18];
>         uint8_t pref_len = 0;
>         const char *prefix;
> @@ -997,14 +1013,14 @@ static void hf_call_prefix_handler(struct hfp_hf *hfp, const char *data)
>         lookup_prefix[pref_len] = '\0';
>         context.offset += pref_len + 1;
>
> -       if (is_response(lookup_prefix, &result)) {
> +       if (is_response(lookup_prefix, &result, &cme_err, &context)) {
>                 struct cmd_response *cmd;
>
>                 cmd = queue_peek_head(hfp->cmd_queue);
>                 if (!cmd)
>                         return;
>
> -               cmd->resp_cb(cmd->prefix, result, cmd->user_data);
> +               cmd->resp_cb(cmd->prefix, result, cme_err, cmd->user_data);
>
>                 queue_remove(hfp->cmd_queue, cmd);
>                 destroy_cmd_response(cmd);
> diff --git a/src/shared/hfp.h b/src/shared/hfp.h
> index 27c26a2..e4a70e0 100644
> --- a/src/shared/hfp.h
> +++ b/src/shared/hfp.h
> @@ -34,6 +34,7 @@ enum hfp_result {
>         HFP_RESULT_NO_ANSWER    = 8,
>         HFP_RESULT_DELAYED      = 9,
>         HFP_RESULT_BLACKLISTED  = 10,
> +       HFP_RESULT_CME_ERROR    = 11,
>  };
>
>  enum hfp_error {
> @@ -86,6 +87,7 @@ typedef void (*hfp_disconnect_func_t)(void *user_data);
>
>  typedef void (*hfp_response_func_t)(const char *prefix,
>                                                         enum hfp_result result,
> +                                                       enum hfp_error cme_err,
>                                                         void *user_data);
>
>  struct hfp_gw;
> diff --git a/unit/test-hfp.c b/unit/test-hfp.c
> index c597fd0..bc05086 100644
> --- a/unit/test-hfp.c
> +++ b/unit/test-hfp.c
> @@ -476,6 +476,7 @@ static void hf_unsolicited_resp_cb(struct hfp_context *context,
>  }
>
>  static void hf_response_with_data(const char *prefix, enum hfp_result res,
> +                                                       enum hfp_error cme_err,
>                                                         void *user_data)
>  {
>         struct context *context = user_data;
> @@ -487,6 +488,7 @@ static void hf_response_with_data(const char *prefix, enum hfp_result res,
>  }
>
>  static void hf_brsf_response_cb(const char *prefix, enum hfp_result res,
> +                                                       enum hfp_error cme_err,
>                                                         void *user_data)
>  {
>         struct context *context = user_data;
> --
> 1.8.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

BR
Marcin
