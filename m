Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH 1/2] Bluetooth: Add __hci_cmd_sync_noev function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAMZdPi90M71dXo+mHf=9X0AyZkBm_zNk0qQ+O-bRqcuQSabP0w@mail.gmail.com>
Date: Wed, 25 Apr 2018 14:10:57 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, kkapra@codeaurora.org
Message-Id: <C239547F-75D2-418F-9472-561FFE5E352E@holtmann.org>
References: <1524506380-7417-1-git-send-email-loic.poulain@linaro.org>
 <21D02E4F-2AFB-4B2F-9696-969E1632D70D@holtmann.org>
 <CAMZdPi90M71dXo+mHf=9X0AyZkBm_zNk0qQ+O-bRqcuQSabP0w@mail.gmail.com>
To: Loic Poulain <loic.poulain@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

>> so this is not a _sync command. You are not waiting for the completion. So this is more like __hci_cmd_send or __hci_cmd_submit. I am also debating if this should be limited to vendor OGF only, meaning it should throw an error for all others.
> 
> This makes sense, I agree we should not allow standard HCI command to
> be unresponded and strictly follow the specification.
> I think __hci_cmd_send/submit is a bit too generic and we already have
> a hci_send_cmd which has a different behavior, don't want to cause
> confusion. So what about __hci_cmd_noresp or __hci_cmd_vendor...?

so perfect would be that we have at least a “sync” command in that sense that we know the controller has send it to the hardware. However from a driver framework point of view we do not have this concept. And we don’t have it, because that kind of “flow control” is not needed since we have HCI command and also ACL packet flow control that should be used.

My concern is that you can easily overload the controller since there are no checks and balances from a HCI point of view. The transport might have some, but otherwise you push things in a queue and hope that all goes well.

Anyway, I am against __hci_cmd_vendor since that is a bit misleading and the _noresp seems a bit off as well. We could do __hci_cmd_dispatch or __hci_cmd_post. I am not convinced that __hci_cmd_send would be actually that bad. It is essentially the just that (except it bypasses the hdev->cmd_q.

Regards

Marcel

