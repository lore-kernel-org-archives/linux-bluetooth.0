Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH] Revert "Bluetooth: btusb: Fix quirk for Atheros
 1525/QCA6174"
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
References: <20180426121819.23327-1-hdegoede@redhat.com>
 <85CF4178-2D2E-49D6-8837-EBD36623DFEE@holtmann.org>
 <009e5572-3766-f634-43be-7a3fce9ccfd8@redhat.com>
Message-ID: <a4ba16ef-6369-fe32-24e0-30efb27a63f3@redhat.com>
Date: Fri, 27 Apr 2018 10:49:52 +0200
MIME-Version: 1.0
In-Reply-To: <009e5572-3766-f634-43be-7a3fce9ccfd8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 26-04-18 20:28, Hans de Goede wrote:
> Hi,
> 
> On 26-04-18 14:22, Marcel Holtmann wrote:
>> Hi Hans,
>>
>>> Commit f44cb4b19ed4 ("Bluetooth: btusb: Fix quirk for Atheros
>>> 1525/QCA6174") is causing bluetooth to no longer work for several
>>> people, see: https://bugzilla.redhat.com/show_bug.cgi?id=1568911
>>>
>>> So lets revert it for now and try to find another solution for
>>> devices which need the modified quirk.
>>>
>>> Cc: stable@vger.kernel.org
>>> Cc: Takashi Iwai <tiwai@suse.de>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> drivers/bluetooth/btusb.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> patch has been applied to bluetooth-next tree.
> 
> This is a regression fix, so can we please get this into 4.17-rc#
> so that Greg can then take it into 4.16.z ?

Also see: https://bugzilla.kernel.org/show_bug.cgi?id=199271

Regards,

Hans
