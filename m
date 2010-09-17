Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTik244A2zNFL-yL7CvBKdf3UZDDKq1Ap7HR5+aCR@mail.gmail.com>
References: <AANLkTi=86t=osr8YUfUfU3QLHiHXgp8SCuwqOE_GoPgp@mail.gmail.com>
	<20100916141654.GB15000@vigoh>
	<AANLkTik244A2zNFL-yL7CvBKdf3UZDDKq1Ap7HR5+aCR@mail.gmail.com>
Date: Fri, 17 Sep 2010 09:08:13 +0800
Message-ID: <AANLkTikkpc4ere4uiyDJ=YFEg89CKdARQLxE1ZOdpiDF@mail.gmail.com>
Subject: Fwd: [PATCH] Bluetooth: Replace hard code of fixed channels bit mask
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Sep 16, 2010 at 10:16 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Haijun,
>
> * haijun liu <liuhaijun.er@gmail.com> [2010-09-16 15:15:18 +0800]:
>
>> This patch add fixed channels bit mask definition for
>>               L2CAP_FIXCHAN_NULLID
>>               L2CAP_FIXCHAN_SIGNAL
>>               L2CAP_FIXCHAN_CONNLESS
>>               L2CAP_FIXCHAN_A2MP
>> And replace hard code in source file with the macro.
>>
>> Signed-off-by: Haijun.Liu <Haijun.Liu@Atheros.com>
>> ---
>>  include/net/bluetooth/l2cap.h |    6 ++++++
>>  net/bluetooth/l2cap.c         |    2 +-
>>  2 files changed, 7 insertions(+), 1 deletions(-)
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index 6c24144..e4fe2c7 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -97,6 +97,12 @@ struct l2cap_conninfo {
>>  #define L2CAP_FEAT_FCS               0x00000020
>>  #define L2CAP_FEAT_FIXED_CHAN        0x00000080
>>
>> +/* L2CAP fixed channel bitmask */
>> +#define L2CAP_FIXCHAN_NULLID 0x00
>> +#define L2CAP_FIXCHAN_SIGNAL 0x02
>> +#define L2CAP_FIXCHAN_CONNLESS       0x04
>> +#define L2CAP_FIXCHAN_A2MP   0x08
>
> That's wrong, signaling channel is 0x01, connless is 0x02 and A2MP is
> 0x03. And if you haven't noted we already have macros for the signaling
> and connectionless channels:
>
> #define L2CAP_CID_SIGNALING     0x0001
> #define L2CAP_CID_CONN_LESS     0x0002
>
> --
> Gustavo F. Padovan
> ProFUSION embedded systems - http://profusion.mobi
>

These are not channel id definition, these are feature bit mask values.
And they are used in information exchange process to present FIXED
CHANNELS SUPPORTED.

--
Haijun Liu
