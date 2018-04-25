Return-Path: <loic.poulain@linaro.org>
MIME-Version: 1.0
In-Reply-To: <21D02E4F-2AFB-4B2F-9696-969E1632D70D@holtmann.org>
References: <1524506380-7417-1-git-send-email-loic.poulain@linaro.org> <21D02E4F-2AFB-4B2F-9696-969E1632D70D@holtmann.org>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Wed, 25 Apr 2018 12:00:36 +0200
Message-ID: <CAMZdPi90M71dXo+mHf=9X0AyZkBm_zNk0qQ+O-bRqcuQSabP0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Add __hci_cmd_sync_noev function
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
	kkapra@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>
> so this is not a _sync command. You are not waiting for the completion. So this is more like __hci_cmd_send or __hci_cmd_submit. I am also debating if this should be limited to vendor OGF only, meaning it should throw an error for all others.

This makes sense, I agree we should not allow standard HCI command to
be unresponded and strictly follow the specification.
I think __hci_cmd_send/submit is a bit too generic and we already have
a hci_send_cmd which has a different behavior, don't want to cause
confusion. So what about __hci_cmd_noresp or __hci_cmd_vendor...?

Regards,
Loic
