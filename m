Return-Path: <SRS0=B7Pc=3G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE10C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 17:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E68E2082F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 17:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DuNOY5Db"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgAQR6v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 12:58:51 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40357 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgAQR6u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 12:58:50 -0500
Received: by mail-lf1-f67.google.com with SMTP id i23so18995164lfo.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2020 09:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vb0zeax0NRtIgp/x6xlSUOEcv3PdFWXSf0Lvmt8COo=;
        b=DuNOY5DbTKXsi5/V2CMY9I4e1qXJdNaCPC8ZHVe7uPoWJq98LFxzVIFkV+5gAvId9g
         BeVOzQgpSoptVmMkZka0CyqW2asQVS/pIdy4IcoTKxFnykIiYmAKpBlvylS84ZjKMIWu
         Nps/Ck7IzhbcvI23JzeEuD6WJu8di/ku3mxeSnE3+qs3eqLHZfH45LXcyJ5jUOsIK4rn
         6R096rbEap3TudlBep4cPlEI1niRK6CBAtv+vzGTBtx6j3l5JWC69DN9MiNv/5DfvUSw
         vIm22lj5DFxIh8/NlIZHnah8nCotXqy/lmvSrA8KfpBhst1FhQKBc6z8vXhT4fmDmjEF
         ZzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vb0zeax0NRtIgp/x6xlSUOEcv3PdFWXSf0Lvmt8COo=;
        b=m55/Ih0CMRhQ08dAjzoNaVrszOkOAjDQHsDuXb5tQEDdDeFv4lPaS3ofGmeQE5Ac6m
         rVM4TKjdvj8OxJ3MaZLeBrYsH414czXXtCmSOoahdJkn3kOeyCG3qLthX6kzFvWYAcQR
         NriHh41r75s+p7jgUdiAfoWf3wvG0s1f8Gx0e1QbJVarb+K8iz6SbcM7CAa5yK8RX9qN
         AsbWhW3xLA3ZLF2TcjIeHf55VQBCWPyo1AkeMGhq0RwsYf6CLOWF3ALyflOkJCWy+YNo
         c9eXgWHJnUgWoPuJ2eACYwiW9F60Pp5h71yGKNtLUA1KaYRYaUM2SiZq7mN+/OxOAFVM
         9heg==
X-Gm-Message-State: APjAAAV1Y6/85RLOl4dDv8pA6H9/hi1SPnLULSAENzp3XfQVXBYDqbI4
        DiCQQF/r81AinrH/OtzQmIjwBUBWdzShgUlUHuIhxw==
X-Google-Smtp-Source: APXvYqxptLKgeQtxIdrjyoV6EsB6uv1dn0CQaQFIO3IGr6TB6a3b/5voM9Sxq71xklt0eOm5Y21hJdm6KBjWPEtc9ag=
X-Received: by 2002:a19:7401:: with SMTP id v1mr6249520lfe.129.1579283927362;
 Fri, 17 Jan 2020 09:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20200117034318.51409-1-alainm@chromium.org> <4AC68A7A-5F6F-48D1-8A5D-76718FAA200D@holtmann.org>
In-Reply-To: <4AC68A7A-5F6F-48D1-8A5D-76718FAA200D@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 17 Jan 2020 09:58:36 -0800
Message-ID: <CALWDO_XKnTHNREacM=HTwcXuObMd9RPvbNAASydn6fjbOm1NBw@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: Refactoring mgmt cmd op_code structure
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

I was dealing with a chicken and the egg problem, I opted for
consistency over doing a one off for the read_command function which
needs the command list and also needs to be part of the command list.

Would you prefer the one off forward declaration rather than the full
list?  I'm happy to make the change if that is your preference.

Note that the new structure is important to allow discontinuity in the
op_code allocations.  This allows two main benefits:

1. Easier backporting of N feature if N-1 has not been backported
without some significant twiddling of the list by inserting blanks or
reserved fields.
2. Easier integration of implementation with features that may not be
acceptable for upstream. (Say a chromium specific platform hack that
requires the definition of a new op_code to interact with a hardware
bug that is specific to chromium for example).

Suggestions are welcomed.

Thanks,
Alain

Thanks,
Alain


On Fri, Jan 17, 2020 at 9:11 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > This change refactors the way op-codes are managed in the kernel to
> > facilitate easier cherry-picking  of features on downlevel kernels
> > without incuring significant merge conflicts and op_code collisions.
> >
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> > include/net/bluetooth/hci_core.h |   1 +
> > net/bluetooth/hci_sock.c         |  14 +-
> > net/bluetooth/mgmt.c             | 470 +++++++++++++++++++------------
> > 3 files changed, 297 insertions(+), 188 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index 89ecf0a80aa1..0cc2f7c11c3a 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1494,6 +1494,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
> > #define HCI_MGMT_UNCONFIGURED BIT(3)
> >
> > struct hci_mgmt_handler {
> > +     unsigned short op_code;
> >       int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
> >                    u16 data_len);
> >       size_t data_len;
> > diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> > index 3ae508674ef7..4e121607d644 100644
> > --- a/net/bluetooth/hci_sock.c
> > +++ b/net/bluetooth/hci_sock.c
> > @@ -1490,9 +1490,9 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
> >       void *buf;
> >       u8 *cp;
> >       struct mgmt_hdr *hdr;
> > -     u16 opcode, index, len;
> > +     u16 opcode, index, len, i;
> >       struct hci_dev *hdev = NULL;
> > -     const struct hci_mgmt_handler *handler;
> > +     const struct hci_mgmt_handler *handler = NULL;
> >       bool var_len, no_hdev;
> >       int err;
> >
> > @@ -1533,16 +1533,18 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
> >               }
> >       }
> >
> > -     if (opcode >= chan->handler_count ||
> > -         chan->handlers[opcode].func == NULL) {
> > +     for (i = 0; i < chan->handler_count; ++i) {
> > +             if (opcode == chan->handlers[i].op_code)
> > +                     handler = &chan->handlers[i];
> > +     }
> > +
> > +     if (!handler || !handler->func) {
> >               BT_DBG("Unknown op %u", opcode);
> >               err = mgmt_cmd_status(sk, index, opcode,
> >                                     MGMT_STATUS_UNKNOWN_COMMAND);
> >               goto done;
> >       }
> >
> > -     handler = &chan->handlers[opcode];
> > -
> >       if (!hci_sock_test_flag(sk, HCI_SOCK_TRUSTED) &&
> >           !(handler->flags & HCI_MGMT_UNTRUSTED)) {
> >               err = mgmt_cmd_status(sk, index, opcode,
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 0dc610faab70..7baf9a2809a8 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -40,73 +40,271 @@
> > #define MGMT_VERSION  1
> > #define MGMT_REVISION 15
> >
> > -static const u16 mgmt_commands[] = {
> > -     MGMT_OP_READ_INDEX_LIST,
> > -     MGMT_OP_READ_INFO,
> > -     MGMT_OP_SET_POWERED,
> > -     MGMT_OP_SET_DISCOVERABLE,
> > -     MGMT_OP_SET_CONNECTABLE,
> > -     MGMT_OP_SET_FAST_CONNECTABLE,
> > -     MGMT_OP_SET_BONDABLE,
> > -     MGMT_OP_SET_LINK_SECURITY,
> > -     MGMT_OP_SET_SSP,
> > -     MGMT_OP_SET_HS,
> > -     MGMT_OP_SET_LE,
> > -     MGMT_OP_SET_DEV_CLASS,
> > -     MGMT_OP_SET_LOCAL_NAME,
> > -     MGMT_OP_ADD_UUID,
> > -     MGMT_OP_REMOVE_UUID,
> > -     MGMT_OP_LOAD_LINK_KEYS,
> > -     MGMT_OP_LOAD_LONG_TERM_KEYS,
> > -     MGMT_OP_DISCONNECT,
> > -     MGMT_OP_GET_CONNECTIONS,
> > -     MGMT_OP_PIN_CODE_REPLY,
> > -     MGMT_OP_PIN_CODE_NEG_REPLY,
> > -     MGMT_OP_SET_IO_CAPABILITY,
> > -     MGMT_OP_PAIR_DEVICE,
> > -     MGMT_OP_CANCEL_PAIR_DEVICE,
> > -     MGMT_OP_UNPAIR_DEVICE,
> > -     MGMT_OP_USER_CONFIRM_REPLY,
> > -     MGMT_OP_USER_CONFIRM_NEG_REPLY,
> > -     MGMT_OP_USER_PASSKEY_REPLY,
> > -     MGMT_OP_USER_PASSKEY_NEG_REPLY,
> > -     MGMT_OP_READ_LOCAL_OOB_DATA,
> > -     MGMT_OP_ADD_REMOTE_OOB_DATA,
> > -     MGMT_OP_REMOVE_REMOTE_OOB_DATA,
> > -     MGMT_OP_START_DISCOVERY,
> > -     MGMT_OP_STOP_DISCOVERY,
> > -     MGMT_OP_CONFIRM_NAME,
> > -     MGMT_OP_BLOCK_DEVICE,
> > -     MGMT_OP_UNBLOCK_DEVICE,
> > -     MGMT_OP_SET_DEVICE_ID,
> > -     MGMT_OP_SET_ADVERTISING,
> > -     MGMT_OP_SET_BREDR,
> > -     MGMT_OP_SET_STATIC_ADDRESS,
> > -     MGMT_OP_SET_SCAN_PARAMS,
> > -     MGMT_OP_SET_SECURE_CONN,
> > -     MGMT_OP_SET_DEBUG_KEYS,
> > -     MGMT_OP_SET_PRIVACY,
> > -     MGMT_OP_LOAD_IRKS,
> > -     MGMT_OP_GET_CONN_INFO,
> > -     MGMT_OP_GET_CLOCK_INFO,
> > -     MGMT_OP_ADD_DEVICE,
> > -     MGMT_OP_REMOVE_DEVICE,
> > -     MGMT_OP_LOAD_CONN_PARAM,
> > -     MGMT_OP_READ_UNCONF_INDEX_LIST,
> > -     MGMT_OP_READ_CONFIG_INFO,
> > -     MGMT_OP_SET_EXTERNAL_CONFIG,
> > -     MGMT_OP_SET_PUBLIC_ADDRESS,
> > -     MGMT_OP_START_SERVICE_DISCOVERY,
> > -     MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
> > -     MGMT_OP_READ_EXT_INDEX_LIST,
> > -     MGMT_OP_READ_ADV_FEATURES,
> > -     MGMT_OP_ADD_ADVERTISING,
> > -     MGMT_OP_REMOVE_ADVERTISING,
> > -     MGMT_OP_GET_ADV_SIZE_INFO,
> > -     MGMT_OP_START_LIMITED_DISCOVERY,
> > -     MGMT_OP_READ_EXT_INFO,
> > -     MGMT_OP_SET_APPEARANCE,
> > -     MGMT_OP_SET_BLOCKED_KEYS,
> > +static int read_version(struct sock *sk, struct hci_dev *hdev, void *data,
> > +                     u16 data_len);
> > +static int read_commands(struct sock *sk, struct hci_dev *hdev, void *data,
> > +                      u16 data_len);
>
> <snip>
>
> I do not see this as a good thing. This massive list of forward declarations is not acceptable. That makes the code unmaintainable for upstream.
>
> Regards
>
> Marcel
>
