Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1318261853-22448-1-git-send-email-ospite@studenti.unina.it>
References: <1316454126-32614-1-git-send-email-ospite@studenti.unina.it>
	<1318261853-22448-1-git-send-email-ospite@studenti.unina.it>
Date: Mon, 10 Oct 2011 19:16:26 +0200
Message-ID: <CAN_we7PX3DRxHrwa_A23nFD=FfwW-gQ2p39aFT7S6fGoD_rdXQ@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ RESEND 1/3] Add a btd_manager_get_default_adapter_str()
 call
From: Daniele Forsi <dforsi@gmail.com>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2011/10/10 Antonio Ospite:

> +char *btd_manager_get_default_adapter_str(void)

> +       char *str = bt_malloc(18);
> +
> +       adapter = manager_get_default_adapter();
> +       if (adapter == NULL) {
> +               return NULL;

you are leaking str if you return here
-- 
Daniele Forsi
