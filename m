Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17B41C6AB
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="OeJeSTHb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=wiazpNLm5W9rnpxJszNVCXoQPVF4gm9Q3w5EGebJyhM=;
	b=OeJeSTHb3rYcvwZTsPIZCBbUBd2fDiiOL3p6968C9gl2+oNJ/WGpuc4IIvaOPV
	ZMJdhZG3S6Stgoh7q56UryZxQoTyQjCJHUqrNf7j5/NhniJ3/CWAnNXnvQMrEgho
	3XtM+rGqgoco4mxfM1x6SKorSgpviD3mbLPknUh4hTgwY=
Received: from [192.168.50.76] (unknown [58.22.7.114])
	by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wDHz39CqpVlE8FHAA--.59328S2;
	Thu, 04 Jan 2024 02:41:08 +0800 (CST)
Message-ID: <5df7515e-5785-400c-8e29-42fc88cef0c6@126.com>
Date: Thu, 4 Jan 2024 02:41:06 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v3 1/2] avdtp: fix incorrect transaction label in
 setconf phase
Content-Language: en-GB
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Xiao Yao <xiaoyao@rock-chips.com>
References: <20240103143904.77146-1-xiaokeqinhealth@126.com>
 <CABBYNZLo9CVZsjvzjKsGKFyhOkrWoyWYL8bQoSfvTDf=PAQ-iw@mail.gmail.com>
From: Yao Xiao <xiaokeqinhealth@126.com>
In-Reply-To: <CABBYNZLo9CVZsjvzjKsGKFyhOkrWoyWYL8bQoSfvTDf=PAQ-iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHz39CqpVlE8FHAA--.59328S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF17Cr17Kw4xZr17Ww1UGFg_yoW7tF48pF
	WIgF18JFykXr15AFsaq3909F4Iqrs3trZ8GrWYqr9IyanxCa4UtFy0yrWjka90vr1fCw1Y
	vFyqg3sagw4qk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwXo7UUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbimgVa1WVLZNthOAABsZ

Hi,
On 2024/1/3 23:38, Luiz Augusto von Dentz wrote:
> Hi,
>
> On Wed, Jan 3, 2024 at 9:40 AM Xiao Yao <xiaokeqinhealth@126.com> wrote:
>> From: Xiao Yao <xiaoyao@rock-chips.com>
>>
>> BLUETOOTH SPECIFICATION Page 61 of 140
>> Audio/Video Distribution Transport Protocol Specification (V13)
>> 8.4.6 Message integrity verification at receiver side
>>
>> - The receiver of an AVDTP signaling message shall not interpret corrupted
>> messages. Those messages are discarded and no signaling message is returned
>> to the sender if no error code is applicable. Possible corrupted messages
>> are:
>>
>>    * Response messages where the transaction label cannot match a previous
>>      command sent to the remote device
>>
>> Consider the following scenario:
>> btmon log:
>> ... ...
>> AVDTP: Discover (0x01) Command (0x00) type 0x00 label 5 nosp 0
>> AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 5 nosp 0
>> AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 6 nosp 0
>> AVDTP: Get All Capabilities (0x0c) Resp Accept (0x02) type 0 label 6 nosp 0
>> AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 7 nosp 0
>> AVDTP: Get All Capabilities (0x0c) Resp Accept (0x02) type 0 label 7 nosp 0
>>
>> < AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 8 nosp 0
>> //Currently, a 'set configuration' message has been received from the
>> //sender, which contains a transaction label valued at 8. This message
>> //was then relayed to A2DP backend(PulseAudio/PipeWire) using the dbus
>> //interface.
>>    set_configuration()(media.c)
>>      dbus_message_new_method_call(..., "SetConfiguration", ...);
>>      g_dbus_send_message_with_reply(btd_get_dbus_connection(), ...);
>>      dbus_pending_call_set_notify(request->call, endpoint_reply, ...);
>>      ...
>>
>>> AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
>> //At this time, the A2DP reverse discovery issued an A2DP discover command.
>> < AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 0 nosp 0
>> //After receiving the discover reply, the session->in.transaction is
>> //changed to 0
>>
>>> AVDTP: Set Configuration (0x03) Resp Accept (0x02) type 0 label 0 nosp 0
>> //The audio backend reply the dbus message
>>    endpoint_reply (media.c)
>>      setconf_cb (avdtp.c)
>>        //Here avdtp_send sends an incorrect transaction value, causing
>>        //the sender to discard the message. (The correct transaction
>>        //value is 8)
>>        avdtp_send(session, session->in.transaction, AVDTP_MSG_TYPE_ACCEPT,
>>                   AVDTP_SET_CONFIGURATION, NULL, 0)
>>
>> AVDTP: Delay Report (0x0d) Command (0x00) type 0x00 label 1 nosp 0
>> AVDTP: Delay Report (0x0d) Response Accept (0x02) type 0x00 label 1 nosp 0
>> AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 2 nosp 0
>> AVDTP: Get All Capabilities (0x0c) Resp Accept (0x02) type 0 label 2 nosp 0
>> ... ...
>>
>> Therefore, a async_transaction that requires asynchronous return is
>> recorded to prevent it from being incorrectly modified.
>>
>> Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
>> ---
>> v1 -> v2: Fixed "session->in.transaction" logic err.
>> v2 -> v3: Fixed some compile warnings
>> ---
>>   profiles/audio/avdtp.c | 19 ++++++++++++++-----
>>   1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
>> index 10ef380d4..386c7f67c 100644
>> --- a/profiles/audio/avdtp.c
>> +++ b/profiles/audio/avdtp.c
>> @@ -286,6 +286,7 @@ struct in_buf {
>>          gboolean active;
>>          int no_of_packets;
>>          uint8_t transaction;
>> +       uint8_t async_transaction;
> Didn't I already explain it already that we are not supposed to have 2
> outstanding transactions?
Apologies for the misunderstanding earlier. When you mentioned 
'outstanding transactions',
were you referring to a complete configuration process, rather than a 
single command?
Can I understand it this way: An a2dp discovery command should not be 
sent before responding
to the AVDTP_MSG_TYPE_ACCEPT message? Is it only after sending the 
AVDTP_MSG_TYPE_ACCEPT
response to the remote device that I can proceed with the a2dp discovery?
>
>>          uint8_t message_type;
>>          uint8_t signal_id;
>>          uint8_t buf[1024];
>> @@ -1462,15 +1463,16 @@ static void setconf_cb(struct avdtp *session, struct avdtp_stream *stream,
>>          if (err != NULL) {
>>                  rej.error = AVDTP_UNSUPPORTED_CONFIGURATION;
>>                  rej.category = err->err.error_code;
>> -               avdtp_send(session, session->in.transaction,
>> -                               AVDTP_MSG_TYPE_REJECT, AVDTP_SET_CONFIGURATION,
>> -                               &rej, sizeof(rej));
>> +               avdtp_send(session, session->in.async_transaction,
>> +                          AVDTP_MSG_TYPE_REJECT, AVDTP_SET_CONFIGURATION,
>> +                          &rej, sizeof(rej));
>>                  stream_free(stream);
>>                  return;
>>          }
>>
>> -       if (!avdtp_send(session, session->in.transaction, AVDTP_MSG_TYPE_ACCEPT,
>> -                                       AVDTP_SET_CONFIGURATION, NULL, 0)) {
>> +       if (!avdtp_send(session, session->in.async_transaction,
>> +                       AVDTP_MSG_TYPE_ACCEPT,
>> +                       AVDTP_SET_CONFIGURATION, NULL, 0)) {
>>                  stream_free(stream);
>>                  return;
>>          }
>> @@ -1569,6 +1571,13 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
>>                  session->version = 0x0103;
>>
>>          if (sep->ind && sep->ind->set_configuration) {
>> +               /* The setconfig configuration stage is asynchronous;
>> +                * high CPU load or other factors can delay dbus message
>> +                * responses, potentially altering the transaction value.
>> +                * It's essential to record the received transaction value
>> +                * for use in the final accept command.
>> +                */
>> +               session->in.async_transaction = transaction;
>>                  if (!sep->ind->set_configuration(session, sep, stream,
>>                                                          stream->caps,
>>                                                          setconf_cb,
>>
>> base-commit: 7ad5669402c9acff8e4cc808edc12a41df36654e
>> --
>> 2.34.1
>>
>>
>

