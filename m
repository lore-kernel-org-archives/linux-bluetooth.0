Return-Path: <cyrus@holtmann.org>
Message-ID: <1351207806.25783.2.camel@aeonflux>
Subject: Re: [PATCH] systemd: prevent duplicate logging messages in journal
From: Marcel Holtmann <marcel@holtmann.org>
To: Marti Raudsepp <marti@juffo.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 25 Oct 2012 16:30:06 -0700
In-Reply-To: <1349884769-5157-1-git-send-email-marti@juffo.org>
References: <1349884769-5157-1-git-send-email-marti@juffo.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marti,

> By default, both stdout and syslog messages go to the systemd journal,
> which results in duplicate messages being logged.
> ---
>  src/bluetooth.service.in | 1 +
>  1 file changed, 1 insertion(+)

patch has been applied.

Regards

Marcel


