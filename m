Return-Path: <swboyd@chromium.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>, johan.hedberg@gmail.com,
 marcel@holtmann.org, mka@chromium.org, robh@kernel.org,
 thierry.escande@linaro.org
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180616062718.29844-9-bgodavar@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
 hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
 Balakrishna Godavarthi <bgodavar@codeaurora.org>
References: <20180616062718.29844-1-bgodavar@codeaurora.org>
 <20180616062718.29844-9-bgodavar@codeaurora.org>
Message-ID: <152934015159.16708.15821626950761504540@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH v7 8/8] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth
 chip wcn3990
Date: Mon, 18 Jun 2018 09:42:31 -0700
List-ID: <linux-bluetooth.vger.kernel.org>

Quoting Balakrishna Godavarthi (2018-06-15 23:27:18)
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 28ae6a17a595..1961e313aae7 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1031,9 +1145,118 @@ static struct hci_uart_proto qca_proto =3D {
>         .dequeue        =3D qca_dequeue,
>  };
>  =

> +static const struct qca_vreg_data qca_cherokee_data =3D {
> +       .soc_type =3D QCA_WCN3990,
> +       .vregs =3D (struct qca_vreg []) {
> +               { "vddio",   1352000, 1352000,  0 },
> +               { "vddxtal", 1904000, 2040000,  0 },
> +               { "vddcore", 1800000, 1800000,  1 },
> +               { "vddpa",   1304000, 1304000,  1 },
> +               { "vddldo",  3000000, 3312000,  1 },

Load of 0 and 1 seems sort of odd. Are these made up to indicate "some
load" vs. "no load"?

> +       },
> +       .num_vregs =3D 5,
> +};
> +
> +static int qca_enable_regulator(struct qca_vreg vregs,
> +                               struct regulator *regulator)
> +{
> +       int ret;
> +
> +       ret =3D regulator_set_voltage(regulator, vregs.min_uV,
> +                                   vregs.max_uV);
> +       if (ret)
> +               goto out;

Just return ret;

> +
> +       if (vregs.load_uA)
> +               ret =3D regulator_set_load(regulator,
> +                                        vregs.load_uA);
> +
> +       if (ret)
> +               goto out;
> +

Same.

> +       ret =3D regulator_enable(regulator);
> +
> +out:
> +       return ret;

And make this return regulator_enable(regulator).

> +
> +}
> +
