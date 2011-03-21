Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1300722233-11598-5-git-send-email-szymon.janc@tieto.com>
References: <1300722233-11598-1-git-send-email-szymon.janc@tieto.com>
	<1300722233-11598-5-git-send-email-szymon.janc@tieto.com>
Date: Mon, 21 Mar 2011 15:24:40 -0400
Message-ID: <AANLkTimhdS0Spw2b0i74nLrHftS_6CuEJLba838iRqKQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] Bluetooth: Add add/remove_remote_oob_data
 management commands
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

Minor coding style issue follows.

On Mon, Mar 21, 2011 at 11:43 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> +static int remove_remote_oob_data(struct sock *sk, u16 index,
> +                                               unsigned char *data, u16 len)
> +{
> +       struct hci_dev *hdev;
> +       struct mgmt_cp_remove_remote_oob_data *cp = (void *)data;

Missing space between "(void *)" and "data".

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
