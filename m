Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1381399691-42391-1-git-send-email-marcel@holtmann.org>
References: <1381399691-42391-1-git-send-email-marcel@holtmann.org>
Date: Thu, 10 Oct 2013 07:00:41 -0400
Message-ID: <CAJdJm_Ne5rQ2G8_Je_en1kr9dxw76G_qW9gsm0WvH2On9x3dPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Remove unneeded val variable when setting SSP
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 10, 2013 at 6:08 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> The variable val in the set_ssp() function of the management interface
> is not needed. Just use cp->val directly since its input values have
> already been validated.
> [...]
> -       if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) == val) {
> +       if (!!cp->val == test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {

In this case, the "!!" trick is unnecessary as the only allowed values
are 0x00 and 0x01 (I believe this has been removed in other similar
cases).

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
