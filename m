Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314175065-18096-1-git-send-email-sancane@gmail.com>
References: <1314175065-18096-1-git-send-email-sancane@gmail.com>
Date: Thu, 15 Sep 2011 19:42:16 +0200
Message-ID: <CACLukzKAGVfSJ1FZWOTecvuJuLN1Qm_tmXcdiJ3jYWdPH5=zJw@mail.gmail.com>
Subject: Re: [PATCH] Add valid range descriptor uuid
From: Santiago Carot <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

2011/8/24 Santiago Carot-Nemesio <sancane@gmail.com>:
> ---
>  attrib/att.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/attrib/att.h b/attrib/att.h
> index 3b8c098..d962841 100644
> --- a/attrib/att.h
> +++ b/attrib/att.h
> @@ -43,6 +43,7 @@
>  #define GATT_SERVER_CHARAC_CFG_UUID    0x2903
>  #define GATT_CHARAC_FMT_UUID           0x2904
>  #define GATT_CHARAC_AGREG_FMT_UUID     0x2905
> +#define GATT_CHARAC_VALID_RANGE_UUID   0x2906
>
>  /* Attribute Protocol Opcodes */
>  #define ATT_OP_ERROR                   0x01
> --
> 1.7.6
>
>
