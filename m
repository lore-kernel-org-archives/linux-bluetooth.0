Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=06P4ZpGO-sp7czZtn9FGLkBwPnrxNqDdGspfy@mail.gmail.com>
References: <1293456068-11615-1-git-send-email-anderson.lizardo@openbossa.org>
	<1293456068-11615-2-git-send-email-anderson.lizardo@openbossa.org>
	<AANLkTikcZRjC2KwOpHSqS_6wMcT8skKBMbhMzs=ugK+F@mail.gmail.com>
	<AANLkTi=06P4ZpGO-sp7czZtn9FGLkBwPnrxNqDdGspfy@mail.gmail.com>
Date: Mon, 27 Dec 2010 11:21:18 -0400
Message-ID: <AANLkTikhz8SFeYs7mS2zoXJyL+RAipNBdrKKypEf_LfA@mail.gmail.com>
Subject: Re: [PATCH 2/4] Use stored device name (if any) instead of EIR data
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Dec 27, 2010 at 10:35 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> I've not found any references to the spec saying the shortened name
> has to be a prefix. I believe it is left to the implementer how to
> display such shortened names. bluez so far has made no distinction on
> the display of shortened names vs. complete names.

Interestingly, on Volume 3, Part C, 11.1.2, it is mentioned that for
Advertising Data (i.e. LE devices):

"A shortened name shall only contain contiguous
characters from the beginning of the full name. For example, if the device name
is ‘BT_Device_Name’ then the shortened name over BR/EDR could be
‘BT_Device’ while the shortened name on LE could be ‘BT_Dev’."

Nothing is said on the EIR format, though (see Vol 3, Part C, 8.1.2).

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
