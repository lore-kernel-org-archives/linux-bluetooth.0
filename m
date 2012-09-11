Return-Path: <cyrus@holtmann.org>
Message-ID: <504F2CF9.7060900@ti.com>
Date: Tue, 11 Sep 2012 15:22:17 +0300
From: Chen Ganir <chen.ganir@ti.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2] gatt: Delay D-Bus reply on char discovery
References: <1347353240-1942-1-git-send-email-chen.ganir@ti.com> <CAJdJm_OZZ+SrYdfbpqy+yFmppx9xAs-YMmDtn3PzQbU1JD_pOA@mail.gmail.com>
In-Reply-To: <CAJdJm_OZZ+SrYdfbpqy+yFmppx9xAs-YMmDtn3PzQbU1JD_pOA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Anderson,

On 09/11/2012 02:44 PM, Anderson Lizardo wrote:
> Hi Chen,
>
> On Tue, Sep 11, 2012 at 4:47 AM,  <chen.ganir@ti.com> wrote:
>> From: Chen Ganir <chen.ganir@ti.com>
>>
>> Delay sending the D-Bus reply for the discover_characteristics
>> command. The D-Bus reply for characteristics is sent before all
>> the relevant characteristic information is gathered. This can
>> cause problems, when trying to get characteristic information too
>> soon. This patch moves the D-Bus reply to the end of the char
>> discovery process. Only after all descriptors are discovered and
>> read, the D-Bus reply is sent.
>> ---
>
> I see you populate chr->descriptors, but I can't find where the list
> is actually used. Do you plan to use this information in some other
> patch?
>
> Regards,
>

The plan is to replace characteristic::format, and add CCC, SCC and any 
other descriptor we find in the future to this list. This way we have a 
unified list of descriptors and the data contained in them. This is 
already done in some patches i already have, which rely on this patch. 
Next patch set includes notification/indication implementation to the 
D-Bus API (Auto registration to notification/indication if CCC is found).

-- 
BR,
Chen Ganir

