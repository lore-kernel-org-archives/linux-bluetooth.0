Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Anitha Chandrasekar <anitha.chandrasekar@sasken.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Need info on factory reset api in Bluez
Date: Wed, 18 Oct 2017 11:16:36 +0000
Message-ID: <7B53A3173656CB4190908401FE75F4F860078CC1@exgmbxfz02.sasken.com>
References: <7B53A3173656CB4190908401FE75F4F860077BD9@exgmbxfz02.sasken.com>,<CABBYNZKz3ScfkX_5NeQgBeGhA4T_O-AhroD4nkLxrtN63w76+Q@mail.gmail.com>
In-Reply-To: <CABBYNZKz3ScfkX_5NeQgBeGhA4T_O-AhroD4nkLxrtN63w76+Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Great!!, Thanks for the quick reply.

Regards,
Anitha
________________________________________
From: linux-bluetooth-owner@vger.kernel.org [linux-bluetooth-owner@vger.kernel.org] on behalf of Luiz Augusto von Dentz [luiz.dentz@gmail.com]
Sent: Wednesday, October 18, 2017 2:49 PM
To: Anitha Chandrasekar
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Need info on factory reset api in Bluez

Hi Anitha,

On Tue, Oct 17, 2017 at 2:52 PM, Anitha Chandrasekar
<anitha.chandrasekar@sasken.com> wrote:
> Hi,
>
> We are using bluez stack apis for developing BLE client.Our device has an option of factory reset.
> I have tried using rfkill etc to reset the controller, but I see that devices are not getting deleted from gatt database.
>
> Is there any single api call, which is used for factory reset in Bluez?

Usually, this is implemented by wiping the storage which is under
/var/lib/bluetooth.


--
Luiz Augusto von Dentz
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

________________________________

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Technologies Limited ( formerly known as "Sasken Communication Technologies Limited" ) unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/mail-disclaimer/

________________________________
