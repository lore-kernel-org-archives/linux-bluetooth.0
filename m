Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E325100A
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="goB9pV01"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=VLNnZ77FwV1Z+gRyeZYyZ7hTqyr2mPiPelSIvtCsVEM=;
	b=goB9pV01ezGz4sJsILuTd60XvDqhB4oc+k/UiAHttt7aoDLdwTxc34wCxLbndh
	Fm0Be7vyuuIVuekGzn5zwQXpffRCq2S8XCnqdIKO8TEaPO1a26r8NYkU+b6Krpj4
	nXygs9uc9s2dLSH4yqHkFUQXW3/B4GkiOpIewpExf+D3E=
Received: from [192.168.50.76] (unknown [58.22.7.114])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3_6OXIKBlXWUyAA--.64902S2;
	Fri, 12 Jan 2024 01:08:43 +0800 (CST)
Message-ID: <c91cd086-4fff-45f4-9f6a-8fdee602f981@126.com>
Date: Fri, 12 Jan 2024 01:08:39 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v4 1/2] a2dp: fix incorrect transaction label in
 setconf phase
Content-Language: en-GB
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20240104171400.124128-1-xiaokeqinhealth@126.com>
 <CABBYNZJJdZTWBaq1KakyDpg67nx8peyzLgb29+UBd9UEsd5CaQ@mail.gmail.com>
From: Yao Xiao <xiaokeqinhealth@126.com>
In-Reply-To: <CABBYNZJJdZTWBaq1KakyDpg67nx8peyzLgb29+UBd9UEsd5CaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_6OXIKBlXWUyAA--.64902S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF17Cr1rGF48GF1fKFyDJrb_yoWxGryxpF
	WfuF1UJFWDJr1UAFZ2q398uF40q393tr1rGryYqrnIvwsIkFy3tFykt3yj9398CrWI9w4Y
	v3Wvg393Xr4qkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UdKs8UUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbimh1i1WVLZXTeKAAAs5

Hi Luiz,
On 2024/1/5 3:08, Luiz Augusto von Dentz wrote:
> Hi Xiao,
> On Thu, Jan 4, 2024 at 12:16 PM Xiao Yao <xiaokeqinhealth@126.com> wrote:
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
>> AVDTP: Discover (0x01) Command (0x00) type 0x00 label 5 nosp 0
>> ... ...
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
>> //The commit "02877c5e9" introduces a reverse discovery logic, resulting
>> //in a small probability that the discovery command is issued before the
>> //setconfig accept command.
>> //Tip: If an artificial delay is added to the audio backend, this issue
>> //will invariably occur."
>>> AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
>> //After receiving the discover reply, the session->in.transaction is
>> //changed to 0
>> < AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 0 nosp 0
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
>> ... ...
>>
>> Therefore, the reverse discovery logic was adjusted to the back of
>> setconfig accept to avoid two transmission transactions at the same
>> time and fixed the problem.
>>
>> Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
>> ---
>> v1 -> v2: Fixed "session->in.transaction" logic err.
>> v2 -> v3: Fixed some compile warnings
>> v3 -> v4: Adjust the timing of reverse discovery logic
>> ---
>>   profiles/audio/a2dp.c | 27 ++++++++++++++-------------
>>   1 file changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
>> index b43161a13..f4ef8aec2 100644
>> --- a/profiles/audio/a2dp.c
>> +++ b/profiles/audio/a2dp.c
>> @@ -586,6 +586,12 @@ done:
>>          return FALSE;
>>   }
>>
>> +static void reverse_discover(struct avdtp *session, GSList *seps, int err,
>> +                            void *user_data)
>> +{
>> +       DBG("err %d", err);
>> +}
>> +
>>   static void endpoint_setconf_cb(struct a2dp_setup *setup, gboolean ret)
>>   {
>>          if (ret == FALSE) {
>> @@ -595,6 +601,13 @@ static void endpoint_setconf_cb(struct a2dp_setup *setup, gboolean ret)
>>          }
>>
>>          auto_config(setup);
>> +
>> +       /* Attempt to reverse discover if there are no remote
>> +        * SEPs.
>> +        */
>> +       if (queue_isempty(setup->chan->seps))
>> +               a2dp_discover(setup->session, reverse_discover, NULL);
>> +
>>          setup_unref(setup);
>>   }
>>
>> @@ -634,12 +647,6 @@ static gboolean endpoint_match_codec_ind(struct avdtp *session,
>>          return TRUE;
>>   }
>>
>> -static void reverse_discover(struct avdtp *session, GSList *seps, int err,
>> -                                                       void *user_data)
>> -{
>> -       DBG("err %d", err);
>> -}
>> -
>>   static gboolean endpoint_setconf_ind(struct avdtp *session,
>>                                                  struct avdtp_local_sep *sep,
>>                                                  struct avdtp_stream *stream,
>> @@ -695,14 +702,8 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
>>                                                  setup_ref(setup),
>>                                                  endpoint_setconf_cb,
>>                                                  a2dp_sep->user_data);
>> -               if (ret == 0) {
>> -                       /* Attempt to reverse discover if there are no remote
>> -                        * SEPs.
>> -                        */
>> -                       if (queue_isempty(setup->chan->seps))
>> -                               a2dp_discover(session, reverse_discover, NULL);
> Have you actually test these changes with read devices? I would be
> really surprised if this works because you are essentially changing
> the reverse discover to when we do initiate AVDTP_SetConfiguration
> rather when we receive, which shall never need a reverse discover to
> begin with since we are initiating we always perform a discover
> anyway, so that most likely is dead code that will never going to
> executed.
Apologies for my delayed response due to other commitments.
Here is the original logic:
  < AVDTP_SetConfiguration_Ind
 > AVDTP_Discover(reverse)
  < AVDTP_SetConfiguration_Rsp

Here is the modified logic:
  < AVDTP_SetConfiguration_Ind
  > AVDTP_SetConfiguration_Rsp
  < AVDTP_Discover (reverse)
The endpoint_setconf_cb above is called after AVDTP_SetConfiguration_Rsp

My test scenario is that my device acts as a sink, and when the
mobile phone connects to my device, a2dp reverse discover will
be triggered on the first connection (subsequent reconnections
will not send the reverse process due to caching) and they work
very well.

If there are any errors in the description above, please point them out.
I would greatly appreciate it.
> The real culprit here is that both commands and responses are stored
> in the session.in while we should probably have a session.cmd and
> session.rsp to be able to handle outstanding requests in each
> direction.
Very good suggestion, I will send new patch.
>
>> +               if (ret == 0)
>>                          return TRUE;
>> -               }
>>
>>                  setup_unref(setup);
>>                  setup->err = g_new(struct avdtp_error, 1);
>> --
>> 2.34.1
>>
>>
>

