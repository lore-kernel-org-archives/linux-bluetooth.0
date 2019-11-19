Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30824C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 17:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0602422360
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 17:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfKSREj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 12:04:39 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35485 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfKSREj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 12:04:39 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id CCD2ECECF6;
        Tue, 19 Nov 2019 18:13:43 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191027220945.wmb3g55wtrmqbnmz@pali>
Date:   Tue, 19 Nov 2019 18:04:36 +0100
Cc:     Pavel Machek <pavel@ucw.cz>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <1CFFA8EF-1B2A-466E-8901-BFB849F20442@holtmann.org>
References: <20190519082305.q7y4gpmdhvx3vzvo@pali>
 <CABBYNZJKO07p-8ufP7=4WUYS1oLhnsKY_pnP6-0SbVzi=CYZsQ@mail.gmail.com>
 <20190519212157.GB31403@amd> <20190607130245.mv4ch6dxnuptzdki@pali>
 <ED456CCA-CF85-48D9-B7E9-9B0BF02A32FC@holtmann.org>
 <20190708122512.qqfvtm455ltxxg3h@pali>
 <E4A6E61C-DE37-4E5D-9401-71CCE4AE2419@holtmann.org>
 <20190708210616.x2dlnzjhnplu37bz@pali>
 <D0A44CC7-CABC-408A-894E-AAD700FA9B0D@holtmann.org>
 <20190718100939.bwl26qcfxe6ppcto@pali> <20191027220945.wmb3g55wtrmqbnmz@pali>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

>>>>>>>>>>>> to be honest, I would rather see WBS implementation finally
>>>>>>>>>>>> reach PA before we start digging into this.
>>>>>>>>>>> 
>>>>>>>>>>> First I want to finish improving A2DP codec support in pulseaudio. Later
>>>>>>>>>>> I can look at HSP/HFP profiles. Ideally it should have modular/plugin
>>>>>>>>>>> extensible design. So the aim is that adding new codec would be very
>>>>>>>>>>> simple, without need to hack something related to mSBC/WBC, AuriStream
>>>>>>>>>>> or any other codec.
>>>>>>>>>> 
>>>>>>>>>> Well HSP don't have support for codec negotiation, but yes a modular
>>>>>>>>>> design is probably recommended.
>>>>>>>>>> 
>>>>>>>>>>> But for AuriStream I need to set custom SCO parameters as described
>>>>>>>>>>> below and currently kernel does not support it. This is why I'm asking
>>>>>>>>>>> how kernel can export for userspace configuration of SCO parameters...
>>>>>>>>>> 
>>>>>>>>>> We can always come up with socket options but we got to see the value
>>>>>>>>>> it would bring since AuriStream don't look that popular among
>>>>>>>>>> headsets, at least Ive never seem any device advertising it like
>>>>>>>>>> apt-X, etc.
>>>>>>>>> 
>>>>>>>>> Pali clearly has such device and he is willing to work on it. Surely
>>>>>>>>> that means it is popular enough to be supported...?
>>>>>>>> 
>>>>>>>> Just put AT+CSRSF=0,0,0,0,0,7 to google search and you would see that
>>>>>>>> not only I have such device...
>>>>>>>> 
>>>>>>>> So I would really would like to see that kernel finally stops blocking
>>>>>>>> usage of this AuriStream codec.
>>>>>>> 
>>>>>>> we need to figure out on how we do the kernel API to allow you this specific setting.
>>>>>> 
>>>>>> Hi Marcel! Kernel API for userspace should be simple. Just add two
>>>>>> ioctls for retrieving and setting structure with custom parameters:
>>>>>> 
>>>>>> syncPktTypes = 0x003F
>>>>>> bandwidth = 4000
>>>>>> max_latency = 16
>>>>>> voice_settings = 0x63
>>>>>> retx_effort = 2
>>>>>> 
>>>>>> Or add more ioctls, one ioctl per parameter. There is already only ioctl
>>>>>> for voice settings and moreover it is whitelisted only for two values.
>>>>> 
>>>>> it is not that simple actually. Most profiles define a certain set of parameters and then they try to configure better settings and only fallback to a specification defined default as last resort.
>>>> 
>>>> Ok. I see that there is another "example" configuration for AuriStream
>>>> with just different syncPktTypes = 0x02BF and bandwidth = 3850.
>>>> 
>>>> So it really is not simple as it can be seen.
>>> 
>>> currently the stepping for mSBC and CVSD are hard-coded in esco_param_cvsd and esco_param_msbc arrays in hci_conn.c and then selected by the ->setting parameter.
>>> 
>>> So either we provide an new socket option (for example BT_VOICE_EXT) or we extend BT_VOICE to allow providing the needed information. However this needs to be flexible array size since we should then be able to encode multiple stepping that are tried in order.
>>> 
>>> My preference is that we extend BT_VOICE and not introduce a new socket option. So feel free to propose how we can load the full tables into the SCO socket. I mean we are not really far off actually. The only difference is that currently the tables are in the hci_conn.c file and selected by the provided voice->setting. However nothing really stops us from providing the full table via user space.
>> 
>> Ok. I will look at it and I will try to propose how to extend current
>> BT_VOICE ioctl API for supporting all those new parameters.
> 
> Below is inline MIME part with POC patch which try to implement a new
> IOCTL (currently named BT_VOICE_SETUP) for configuring voice sco
> settings.
> 
> It uses flexible array of parameters <tx_bandwidth, rx_bandwidth,
> voice_setting, pkt_type, max_latency, retrans_effort>, but with
> maximally 10 array members (due to usage of static array storage). cvsd
> codec uses 7 different fallback settings (see voice_setup_cvsd), so for
> POC 10 should be enough.
> 
> Because a new IOCL has different members then old BT_VOICE I rather
> decided to introduce a new IOCTL and not hacking old IOCTL to accept two
> different structures.
> 
> Please let me know what do you think about this API, if this is a way
> how to continue or if something different is needed.
> 
> -- 
> Pali Rohár
> pali.rohar@gmail.com
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index fabee6db0abb..0e9f4ac07220 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -122,6 +122,19 @@ struct bt_voice {
> #define BT_SNDMTU		12
> #define BT_RCVMTU		13
> 
> +#define BT_VOICE_SETUP		14
> +#define BT_VOICE_SETUP_ARRAY_SIZE 10
> +struct bt_voice_setup {
> +	__u8 sco_capable:1;
> +	__u8 esco_capable:1;
> +	__u32 tx_bandwidth;
> +	__u32 rx_bandwidth;
> +	__u16 voice_setting;
> +	__u16 pkt_type;
> +	__u16 max_latency;
> +	__u8 retrans_effort;
> +};
> +
> __printf(1, 2)
> void bt_info(const char *fmt, ...);
> __printf(1, 2)
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 094e61e07030..8f3c161da1c4 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -477,7 +477,7 @@ struct hci_conn {
> 	__u8		passkey_entered;
> 	__u16		disc_timeout;
> 	__u16		conn_timeout;
> -	__u16		setting;
> +	struct bt_voice_setup voice_setup[BT_VOICE_SETUP_ARRAY_SIZE];
> 	__u16		le_conn_min_interval;
> 	__u16		le_conn_max_interval;
> 	__u16		le_conn_interval;
> @@ -897,8 +897,8 @@ static inline struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
> }
> 
> int hci_disconnect(struct hci_conn *conn, __u8 reason);
> -bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
> -void hci_sco_setup(struct hci_conn *conn, __u8 status);
> +int hci_setup_sync(struct hci_conn *conn, __u16 handle);
> +int hci_sco_setup(struct hci_conn *conn, __u8 status);
> 
> struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
> 			      u8 role);
> @@ -920,7 +920,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
> 				 u8 sec_level, u8 auth_type);
> struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
> -				 __u16 setting);
> +				 struct bt_voice_setup *voice_setup);
> int hci_conn_check_link_mode(struct hci_conn *conn);
> int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
> int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index bd4978ce8c45..0aa2ad98eb80 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -35,30 +35,6 @@
> #include "smp.h"
> #include "a2mp.h"
> 
> -struct sco_param {
> -	u16 pkt_type;
> -	u16 max_latency;
> -	u8  retrans_effort;
> -};
> -
> -static const struct sco_param esco_param_cvsd[] = {
> -	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000a,	0x01 }, /* S3 */
> -	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x0007,	0x01 }, /* S2 */
> -	{ EDR_ESCO_MASK | ESCO_EV3,   0x0007,	0x01 }, /* S1 */
> -	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff,	0x01 }, /* D1 */
> -	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff,	0x01 }, /* D0 */
> -};
> -
> -static const struct sco_param sco_param_cvsd[] = {
> -	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff,	0xff }, /* D1 */
> -	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff,	0xff }, /* D0 */
> -};
> -
> -static const struct sco_param esco_param_msbc[] = {
> -	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d,	0x02 }, /* T2 */
> -	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008,	0x02 }, /* T1 */
> -};
> -

can you split this into multiple logical patches. And ensure sending it with git send-email.

Regards

Marcel

