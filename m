Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1387535140-6223-2-git-send-email-szymon.janc@tieto.com>
References: <1387535140-6223-1-git-send-email-szymon.janc@tieto.com>
	<1387535140-6223-2-git-send-email-szymon.janc@tieto.com>
Date: Fri, 20 Dec 2013 07:57:21 -0400
Message-ID: <CAJdJm_NTARex2tKHsobLJFPJ0=BhL9u6PFJQJR=Hs4F+ZpOjhQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] android/hal-bluetooth: Add support for sending
 LE_TEST_MODE command
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Dec 20, 2013 at 6:25 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> +#if PLATFORM_SDK_VERSION > 17
> +static int le_test_mode(uint16_t opcode, uint8_t *buf, uint8_t len)
> +{
> +       uint8_t cmd_buf[sizeof(struct hal_cmd_dut_mode_send) + len];
> +       struct hal_cmd_le_test_mode *cmd = (void *) cmd_buf;

You are using two different structs above (which happen to have the
same fields).

> +
> +       DBG("opcode %u len %u", opcode, len);
> +
> +       if (!interface_ready())
> +               return BT_STATUS_NOT_READY;
> +
> +       cmd->opcode = opcode;
> +       cmd->len = len;
> +       memcpy(cmd->data, buf, cmd->len);
> +
> +       return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_LE_TEST_MODE,
> +                                       sizeof(cmd_buf), cmd, 0, NULL, NULL);

Just to be consistent above, I would use "..., sizeof(cmd_buf),
cmd_buf, ...", although I noticed other similar code already upstream.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
