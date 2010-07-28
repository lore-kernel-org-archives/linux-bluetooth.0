Return-Path: <cyrus@holtmann.org>
Message-ID: <4C5020D7.7080005@nokia.com>
Date: Wed, 28 Jul 2010 15:21:43 +0300
From: Ville Tervo <ville.tervo@Nokia.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Resend ConfigReq on unknown options failure
References: <20100728033225.GB22156@vigoh> <1280301080-565-1-git-send-email-gustavo@padovan.org> <20100728071631.GD22156@vigoh>
In-Reply-To: <20100728071631.GD22156@vigoh>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/28/2010 10:16 AM, ext Gustavo F. Padovan wrote:
> Hi Ville,
>
> * Gustavo F. Padovan<gustavo@padovan.org>  [2010-07-28 04:11:20 -0300]:
>
>> From: Gustavo F. Padovan<padovan@profusion.mobi>
>>
>> If the remote device send a ConfigRsp with the unknown options failure we
>> should remove that option from the ConfigReq and send it again.
>> This patch only remove the RFC option in the case it is a unknown option.
>>
>> Signed-off-by: Gustavo F. Padovan<padovan@profusion.mobi>
>> ---
>>   include/net/bluetooth/l2cap.h |   17 +++++++++--------
>>   net/bluetooth/l2cap.c         |   28 ++++++++++++++++++++++++----
>>   2 files changed, 33 insertions(+), 12 deletions(-)
>
> Can you please test thi patch? I think it fix the unknown option
> problem.

No it didn't help. I'll try to find out why it still fails.

-- 
Ville
