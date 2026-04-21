Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E414B336897
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776759736; cv=pass; b=sRJGSMquyu4hZ3lA5T9aIqY3+5DrdKdLOrUZZTMEMU8sIdiDYAlpPWIWtpah6Hc5fguUceaGwj3b3Xhaip4gO4aUszltsUjrI3XCgr/NrbcAf1Bui1BKxsi1Wr6zcSIUwK1j7sV20lsLNhihL6YWww8nVzV7yKZgQ+mQ/iyKhyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776759736; c=relaxed/simple;
	bh=oWoADVcLujMzc/2suLrO0L5RgKUAYwvaI0qhBVIG3TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxxMCuzeteE3tpxLipXQ59CTYatw8rZ7/qj4Huf0B1i8oxdjODUUddaXhvmQoIDR+wwdpKJPmaG/AvfnUWU8DCLu2Et/5l+IktNd/MBkmxvRQ74tX5wZ6CXBhYnms1+dw/WKyoGmURxZYPuP8X3EZTxoBwakjsyrniieb8O3mrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=gBVSB3DM; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="gBVSB3DM"
ARC-Seal: i=1; a=rsa-sha256; t=1776759730; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k/LcuLjYi2TXTJ3js4mbD39/I40rWEOURv6XxHW7L6npYGrRQiOL159nyrcezlSLLPN2s0WWlDGuE71uQ07njZHRXc5s4fGxL71QORcjQN8ghgA62zNCLYmVK3CU0FHMBz+eo7Eidt1STBAyOkZkjcNpBmdt90UETT+T9iU8aps=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776759730; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YuJeOVP+3K7ktOp2d9khxlqON0R07M2nLHnTYOSV3uA=; 
	b=h15IAaiV8P4LiYa53gsxUUPE5rS3jQt118Z9gTMJndmDQB5SrA1iw61XkxxPGHvWIf0oLePSqTgiZV3GklL8U5FNVoPk17xnojftgo0dwXGOoF7I0TPLXtftaZ3d7N4Z72d2pEGqBEx/tKjhzEFvUAghA12LbMTlja+v2VOLb6Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776759730;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YuJeOVP+3K7ktOp2d9khxlqON0R07M2nLHnTYOSV3uA=;
	b=gBVSB3DMosE8Z6Aawt/aYoaROBoJ/PYHUrWUxClMbK1at28EcXY+UoepjkFie/ic
	BEfH3dq2whVxVgnxXdwt4FxKYpQlTMpryZQza5NpufUsHLb2xu2ohH3AHwo7EQM9EAc
	r9h+JF32pbi30/WGTCXj6Mte7iK8lGO1V/rg2Zeo=
Received: by mx.zohomail.com with SMTPS id 1776759727868644.7483170116951;
	Tue, 21 Apr 2026 01:22:07 -0700 (PDT)
Message-ID: <92cf3875-562d-4557-8213-086bf10cf4a8@collabora.com>
Date: Tue, 21 Apr 2026 10:22:05 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 1/3] audio: Add ability to force CIS transport Links
 property
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20260420161345.145089-1-frederic.danis@collabora.com>
 <CABBYNZJzhE5y_YC=vw3-V2HRznnoeSxKkVt+FcFcv4=GnONmSw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CABBYNZJzhE5y_YC=vw3-V2HRznnoeSxKkVt+FcFcv4=GnONmSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 20/04/2026 21:52, Luiz Augusto von Dentz wrote:
> Hi Frédéric,
>
> On Mon, Apr 20, 2026 at 1:27 PM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> If bluetoothd is started in testing mode the Links property for CIS
>> is readwrite and can be used to force transport objects Links.
>> This can used to unlink transport objects by sending an empty array.
>>
>> For unlinked transport objects, each transports needs to be acquired
>> separately.
>>
>> This allows to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.
>> ---
>>   profiles/audio/bap.c       | 44 +++++++++++++++++++++++++++++
>>   profiles/audio/transport.c | 57 +++++++++++++++++++++++++++++++-------
>>   2 files changed, 91 insertions(+), 10 deletions(-)
>>
>> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
>> index 375026440..8f1f75240 100644
>> --- a/profiles/audio/bap.c
>> +++ b/profiles/audio/bap.c
>> @@ -2651,13 +2651,57 @@ static void bap_connect_bcast_io_cb(GIOChannel *chan, GError *err,
>>          iso_connect_bcast_cb(chan, err, setup->stream);
>>   }
>>
>> +struct connect_io_data {
>> +       GIOChannel *chan;
>> +       GError *err;
>> +       uint8_t cig_id;
>> +};
>> +
>> +static bool find_enabling_stream(const void *data, const void *match_data)
>> +{
>> +       const struct bap_setup *setup = data;
>> +       const struct connect_io_data *d = match_data;
>> +       uint8_t state;
>> +
>> +       state = bt_bap_stream_get_state(setup->stream);
>> +       if (state == BT_BAP_STREAM_STATE_ENABLING &&
>> +                       setup->qos.ucast.cig_id == d->cig_id)
>> +               iso_connect_cb(d->chan, d->err, setup->stream);
>> +
>> +       return false;
>> +}
>> +
>> +static bool find_enabling_ep(const void *data, const void *match_data)
>> +{
>> +       const struct bap_ep *ep = data;
>> +
>> +       if (ep->setups)
>> +               queue_find(ep->setups, find_enabling_stream, match_data);
>> +
>> +       return false;
>> +}
>> +
>>   static void bap_connect_io_cb(GIOChannel *chan, GError *err, gpointer user_data)
>>   {
>>          struct bap_setup *setup = user_data;
>> +       struct connect_io_data data;
>>
>>          if (!setup->stream)
>>                  return;
>>
>> +       if (bt_bap_stream_get_state(setup->stream) !=
>> +                        BT_BAP_STREAM_STATE_ENABLING) {
>> +               /* The stream may have manually been unliked for tests and the
>> +                * connect event refers to another stream of the CIG.
> If this is happening it already means the setup shouldn't be waiting
> for a connect IO to begin with. Alternatively, the problem might be
> that it will connect regardless because the CIS is bidirectional;
> connecting one stream connects both. However, one stream might have
> the defer setup marked. Did you check that? And in that case we should
> consider it connected, or maybe we should not advance and send the
> start operation if it is still deferred.

Afaiu, setup_connect_io() is only called for one of the stream when
it is part of a CIG, with setup->stream set to this stream.
But, as for BAP/UCL/STR/BV-546-C the transports are unlinked after
creation of the transports, when the other stream is acquired first
bap_ucast_set_io() is called with the stream from setup which is not
in enabling state and with empty links, preventing to call
bt_bap_stream_start().

Here is the log without the bap_connect_io_cb() changes:

bluetoothd[197722]: [:1.493:method_call] < 
org.bluez.MediaEndpoint1.SelectProperties
bluetoothd[197722]: profiles/audio/media.c:media_endpoint_async_call() 
Calling SelectProperties: name = :1.493 path = /local/endpoint/ep0
bluetoothd[197722]: [:1.493:method_call] < 
org.bluez.MediaEndpoint1.SelectProperties
bluetoothd[197722]: profiles/audio/media.c:media_endpoint_async_call() 
Calling SelectProperties: name = :1.493 path = /local/endpoint/ep1
bluetoothd[197722]: profiles/audio/bap.c:bap_select_complete() selecting 2
bluetoothd[197722]: profiles/audio/bap.c:setup_new() ep 0x50600004bb00 
setup 0x50f0000017b0
bluetoothd[197722]: profiles/audio/bap.c:bap_select_complete() selecting 1
bluetoothd[197722]: profiles/audio/bap.c:setup_new() ep 0x50600004bda0 
setup 0x50f0000018a0
bluetoothd[197722]: profiles/audio/bap.c:bap_select_complete() selecting 0
bluetoothd[197722]: profiles/audio/bap.c:bap_select_complete() configure 
(err 0)
bluetoothd[197722]: profiles/audio/bap.c:setup_config() setup 
0x50f0000017b0 caps 0x50200006ecd0 metadata 0x50200006ed10
bluetoothd[197722]: #0: len 0x02 type 0x01
bluetoothd[197722]: Sampling Frequency: 16 Khz (0x03)
bluetoothd[197722]: #1: len 0x02 type 0x02
bluetoothd[197722]: Frame Duration: 10 ms (0x01)
bluetoothd[197722]: #2: len 0x03 type 0x04
bluetoothd[197722]: Frame Length: 40 (0x0028)
bluetoothd[197722]: #3: len 0x05 type 0x03
bluetoothd[197722]: Location: 0x00000001
bluetoothd[197722]: Location: Front Left (0x00000001)
bluetoothd[197722]: src/shared/bap.c:bap_queue_req() req 0x50600004c2e0 
(op 0x01) queue 0x503000033a00
bluetoothd[197722]: profiles/audio/bap.c:setup_config() setup 
0x50f0000018a0 caps 0x50200006ed50 metadata 0x50200006ed90
bluetoothd[197722]: #0: len 0x02 type 0x01
bluetoothd[197722]: Sampling Frequency: 16 Khz (0x03)
bluetoothd[197722]: #1: len 0x02 type 0x02
bluetoothd[197722]: Frame Duration: 10 ms (0x01)
bluetoothd[197722]: #2: len 0x03 type 0x04
bluetoothd[197722]: Frame Length: 40 (0x0028)
bluetoothd[197722]: #3: len 0x05 type 0x03
bluetoothd[197722]: Location: 0x00000001
bluetoothd[197722]: Location: Front Left (0x00000001)
bluetoothd[197722]: src/shared/bap.c:bap_queue_req() req 0x50600004c340 
(op 0x01) queue 0x503000071410
bluetoothd[197722]: profiles/audio/bap.c:bap_config_setup_cb() setup 
(nil) code 0 remain 2
bluetoothd[197722]: src/shared/bap.c:bap_process_queue()
bluetoothd[197722]: src/shared/bap.c:bap_send() req 0x50600004c2e0 len 52
bluetoothd[197722]: src/shared/att.c:can_read_data() (chan 
0x508000010d20) ATT PDU received: 0x1b
bluetoothd[197722]: profiles/audio/bap.c:config_cb() stream 
0x50e000008460 code 0x00 reason 0x00
bluetoothd[197722]: profiles/audio/bap.c:config_cb() stream 
0x50e000008540 code 0x00 reason 0x00
bluetoothd[197722]: src/shared/bap.c:bap_process_queue()
bluetoothd[197722]: profiles/audio/bap.c:bap_update_cig() adapter 
0x513000000200 CIG 0x0
bluetoothd[197722]: profiles/audio/bap.c:bap_update_cig() setup 
0x50f0000018a0 stream 0x50e000008540 busy
bluetoothd[197722]: profiles/audio/bap.c:bap_update_cig() setup 
0x50f0000018a0 stream 0x50e000008540 readying
bluetoothd[197722]: src/shared/att.c:can_read_data() (chan 
0x508000010d20) ATT PDU received: 0x1b
bluetoothd[197722]: src/shared/bap.c:bap_ep_set_status() ASE status: ep 
0x504000021950 id 0x01 handle 0x0121 state config len 39
bluetoothd[197722]: src/shared/bap.c:ep_status_config() codec 0x06 
framing 0x00.phys 0x03 rtn 2 latency 10 pd 40000 - 40000 ppd 0 - 0
bluetoothd[197722]: src/shared/bap.c:ep_status_config() Codec Config #0: 
type 0x01 len 2
bluetoothd[197722]: src/shared/bap.c:ep_status_config() Codec Config #1: 
type 0x02 len 2
bluetoothd[197722]: src/shared/bap.c:ep_status_config() Codec Config #2: 
type 0x04 len 3
bluetoothd[197722]: src/shared/bap.c:ep_status_config() Codec Config #3: 
type 0x03 len 5
bluetoothd[197722]: src/shared/bap.c:bap_stream_update_io_links() stream 
0x50e000008540
bluetoothd[197722]: src/shared/bap.c:bap_ucast_io_link() stream 
0x50e000008460 link 0x50e000008540
bluetoothd[197722]: profiles/audio/bap.c:bap_state() stream 
0x50e000008540: idle(0) -> config(1)
bluetoothd[197722]: profiles/audio/bap.c:bap_update_cig() adapter 
0x513000000200 CIG 0x0
bluetoothd[197722]: profiles/audio/bap.c:bap_update_cig() setup 
0x50f0000017b0 stream 0x50e000008460 busy
bluetoothd[197722]: profiles/audio/bap.c:bap_update_cig() setup 
0x50f0000018a0 stream 0x50e000008540 readying
bluetoothd[197722]: src/shared/att.c:can_read_data() (chan 
0x508000010d20) ATT PDU received: 0x1b
bluetoothd[197722]: src/shared/bap.c:bap_ep_set_status() ASE status: ep 
0x504000021a50 id 0x0a handle 0x0127 state config len 39
bluetoothd[197722]: src/shared/bap.c:ep_status_config() codec 0x06 
framing 0x00.phys 0x03 rtn 2 latency 10 pd 40000 - 40000 ppd 0 - 0
bluetoothd[197722]: src/shared/bap.c:ep_status_config() Codec Config #0: 
type 0x01 len 2
bluetoothd[197722]: src/shared/bap.c:ep_status_config() Codec Config #1: 
type 0x02 len 2
bluetoothd[197722]: src/shared/bap.c:ep_status_config() Codec Config #2: 
type 0x04 len 3
bluetoothd[197722]: src/shared/bap.c:ep_status_config() Codec Config #3: 
type 0x03 len 5
bluetoothd[197722]: src/shared/bap.c:bap_stream_update_io_links() stream 
0x50e000008460
bluetoothd[197722]: profiles/audio/bap.c:bap_state() stream 
0x50e000008460: idle(0) -> config(1)
bluetoothd[197722]: profiles/audio/bap.c:bap_update_cig() adapter 
0x513000000200 CIG 0x0
bluetoothd[197722]: profiles/audio/bap.c:update_cig_setup_qos() 
0x50f0000018a0
bluetoothd[197722]: profiles/audio/bap.c:setup_create_io() setup 
0x50f0000018a0 stream 0x50e000008540 defer true
bluetoothd[197722]: src/shared/bap.c:bt_bap_stream_io_get_qos() in 
0x50e000008498 out 0x50e000008578
bluetoothd[197722]: profiles/audio/bap.c:setup_connect_io() setup 
0x50f0000018a0 stream 0x50e000008540 defer true setup->stream 0x50e000008540
bluetoothd[197722]: src/shared/bap.c:bap_stream_io_attach() stream 
0x50e000008540 connecting true
bluetoothd[197722]: src/shared/bap.c:stream_io_new() fd 26
bluetoothd[197722]: profiles/audio/bap.c:bap_connecting() stream 
0x50e000008540 fd 26: CIG 0x00 CIS 0x00
bluetoothd[197722]: profiles/audio/bap.c:bap_connecting() stream 
0x50e000008460 fd 26: CIG 0x00 CIS 0x00
bluetoothd[197722]: src/shared/bap.c:bap_queue_req() req 0x50600004c520 
(op 0x02) queue 0x503000033a00
bluetoothd[197722]: profiles/audio/bap.c:update_cig_setup_qos() 
0x50f0000017b0
bluetoothd[197722]: profiles/audio/bap.c:setup_create_io() setup 
0x50f0000017b0 stream 0x50e000008460 defer true
bluetoothd[197722]: src/shared/bap.c:bt_bap_stream_io_get_qos() in 
0x50e000008498 out 0x50e000008578
bluetoothd[197722]: src/shared/bap.c:bap_queue_req() req 0x50600004c5e0 
(op 0x02) queue 0x503000071b30
bluetoothd[197722]: profiles/audio/bap.c:bap_update_cig() setup 
0x50f0000018a0 stream 0x50e000008540 readying
bluetoothd[197722]: src/shared/bap.c:bap_process_queue()
bluetoothd[197722]: src/shared/bap.c:bap_send() req 0x50600004c520 len 34
bluetoothd[197722]: src/shared/att.c:can_read_data() (chan 
0x508000010d20) ATT PDU received: 0x1b
bluetoothd[197722]: profiles/audio/bap.c:qos_cb() stream 0x50e000008540 
code 0x00 reason 0x00
bluetoothd[197722]: profiles/audio/bap.c:qos_cb() stream 0x50e000008460 
code 0x00 reason 0x00
bluetoothd[197722]: src/shared/bap.c:bap_process_queue()
bluetoothd[197722]: profiles/audio/bap.c:bap_update_cig() adapter 
0x513000000200 CIG 0x0
bluetoothd[197722]: profiles/audio/bap.c:bap_update_cig() setup 
0x50f0000018a0 stream 0x50e000008540 readying
bluetoothd[197722]: src/shared/att.c:can_read_data() (chan 
0x508000010d20) ATT PDU received: 0x1b
bluetoothd[197722]: src/shared/bap.c:bap_ep_set_status() ASE status: ep 
0x504000021950 id 0x01 handle 0x0121 state qos len 15
bluetoothd[197722]: src/shared/bap.c:ep_status_qos() CIG 0x00 CIS 0x00 
interval 10000 framing 0x00 phys 0x02 rtn 2 latency 10 pd 40000
bluetoothd[197722]: profiles/audio/media.c:pac_config() endpoint 
0x50f000000f40 stream 0x50e000008540
bluetoothd[197722]: [signal] 
org.freedesktop.DBus.ObjectManager.InterfacesAdded
bluetoothd[197722]: [:1.493:method_call] < 
org.bluez.MediaEndpoint1.SetConfiguration
bluetoothd[197722]: profiles/audio/media.c:media_endpoint_async_call() 
Calling SetConfiguration: name = :1.493 path = /local/endpoint/ep1
bluetoothd[197722]: src/shared/bap.c:bap_stream_update_io_links() stream 
0x50e000008540
bluetoothd[197722]: profiles/audio/bap.c:bap_state() stream 
0x50e000008540: config(1) -> qos(2)
bluetoothd[197722]: profiles/audio/bap.c:bap_config_setup_cb() setup 
0x50f0000018a0 code 0 remain 1
bluetoothd[197722]: profiles/audio/transport.c:bap_state_changed() 
stream 0x50e000008540: config(1) -> qos(2)
bluetoothd[197722]: 
profiles/audio/transport.c:transport_update_playing() 
/org/bluez/hci0/dev_9C_47_2A_39_56_FE/pac_sink0/fd0 
State=TRANSPORT_STATE_IDLE Playing=0
bluetoothd[197722]: profiles/audio/bap.c:bap_update_cig() adapter 
0x513000000200 CIG 0x0
bluetoothd[197722]: profiles/audio/bap.c:bap_update_cig() setup 
0x50f0000017b0 stream 0x50e000008460 readying
bluetoothd[197722]: src/shared/att.c:can_read_data() (chan 
0x508000010d20) ATT PDU received: 0x1b
bluetoothd[197722]: src/shared/bap.c:bap_ep_set_status() ASE status: ep 
0x504000021a50 id 0x0a handle 0x0127 state qos len 15
bluetoothd[197722]: src/shared/bap.c:ep_status_qos() CIG 0x00 CIS 0x00 
interval 10000 framing 0x00 phys 0x02 rtn 2 latency 10 pd 40000
bluetoothd[197722]: profiles/audio/media.c:pac_config() endpoint 
0x50f000000d60 stream 0x50e000008460
bluetoothd[197722]: [signal] 
org.freedesktop.DBus.ObjectManager.InterfacesAdded
bluetoothd[197722]: [:1.493:method_call] < 
org.bluez.MediaEndpoint1.SetConfiguration
bluetoothd[197722]: profiles/audio/media.c:media_endpoint_async_call() 
Calling SetConfiguration: name = :1.493 path = /local/endpoint/ep0
bluetoothd[197722]: src/shared/bap.c:bap_stream_update_io_links() stream 
0x50e000008460
bluetoothd[197722]: profiles/audio/bap.c:bap_state() stream 
0x50e000008460: config(1) -> qos(2)
bluetoothd[197722]: profiles/audio/bap.c:bap_config_setup_cb() setup 
0x50f0000017b0 code 0 remain 0
bluetoothd[197722]: profiles/audio/transport.c:bap_state_changed() 
stream 0x50e000008460: config(1) -> qos(2)
bluetoothd[197722]: 
profiles/audio/transport.c:transport_bap_update_links_uc() stream 
0x50e000008540 linked true
bluetoothd[197722]: 
profiles/audio/transport.c:transport_bap_update_links_uc() stream 
0x50e000008460 linked true
bluetoothd[197722]: 
profiles/audio/transport.c:transport_update_playing() 
/org/bluez/hci0/dev_9C_47_2A_39_56_FE/pac_source0/fd1 
State=TRANSPORT_STATE_IDLE Playing=0
bluetoothd[197722]: profiles/audio/bap.c:bap_update_cig() adapter 
0x513000000200 CIG 0x0
bluetoothd[197722]: [signal] 
org.freedesktop.DBus.Properties.PropertiesChanged
bluetoothd[197722]: [signal] 
org.freedesktop.DBus.Properties.PropertiesChanged
bluetoothd[197722]: [0x511000013a00] 
src/shared/gatt-client.c:discover_primary_cb() Primary services found: 6
bluetoothd[197722]: [0x511000013a00] 
src/shared/gatt-client.c:discovery_parse_services() start: 0x0001, end: 
0x000f, uuid: 00001800-0000-1000-8000-00805f9b34fb
bluetoothd[197722]: [0x511000013a00] 
src/shared/gatt-client.c:discovery_parse_services() start: 0x0040, end: 
0x0047, uuid: 00001801-0000-1000-8000-00805f9b34fb
bluetoothd[197722]: [0x511000013a00] 
src/shared/gatt-client.c:discovery_parse_services() start: 0x0080, end: 
0x0099, uuid: 0000180a-0000-1000-8000-00805f9b34fb
bluetoothd[197722]: [0x511000013a00] 
src/shared/gatt-client.c:discovery_parse_services() start: 0x00d0, end: 
0x00e2, uuid: 00001850-0000-1000-8000-00805f9b34fb
bluetoothd[197722]: [0x511000013a00] 
src/shared/gatt-client.c:discovery_parse_services() start: 0x0120, end: 
0x012f, uuid: 0000184e-0000-1000-8000-00805f9b34fb
bluetoothd[197722]: [0x511000013a00] 
src/shared/gatt-client.c:discovery_parse_services() start: 0x0160, end: 
0x0165, uuid: 0000184f-0000-1000-8000-00805f9b34fb
bluetoothd[197722]: [0x511000013a00] 
src/shared/gatt-client.c:write_client_features() Writing Client Features 
0x05
bluetoothd[197722]: src/device.c:gatt_client_ready_cb() status: success, 
error: 10
bluetoothd[197722]: profiles/ranging/rap.c:rap_accept() 9C:47:2A:39:56:FE
bluetoothd[197722]: profiles/ranging/rap.c:rap_accept() RAP unable to attach
bluetoothd[197722]: src/service.c:service_accept() rap profile accept 
failed for 9C:47:2A:39:56:FE
bluetoothd[197722]: src/gatt-client.c:btd_gatt_client_ready() GATT 
client ready
bluetoothd[197722]: src/gatt-client.c:create_services() Exporting 
objects for GATT services: 9C:47:2A:39:56:FE
bluetoothd[197722]: src/gatt-client.c:btd_gatt_client_ready() Features 0x05
bluetoothd[197722]: src/device.c:device_svc_resolved() 
/org/bluez/hci0/dev_9C_47_2A_39_56_FE err 0
bluetoothd[197722]: [signal] 
org.freedesktop.DBus.Properties.PropertiesChanged
bluetoothd[197722]: [0x511000013a00] 
src/shared/gatt-client.c:service_changed_register_cb() Registered 
handler for "Service Changed": 1
bluetoothd[197722]: [:1.493:method_call] > 
org.freedesktop.DBus.Properties.Set [#21661]
bluetoothd[197722]: src/shared/bap.c:stream_unlink_ucast() stream 
0x50e000008460 unlink
bluetoothd[197722]: src/shared/bap.c:bap_ucast_io_unlink() stream 
0x50e000008540 unlink
bluetoothd[197722]: 
profiles/audio/transport.c:transport_bap_update_links_uc() stream 
0x50e000008540 linked false
bluetoothd[197722]: src/shared/bap.c:bap_ucast_io_unlink() stream 
0x50e000008460 unlink
bluetoothd[197722]: 
profiles/audio/transport.c:transport_bap_update_links_uc() stream 
0x50e000008460 linked false
bluetoothd[197722]: [signal] 
org.freedesktop.DBus.Properties.PropertiesChanged
bluetoothd[197722]: [signal] 
org.freedesktop.DBus.Properties.PropertiesChanged
bluetoothd[197722]: [:1.493:method_return] < [#21661]
bluetoothd[197722]: [:1.493:method_call] > 
org.bluez.MediaTransport1.Acquire [#21662]
bluetoothd[197722]: profiles/audio/transport.c:media_owner_create() 
Owner created: sender=:1.493
bluetoothd[197722]: profiles/audio/transport.c:media_transport_resume() 
Transport /org/bluez/hci0/dev_9C_47_2A_39_56_FE/pac_source0/fd1 Owner :1.493
bluetoothd[197722]: src/shared/bap.c:bap_queue_req() req 0x506000052580 
(op 0x03) queue 0x503000033a00
bluetoothd[197722]: profiles/audio/transport.c:transport_set_state() 
State changed /org/bluez/hci0/dev_9C_47_2A_39_56_FE/pac_source0/fd1: 
TRANSPORT_STATE_IDLE -> TRANSPORT_STATE_REQUESTING
bluetoothd[197722]: profiles/audio/transport.c:media_request_create() 
Request created: method=Acquire id=19
bluetoothd[197722]: profiles/audio/transport.c:media_owner_add() Owner 
:1.493 Request Acquire
bluetoothd[197722]: 
profiles/audio/transport.c:media_transport_set_owner() Transport 
/org/bluez/hci0/dev_9C_47_2A_39_56_FE/pac_source0/fd1 Owner :1.493
bluetoothd[197722]: src/shared/bap.c:bap_process_queue()
bluetoothd[197722]: src/shared/bap.c:bap_send() req 0x506000052580 len 8
bluetoothd[197722]: src/shared/att.c:can_read_data() (chan 
0x508000010d20) ATT PDU received: 0x1b
bluetoothd[197722]: src/shared/bap.c:bap_process_queue()
bluetoothd[197722]: src/shared/att.c:can_read_data() (chan 
0x508000010d20) ATT PDU received: 0x1b
bluetoothd[197722]: src/shared/bap.c:bap_ep_set_status() ASE status: ep 
0x504000021a50 id 0x0a handle 0x0127 state enabling len 7
bluetoothd[197722]: src/shared/bap.c:ep_status_metadata() CIS 0x00 CIG 
0x00 metadata len 4
bluetoothd[197722]: profiles/audio/bap.c:bap_state() stream 
0x50e000008460: qos(2) -> enabling(3)
bluetoothd[197722]: profiles/audio/transport.c:bap_state_changed() 
stream 0x50e000008460: qos(2) -> enabling(3)
bluetoothd[197722]: profiles/audio/bap.c:bap_update_cig() adapter 
0x513000000200 CIG 0x0
bluetoothd[197722]: profiles/audio/bap.c:update_cig_setup_enable() 
0x50f0000017b0
bluetoothd[197722]: profiles/audio/bap.c:setup_create_io() setup 
0x50f0000017b0 stream 0x50e000008460 defer false
bluetoothd[197722]: src/shared/bap.c:bt_bap_stream_io_get_qos() in 
0x50e000008498 out (nil)
bluetoothd[197722]: profiles/audio/bap.c:setup_accept_io() stream 
0x50e000008460 fd 26 defer true
bluetoothd[197722]: profiles/audio/bap.c:iso_connect_cb() ISO connected

>> +                */
>> +               data.chan = chan;
>> +               data.err = err;
>> +               data.cig_id = setup->qos.ucast.cig_id;
>> +               queue_find(setup->ep->data->snks, find_enabling_ep, &data);
>> +               queue_find(setup->ep->data->srcs, find_enabling_ep, &data);
>> +               return;
>> +       }
>> +
>>          iso_connect_cb(chan, err, setup->stream);
>>   }
>>
>> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
>> index d9feef768..794c492af 100644
>> --- a/profiles/audio/transport.c
>> +++ b/profiles/audio/transport.c
>> @@ -37,6 +37,7 @@
>>   #include "src/shared/bap.h"
>>   #include "src/shared/bass.h"
>>   #include "src/shared/io.h"
>> +#include "src/btd.h"
>>
>>   #ifdef HAVE_A2DP
>>   #include "avdtp.h"
>> @@ -114,6 +115,7 @@ struct bap_transport {
>>   struct media_transport_ops {
>>          const char *uuid;
>>          const GDBusPropertyTable *properties;
>> +       const GDBusPropertyTable *test_properties;
>>          void (*set_owner)(struct media_transport *transport,
>>                                  struct media_owner *owner);
>>          void (*remove_owner)(struct media_transport *transport,
>> @@ -1417,6 +1419,9 @@ static struct media_transport *find_transport_by_path(const char *path)
>>          return NULL;
>>   }
>>
>> +static void bap_update_links(const struct media_transport *transport);
>> +static void transport_unlink(void *data, void *user_data);
>> +
>>   static void set_links(const GDBusPropertyTable *property,
>>                                  DBusMessageIter *iter,
>>                                  GDBusPendingPropertySet id, void *user_data)
>> @@ -1434,6 +1439,16 @@ static void set_links(const GDBusPropertyTable *property,
>>
>>          dbus_message_iter_recurse(iter, &array);
>>
>> +       if (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_INVALID) {
>> +               struct queue *links = bt_bap_stream_io_get_links(bap->stream);
>> +
>> +               /* Unlink stream from all its links */
>> +               queue_foreach(links, transport_unlink, bap->stream);
>> +
>> +               bt_bap_stream_io_unlink(bap->stream, NULL);
>> +               bap_update_links(transport);
>> +       }
>> +
>>          while (dbus_message_iter_get_arg_type(&array) ==
>>                                                  DBUS_TYPE_OBJECT_PATH) {
>>                  struct media_transport *link;
>> @@ -1484,6 +1499,21 @@ static const GDBusPropertyTable transport_bap_uc_properties[] = {
>>          { }
>>   };
>>
>> +static const GDBusPropertyTable transport_bap_uc_test_properties[] = {
>> +       { "Device", "o", get_device },
>> +       { "UUID", "s", get_uuid },
>> +       { "Codec", "y", get_codec },
>> +       { "Configuration", "ay", get_configuration },
>> +       { "State", "s", get_state },
>> +       { "QoS", "a{sv}", get_ucast_qos, NULL, qos_ucast_exists },
>> +       { "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
>> +       { "Location", "u", get_location },
>> +       { "Metadata", "ay", get_metadata, set_metadata },
>> +       { "Links", "ao", get_links, set_links, links_exists },
>> +       { "Volume", "q", get_volume, set_volume, volume_exists },
>> +       { }
>> +};
>> +
>>   static gboolean get_bcast_qos(const GDBusPropertyTable *property,
>>                                          DBusMessageIter *iter, void *data)
>>   {
>> @@ -1879,8 +1909,6 @@ static void bap_resume_complete(struct media_transport *transport)
>>          transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
>>   }
>>
>> -static void bap_update_links(const struct media_transport *transport);
>> -
>>   static bool match_link_transport(const void *data, const void *user_data)
>>   {
>>          const struct bt_bap_stream *stream = data;
>> @@ -2535,10 +2563,11 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
>>   #define TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner, _init, \
>>                        _resume, _suspend, _cancel, _set_state, _get_stream, \
>>                        _get_volume, _set_volume, _set_delay, _update_links, \
>> -                     _destroy) \
>> +                     _destroy, _test_props) \
>>   { \
>>          .uuid = _uuid, \
>>          .properties = _props, \
>> +       .test_properties = _test_props, \
>>          .set_owner = _set_owner, \
>>          .remove_owner = _remove_owner, \
>>          .init = _init, \
>> @@ -2560,26 +2589,28 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
>>                          transport_a2dp_resume, transport_a2dp_suspend, \
>>                          transport_a2dp_cancel, NULL, \
>>                          transport_a2dp_get_stream, transport_a2dp_get_volume, \
>> -                       _set_volume, _set_delay, NULL, _destroy)
>> +                       _set_volume, _set_delay, NULL, _destroy, NULL)
>>
>>   #define BAP_OPS(_uuid, _props, _set_owner, _remove_owner, _update_links, \
>> -               _set_state) \
>> +               _set_state, _test_props) \
>>          TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner,\
>>                          transport_bap_init, \
>>                          transport_bap_resume, transport_bap_suspend, \
>>                          transport_bap_cancel, _set_state, \
>>                          transport_bap_get_stream, transport_bap_get_volume, \
>>                          transport_bap_set_volume, NULL, \
>> -                       _update_links, transport_bap_destroy)
>> +                       _update_links, transport_bap_destroy, _test_props)
>>
>>   #define BAP_UC_OPS(_uuid) \
>>          BAP_OPS(_uuid, transport_bap_uc_properties, \
>>                          transport_bap_set_owner, transport_bap_remove_owner, \
>> -                       transport_bap_update_links_uc, transport_bap_set_state)
>> +                       transport_bap_update_links_uc, \
>> +                       transport_bap_set_state, \
>> +                       transport_bap_uc_test_properties)
>>
>>   #define BAP_BC_OPS(_uuid) \
>>          BAP_OPS(_uuid, transport_bap_bc_properties, NULL, NULL, \
>> -                       transport_bap_update_links_bc, NULL)
>> +                       transport_bap_update_links_bc, NULL, NULL)
>>
>>   #define ASHA_OPS(_uuid) \
>>          TRANSPORT_OPS(_uuid, transport_asha_properties, NULL, NULL, \
>> @@ -2587,7 +2618,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
>>                          transport_asha_resume, transport_asha_suspend, \
>>                          transport_asha_cancel, NULL, NULL, \
>>                          transport_asha_get_volume, transport_asha_set_volume, \
>> -                       NULL, NULL, NULL)
>> +                       NULL, NULL, NULL, NULL)
>>
>>   static const struct media_transport_ops transport_ops[] = {
>>   #ifdef HAVE_A2DP
>> @@ -2642,6 +2673,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
>>          struct media_transport *transport;
>>          const struct media_transport_ops *ops;
>>          int fd;
>> +       const GDBusPropertyTable *properties;
>>
>>          transport = g_new0(struct media_transport, 1);
>>          if (device)
>> @@ -2696,9 +2728,14 @@ struct media_transport *media_transport_create(struct btd_device *device,
>>                          goto fail;
>>          }
>>
>> +       if (btd_opts.testing && ops->test_properties)
>> +               properties = ops->test_properties;
>> +       else
>> +               properties = ops->properties;
>> +
>>          if (g_dbus_register_interface(btd_get_dbus_connection(),
>>                                  transport->path, MEDIA_TRANSPORT_INTERFACE,
>> -                               transport_methods, NULL, ops->properties,
>> +                               transport_methods, NULL, properties,
>>                                  transport, media_transport_free) == FALSE) {
>>                  error("Could not register transport %s", transport->path);
>>                  goto fail;
>> --
>> 2.43.0
>>
>>
>

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718


