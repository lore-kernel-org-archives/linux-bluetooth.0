Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22A2C55179
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 604A92076A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfCETHz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgJ2RlI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgJ2RlI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 13:41:08 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD2BC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 10:41:08 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id c72so3847226oig.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 10:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=UsVh7K+BpLVp4NN66sWQOu/PJYLb7Plx0UqzBF2UmlI=;
        b=jfCETHz4mOEgOEWwTJDWI5gAn8DIDw/bNzSmDk6bVrTMlyr2NrLERM6nFYG2xps/o0
         SFRmtJ7mBHAIQ7ceMbWXAyZ3sxcFpB8EmZ+vOdwvxYqFjcKfiqhnnPZswJfPMSkew4rk
         Xak8PMOvqGm73F7Ivvz87VxLndaX3qYFMljnWOcrNzScwOQErebuKBq7ojm6bVtvIAyw
         Lykd2o4DVpQpebU3ThOdYUqsHX15/NMoGfteh8+Y8zNQKZa2gdTiyP+MhjXDaIuThqN6
         5Nfh/Op/N1i5Ifytm+RNQrYEgFd14MBKOaK8/vcxiw8G12zcQ7rCAqn6P+inYpXSGUDp
         Ejhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=UsVh7K+BpLVp4NN66sWQOu/PJYLb7Plx0UqzBF2UmlI=;
        b=OLcHpy+xss4QqAvjcXZj8LN4AiVv1Oqt0MrpppJRGTy08OLClkPGEXJP4lLOedEVtA
         dQjBQVfBJaz7oP+6TA0oPr1LW2nrUwtLldKa8V8wIaXzuFz0gz98bi3NoQtHk+F4K3tr
         jGvyxP4vf6dMJYMEPy049OEVpnNx/ZRarxXKpliPhx3VPwcsXfZKQ06L5KnJhxrjDndA
         p0Bz3ltaQjT8UwSPLyH0j6E5aZ3tBUD3zbxpVL8XFGYkD5F6agXaWvqGzmdjVnEWQ+/o
         DPDw0NwUDNn26ilc4ErJRSrBhYqYbe+6Ujx9IEtiyyj/3bAExVyXaRdWn65N9Ioy4Wxt
         wE+A==
X-Gm-Message-State: AOAM531eiNwCPeXavNne1L9sY7NzSyUALD3eUVjTYYPKEnugerJY7m/O
        KKM2MIwNZDzTcsF7aiEPgpr42HbWSJmXh6b3af67tW9F90Y=
X-Google-Smtp-Source: ABdhPJzhMXhds2lor3mlgle/xqT+JJ9vIXkpTuUBZav6bLQiCo8pYj9ZMNHPWcTVuuwhJHOndxG2EJshxgMcMSAxvxU=
X-Received: by 2002:aca:cdd8:: with SMTP id d207mr236064oig.64.1603993266893;
 Thu, 29 Oct 2020 10:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201028215824.608794-1-luiz.dentz@gmail.com>
In-Reply-To: <20201028215824.608794-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 29 Oct 2020 10:40:56 -0700
Message-ID: <CABBYNZL7F=S-_m7RXiJ=9z67bk8h+PheFY+hp-=Ped8pavAvAw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] mgmt: Add support of mgmt TLV API
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Oct 28, 2020 at 2:58 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Howard Chung <howardchung@google.com>
>
> This adds API to send multiple TLVs to kernel, it is useful for
> mgmt set system config command.
> ---
>  src/shared/mgmt.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/mgmt.h |  9 +++++
>  2 files changed, 103 insertions(+)
>
> diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
> index b327b4088..9ea9974f5 100644
> --- a/src/shared/mgmt.c
> +++ b/src/shared/mgmt.c
> @@ -68,6 +68,11 @@ struct mgmt_notify {
>         void *user_data;
>  };
>
> +struct mgmt_tlv_list {
> +       struct queue *tlv_queue;
> +       uint16_t size;
> +};
> +
>  static void destroy_request(void *data)
>  {
>         struct mgmt_request *request = data;
> @@ -558,6 +563,95 @@ static struct mgmt_request *create_request(uint16_t opcode, uint16_t index,
>         return request;
>  }
>
> +struct mgmt_tlv_list *mgmt_tlv_list_new(void)
> +{
> +       struct mgmt_tlv_list *tlv_list = new0(struct mgmt_tlv_list, 1);
> +
> +       tlv_list->tlv_queue = queue_new();
> +       tlv_list->size = 0;
> +
> +       return tlv_list;
> +}
> +
> +static struct mgmt_tlv *mgmt_tlv_new(uint16_t type, uint8_t length,
> +                                                               void *value)
> +{
> +       struct mgmt_tlv *entry = malloc(sizeof(*entry) + length);
> +
> +       if (!entry)
> +               return NULL;
> +
> +       entry->type = htobs(type);
> +       entry->length = length;
> +       memcpy(entry->value, value, length);
> +
> +       return entry;
> +}
> +
> +static void mgmt_tlv_free(struct mgmt_tlv *entry)
> +{
> +       free(entry);
> +}
> +
> +void mgmt_tlv_list_free(struct mgmt_tlv_list *tlv_list)
> +{
> +       queue_destroy(tlv_list->tlv_queue, NULL);
> +       free(tlv_list);
> +}
> +
> +bool mgmt_tlv_add(struct mgmt_tlv_list *tlv_list, uint16_t type, uint8_t length,
> +                                                               void *value)
> +{
> +       struct mgmt_tlv *entry = mgmt_tlv_new(type, length, value);
> +
> +       if (!entry)
> +               return false;
> +
> +       if (!queue_push_tail(tlv_list->tlv_queue, entry)) {
> +               mgmt_tlv_free(entry);
> +               return false;
> +       }
> +
> +       tlv_list->size += sizeof(*entry) + entry->length;
> +       return true;
> +}
> +
> +static void mgmt_tlv_to_buf(void *data, void *user_data)
> +{
> +       struct mgmt_tlv *entry = data;
> +       uint8_t **buf_ptr = user_data;
> +       size_t entry_size = sizeof(*entry) + entry->length;
> +
> +       memcpy(*buf_ptr, entry, entry_size);
> +       *buf_ptr += entry_size;
> +}
> +
> +unsigned int mgmt_send_tlv(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
> +                               struct mgmt_tlv_list *tlv_list,
> +                               mgmt_request_func_t callback,
> +                               void *user_data, mgmt_destroy_func_t destroy)
> +{
> +       uint8_t *buf, *buf_ptr;
> +       unsigned int ret;
> +
> +       if (!tlv_list)
> +               return 0;
> +
> +       buf = malloc(tlv_list->size);
> +
> +       if (!buf)
> +               return 0;
> +
> +       buf_ptr = buf;
> +
> +       queue_foreach(tlv_list->tlv_queue, mgmt_tlv_to_buf, &buf_ptr);
> +
> +       ret = mgmt_send(mgmt, opcode, index, tlv_list->size, (void *)buf,
> +                                               callback, user_data, destroy);
> +       free(buf);
> +       return ret;
> +}
> +
>  unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
>                                 uint16_t length, const void *param,
>                                 mgmt_request_func_t callback,
> diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
> index 6608faa7e..74b8befd8 100644
> --- a/src/shared/mgmt.h
> +++ b/src/shared/mgmt.h
> @@ -16,6 +16,7 @@
>  typedef void (*mgmt_destroy_func_t)(void *user_data);
>
>  struct mgmt;
> +struct mgmt_tlv_list;
>
>  struct mgmt *mgmt_new(int fd);
>  struct mgmt *mgmt_new_default(void);
> @@ -33,6 +34,14 @@ bool mgmt_set_close_on_unref(struct mgmt *mgmt, bool do_close);
>  typedef void (*mgmt_request_func_t)(uint8_t status, uint16_t length,
>                                         const void *param, void *user_data);
>
> +struct mgmt_tlv_list *mgmt_tlv_list_new(void);
> +void mgmt_tlv_list_free(struct mgmt_tlv_list *tlv_list);
> +bool mgmt_tlv_add(struct mgmt_tlv_list *tlv_list, uint16_t type, uint8_t length,
> +                                                               void *value);
> +unsigned int mgmt_send_tlv(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
> +                               struct mgmt_tlv_list *tlv_list,
> +                               mgmt_request_func_t callback,
> +                               void *user_data, mgmt_destroy_func_t destroy);
>  unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
>                                 uint16_t length, const void *param,
>                                 mgmt_request_func_t callback,
> --
> 2.26.2
>

Pushed.

-- 
Luiz Augusto von Dentz
