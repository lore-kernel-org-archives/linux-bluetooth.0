Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1346963860-25094-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1346963860-25094-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Mon, 24 Sep 2012 11:30:43 -0300
Message-ID: <CAKT1EBes6m14psLz+zRbmOOniaGd-57CK47o7275+-GUKw0HrQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0] gatt: Exchange MTU needs to be executed first
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan:

On Thu, Sep 6, 2012 at 5:37 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> According to Bluetooth SPEC the ATT Exchange MTU sub-procedure needs to
> be execute before any ATT command. This patch moves the Exchange MTU
> sub-procedure from GATT plugin to device ATTIO core.
> ---
>
> *** Apply after "LE General Connection Establishment procedure" patches

Please ignore this patch. Indications sent from the keyboard (during
the MTU sub-procedure) are being lost.

Regards,
Claudio
