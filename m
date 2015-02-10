Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1423484604-24982-2-git-send-email-gowtham.ab@samsung.com>
References: <1423484604-24982-1-git-send-email-gowtham.ab@samsung.com>
	<1423484604-24982-2-git-send-email-gowtham.ab@samsung.com>
Date: Tue, 10 Feb 2015 13:43:39 +0200
Message-ID: <CABBYNZJqTAt67TcK9Hw7pc2o3A-oD29RhNfDFoOGX_3o-FCG2g@mail.gmail.com>
Subject: Re: [PATCH 1/3] unit/gatt: Add TP/GAR/CL/BI-04-C test
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Mon, Feb 9, 2015 at 2:23 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Verify Generic Attribute Profile client behavior when the Read
> Characteristic Value procedure fails due to insufficient authentication.
> ---
>  unit/test-gatt.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> index bbafbda..5952026 100644
> --- a/unit/test-gatt.c
> +++ b/unit/test-gatt.c
> @@ -656,6 +656,12 @@ static const struct test_step test_read_4 = {
>         .expected_att_ecode = 0x08,
>  };
>
> +static const struct test_step test_read_5 = {
> +       .handle = 0x0003,
> +       .func = test_read,
> +       .expected_att_ecode = 0x05,
> +};
> +
>  static void att_write_cb(struct gatt_db_attribute *att, int err,
>                                                                 void *user_data)
>  {
> @@ -1848,6 +1854,12 @@ int main(int argc, char *argv[])
>                         raw_pdu(0x0a, 0x03, 0x00),
>                         raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x08));
>
> +       define_test_client("/TP/GAR/CL/BI-04-C", test_client, service_db_1,
> +                       &test_read_5,
> +                       SERVICE_DATA_1_PDUS,
> +                       raw_pdu(0x0a, 0x03, 0x00),
> +                       raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x05));
> +
>         define_test_server("/TP/GAR/SR/BV-01-C/small", test_server,
>                         ts_small_db, NULL,
>                         raw_pdu(0x03, 0x00, 0x02),
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
