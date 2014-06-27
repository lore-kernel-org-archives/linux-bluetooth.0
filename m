Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <53AD4CF3.50806@message-id.googlemail.com>
References: <1403866069-15394-1-git-send-email-luiz.dentz@gmail.com>
	<53AD4CF3.50806@message-id.googlemail.com>
Date: Fri, 27 Jun 2014 14:08:01 +0300
Message-ID: <CABBYNZ+uHj4dWhNj-mUAgAXmF-EscQ6zfHJse3-ZOQ-+UDZ4Yw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/queue: Fix invalid read
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jun 27, 2014 at 1:52 PM, Stefan Seyfried
<stefan.seyfried@googlemail.com> wrote:
> Hi Luiz,
>
> This also fixes my unit/test-queue failure.
>
> Thanks!
>
> Stefan
>
> Am 27.06.2014 12:47, schrieb Luiz Augusto von Dentz:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> If the queue elements are destroyed by queue_destroy the head will point
>> to freed memory causing the following error when unit/test-queue is run:

Pushed.

-- 
Luiz Augusto von Dentz
