Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391339801-587-3-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1391339801-587-1-git-send-email-andrzej.kaczmarek@tieto.com>
	<1391339801-587-3-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Sun, 2 Feb 2014 08:45:20 -0400
Message-ID: <CAJdJm_M00ugUOObhayoPm9f4tFq3av6_9zSVwBNXUv9RmAdF4w@mail.gmail.com>
Subject: Re: [PATCH 02/11] android/tester: Add create bond with PIN success
 test case
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Sun, Feb 2, 2014 at 7:16 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> +static void bond_create_pin_success_request_cb(bt_bdaddr_t *remote_bd_addr,
> +                                       bt_bdname_t *bd_name, uint32_t cod)
> +{
> +       struct test_data *data = tester_get_data();
> +       struct mgmt_cp_pin_code_reply rp;
> +       bdaddr_t remote_addr;
> +       static uint8_t pair_device_pin[] = { 0x30, 0x30, 0x30, 0x30 };
> +       const void *pin_code = pair_device_pin;
> +       uint8_t pin_len = 4;
> +
> +       memset(&rp, 0, sizeof(rp));
> +
> +       data->cb_count--;
> +
> +       android2bdaddr(remote_bd_addr, &remote_addr);
> +
> +       bacpy(&rp.addr.bdaddr, &remote_addr);
> +       rp.addr.type = BDADDR_BREDR;
> +       rp.pin_len = pin_len;
> +       memcpy(rp.pin_code, pin_code, rp.pin_len);
> +
> +       mgmt_reply(data->mgmt, MGMT_OP_PIN_CODE_REPLY, data->mgmt_index,
> +                                       sizeof(rp), &rp, NULL, NULL, NULL);

I wonder why you are sending mgmt commands directly instead of using
data->if_bluetooth->pin_reply()?

NOTE: I'm not very familiar with the HAL API so I may just be missing
the point of the test.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
