Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.28])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414DD399
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Dec 2023 00:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="InKlNAaN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=DnJxDhvv2WZyysfvKOCjgrze8pIlMzSwn5P3iw1y374=;
	b=InKlNAaNSGr9/QsfktDvwPmAfBzsvVTu2dvspnAxl3f6VPxhgkpB6HXoMDm0Ue
	HAxnlmJuUjZSFdynCla0HD0mLBbahoKv99Tn0mrptvMCh7wtCAWpg86e5C6pBO+V
	t18+fo8k8+UG4q3QF9w1jQfAaeSeUG/0JzyIntxJtruzo=
Received: from [192.168.50.76] (unknown [58.22.7.114])
	by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wD3f6tpEY5lqmNoEg--.55896S2;
	Fri, 29 Dec 2023 08:23:08 +0800 (CST)
Message-ID: <0e4b35f8-1b40-4f9c-b600-ff9e2a5e74a8@126.com>
Date: Fri, 29 Dec 2023 08:23:06 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 1/1] avdtp: fix incorrect transaction label in
 setconf phase
Content-Language: en-GB
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Xiao Yao <xiaoyao@rock-chips.com>
References: <20231228135206.1949453-1-xiaokeqinhealth@126.com>
 <CABBYNZLVZOJ6uAJdu876S5=jb1CeAX_ajn7jAUCurWdDOcKotQ@mail.gmail.com>
From: Yao Xiao <xiaokeqinhealth@126.com>
In-Reply-To: <CABBYNZLVZOJ6uAJdu876S5=jb1CeAX_ajn7jAUCurWdDOcKotQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f6tpEY5lqmNoEg--.55896S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr18ZF13Kw4fZw48uFWrAFb_yoW7Gr1xpF
	WI9F18JFWkXr15AFn2q3y5uF12q39YyrZ8WryYv3sIy3ZIk3Z8tryvyry0ka90vr1ruw1Y
	vryqg3saqw4q93DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZ4SwUUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbimgxV1WVLZHWpDAAAsM

Hi,
On 2023/12/29 0:05, Luiz Augusto von Dentz wrote:
> Hi,
>
> On Thu, Dec 28, 2023 at 9:07 AM Xiao Yao <xiaokeqinhealth@126.com> wrote:
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
>> AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label 6 nosp 0
>> AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 7 nosp 0
>> AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label 7 nosp 0
>>
>> < AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 8 nosp 0
>> //Currently, a 'set configuration' message has been received from the
>> //sender, which contains a transaction label valued at 8. This message
>> //was then relayed to A2DP backend(PulseAudio/PipeWire) using the dbus
>> //interface.
>>      ---
>>      set_configuration()(media.c)
>>          msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
>>                                                  MEDIA_ENDPOINT_INTERFACE,
>>                                                  "SetConfiguration");
>>          media_endpoint_async_call()
>>          //dbus send
>>          g_dbus_send_message_with_reply(btd_get_dbus_connection(),
>>                                                  msg, &request->call,
>>                                                  REQUEST_TIMEOUT(3 seconds))
>>          dbus_pending_call_set_notify(request->call, endpoint_reply, request,NULL);
>>          ...
>>
>>> AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
>> //At this time, the A2DP reverse discovery issued an A2DP discover command.
>> < AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 0 nosp 0
>> //After receiving the discover reply, the session->in.transaction is
>> //changed to 0
>>
>>> AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 label 0 nosp 0
>> //The audio backend reply the dbus message
>>      endpoint_reply (media.c)
>>          setconf_cb (avdtp.c)
>>              //Here avdtp_send sends an incorrect transaction value, causing
>>              //the sender to discard the message. (The correct transaction
>>              //value is 8)
>>              avdtp_send(session, session->in.transaction, AVDTP_MSG_TYPE_ACCEPT,
>>                                          AVDTP_SET_CONFIGURATION, NULL, 0)
>>
>> AVDTP: Delay Report (0x0d) Command (0x00) type 0x00 label 1 nosp 0
>> AVDTP: Delay Report (0x0d) Response Accept (0x02) type 0x00 label 1 nosp 0
>> AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 2 nosp 0
>> AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label 2 nosp 0
>> ... ...
>>
>> Therefore, a async_transaction that requires asynchronous return is
>> recorded to prevent it from being incorrectly modified.
>>
>> Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
>> ---
>>   profiles/audio/avdtp.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
>> index 10ef380d4..2171e7723 100644
>> --- a/profiles/audio/avdtp.c
>> +++ b/profiles/audio/avdtp.c
>> @@ -286,6 +286,7 @@ struct in_buf {
>>          gboolean active;
>>          int no_of_packets;
>>          uint8_t transaction;
>> +       uint8_t async_transaction;
> You can only have one transaction in each direction, so this doesn't
> look right at all. What perhaps is the problem is that we are changing
> the transaction ID also in case of responses in which case we need to
> fix that.
I committed an error during the patch optimization process by altering
the original label, which was incorrect.I will be sending a v2 patch.
>
>>          uint8_t message_type;
>>          uint8_t signal_id;
>>          uint8_t buf[1024];
>> @@ -1459,6 +1460,9 @@ static void setconf_cb(struct avdtp *session, struct avdtp_stream *stream,
>>          struct conf_rej rej;
>>          struct avdtp_local_sep *sep;
>>
>> +       if (session->in.transaction != session->in.async_transaction)
>> +               session->in.transaction = session->in.async_transaction;
>> +
>>          if (err != NULL) {
>>                  rej.error = AVDTP_UNSUPPORTED_CONFIGURATION;
>>                  rej.category = err->err.error_code;
>> @@ -1569,6 +1573,7 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
>>                  session->version = 0x0103;
>>
>>          if (sep->ind && sep->ind->set_configuration) {
>> +               session->in.async_transaction = transaction;
>>                  if (!sep->ind->set_configuration(session, sep, stream,
>>                                                          stream->caps,
>>                                                          setconf_cb,
>> --
>> 2.34.1
>>
>>
>

