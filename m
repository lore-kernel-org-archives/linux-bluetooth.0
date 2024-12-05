Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4DA1DC19F
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Dec 2024 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396468; cv=none; b=WR98DQRqylXf2C6pNFZeG87tjLHSziBsebIDu/U8D6ZjVZkOCI1fcFAyVobSLL5fKcMq198zKdOZWY7HnN/MXtEYPuVBXTTWd9Q2PYDWNuFRkQeML0SGrZ1O2/fTgI0bUFOsaNpFKQ704r+INenP/NtG3LdliAza4aCGXAVYjRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396468; c=relaxed/simple;
	bh=CnXHkh9UlLCnAYvmEto7UDGYeI5rHWFxC77zIZ6IkWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G4G0RN9EyChaoaTWTKkHWUp9LZOhODZ1FeE7t+wEFt6fhzdOjW0TFgTrBK279Myyp7wHngsNbrlbJbNvvLie0K9ZvoW/g/wm+qOsOG/856QV+Wr/JWr0PihnFWqE2GUKmuRxMwAJs6F11tRjmR5aP0XKF9pT9Uo0/2inbjeZj1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=urfmqPkl; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="urfmqPkl"
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 73C59100016;
	Thu,  5 Dec 2024 13:51:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 73C59100016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1733395909;
	bh=NkbzwcTwHsaPgCIVxoyaHP3/GoUd1RROhkQcSJJug8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=urfmqPklJptzpspfVBtQKdTewXcZW4jegd+Gp6H+cTZzFT7rrRESq7UZ5K4U/3mle
	 TRY0Ml/uQvqhYTc1WOKWr9Wwji18cqB2OdWnMW0Q2h9fCBaT27AfQbUcq+ULlVNEvX
	 +26Gv9S9eTtof1UQ3lpthixKaO3rcdYstsAPG3dp95jiTfQ/elwV/EyRUTplOrgl3a
	 T6lIrSo46X1tazKLo5enpd9e2cQY/wMT039W0NkYpvtV7GUl7MNdMUzY7rc+6Yv0rs
	 Huk/wPFitxht3sxXrDO9utqc8jiuxn+0CXVqqT+bJmHTlryH1yyHiakZhLbqQtcOLi
	 TPBzoDFlmgDyQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu,  5 Dec 2024 13:51:49 +0300 (MSK)
Message-ID: <975340fe-dae9-4832-91aa-49a5738d2328@salutedevices.com>
Date: Thu, 5 Dec 2024 13:51:46 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 2/2] a2dp: Reject incoming connection when channel
 limit is exceeded
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <corvinus.v@gmail.com>
References: <20241107220121.97417-1-VAnPushkarev@salutedevices.com>
 <20241107220121.97417-3-VAnPushkarev@salutedevices.com>
 <CABBYNZJp9qmPY2YtNP9JsbuMk1e_-MnJMdBoZZd0kGsSvwMqBQ@mail.gmail.com>
Content-Language: ru
From: Victor Pushkarev <VAnPushkarev@salutedevices.com>
In-Reply-To: <CABBYNZJp9qmPY2YtNP9JsbuMk1e_-MnJMdBoZZd0kGsSvwMqBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189644 [Dec 05 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: vanpushkarev@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 44 0.3.44 5149b91aab9eaefa5f6630aab0c7a7210c633ab6, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/12/05 06:31:00 #26939149
X-KSMG-AntiVirus-Status: Clean, skipped

Hi, Luiz!

> This is a global limit?

Yes, the limit is global, to be able to disable/configure the behavior
via conf file.

> Not really following the reasoning here, if
> the platform don't want to connect to more devices just don't connect
> them

In this case, the patch solves the problem with audio mixing from
multiple sources via A2DP when the sink device is for example
a bluetooth speaker.

> make the endpoints return an error to SetConfiguration

Which I tried to do, but probably not too architecturally correct.
This patch works, but I would like to find the most correct
solution or implement it for everyone's benefit.

> There are so many ways to block this that I
> don't really feel like introducing a new one will do us any good.

In that case, could you please guide me - which option should I use
to limit the number of A2DP connections?
I haven't found a suitable setting or option that solves the problem
of multiple simultaneous A2DP connections..

Thank you in advance.

08.11.2024 02:01, Luiz Augusto von Dentz пишет:
> Hi Victor,
>
> On Thu, Nov 7, 2024 at 5:10 PM Victor Pushkarev
> <VAnPushkarev@salutedevices.com> wrote:
>> Add counting of active audio streams at MediaEndpoint level.
>>
>> Reject incoming connection at the audio stream setting stage
>> when the configured A2DP channel limit is exceeded.
>>
>> ---
>>   profiles/audio/a2dp.c  |  9 +++++++++
>>   profiles/audio/media.c | 11 +++++++++++
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
>> index c97bd6e89..935873d07 100644
>> --- a/profiles/audio/a2dp.c
>> +++ b/profiles/audio/a2dp.c
>> @@ -716,6 +716,15 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
>>                          return TRUE;
>>                  }
>>
>> +               if (ret == -1) {
>> +                       /* Reject connection from SEP
>> +                       * and clear configuration.
>> +                       */
>> +                       DBG("Reject connection from %s", device_get_path(setup->chan->device));
>> +                       a2dp_sep->endpoint->clear_configuration(a2dp_sep, a2dp_sep->user_data);
>> +                       device_request_disconnect(setup->chan->device, NULL);
>> +               }
>> +
>>                  setup_error_init(setup, AVDTP_MEDIA_CODEC,
>>                                          AVDTP_UNSUPPORTED_CONFIGURATION);
>>                  setup_unref(setup);
>> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
>> index 746e538fc..20b860f6a 100644
>> --- a/profiles/audio/media.c
>> +++ b/profiles/audio/media.c
>> @@ -33,6 +33,7 @@
>>   #include "src/dbus-common.h"
>>   #include "src/profile.h"
>>   #include "src/service.h"
>> +#include "src/btd.h"
>>
>>   #include "src/uuid-helper.h"
>>   #include "src/log.h"
>> @@ -134,6 +135,7 @@ struct media_player {
>>   };
>>
>>   static GSList *adapters = NULL;
>> +static unsigned int active_streams;
>>
>>   static void endpoint_request_free(struct endpoint_request *request)
>>   {
>> @@ -302,6 +304,9 @@ done:
>>
>>   static void clear_endpoint(struct media_endpoint *endpoint)
>>   {
>> +       if (active_streams > 0)
>> +               active_streams--;
>> +
>>          media_endpoint_cancel_all(endpoint);
>>
>>          while (endpoint->transports != NULL)
>> @@ -659,6 +664,12 @@ static int set_config(struct a2dp_sep *sep, uint8_t *configuration,
>>          struct media_endpoint *endpoint = user_data;
>>          struct a2dp_config_data *data;
>>
>> +       active_streams++;
>> +       if (active_streams > btd_opts.a2dp.channels) {
>> +               DBG("A2DP channel limit (%u) exceeded", btd_opts.a2dp.channels);
>> +               return -1;
>> +       }
> This is a global limit? Not really following the reasoning here, if
> the platform don't want to connect to more devices just don't connect
> them, or in case of incoming connection don't authorize the
> connections, make the endpoints return an error to SetConfiguration,
> suspend the streams, etc. There are so many ways to block this that I
> don't really feel like introducing a new one will do us any good.
>
>>          data = g_new0(struct a2dp_config_data, 1);
>>          data->setup = setup;
>>          data->cb = cb;
>> --
>> 2.39.3 (Apple Git-146)
>>
>>
>
