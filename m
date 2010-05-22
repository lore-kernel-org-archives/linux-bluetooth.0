Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1274444229.2051.118.camel@mosquito>
References: <1274350142-19083-1-git-send-email-sancane@gmail.com>
	 <AANLkTimv6CRgS-lPeadePxKXEmNmhEM7oLx-uTHuZfNF@mail.gmail.com>
	 <AANLkTimoISCAwCfv8zktLF7OxT0aT5glDAXYeFM0mUvF@mail.gmail.com>
	 <1274364281.2018.44.camel@mosquito>
	 <1274444229.2051.118.camel@mosquito>
Date: Sat, 22 May 2010 10:45:54 +0200
Message-ID: <AANLkTik_bTgQsuKf_04m_eaDvsD_21ZsC2WR1zETxWJz@mail.gmail.com>
Subject: Re: [PATCH] Fix device_match_pattern function
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Santiago Carot-Nemesio <scarot@libresoft.es>
Cc: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, May 21, 2010 at 2:17 PM, Santiago Carot-Nemesio
<scarot@libresoft.es> wrote:
> Hi Luiz,
>
> I would like to take up again this matter to discuss some estrange
> behaviour that we observed when a driver is probed.
>
>> At current moment only the
>> first one is being provided when driver is probed.
>
> Well, the comment in update_service function is clear when Service Class
> Id list is checked:
>
> /* Extract the first element and skip the remainning */
>
> I guess that only the first entry is valid to you to get the profile and
> add it to the profile list. We don't know very well why this decision
> was taken. It will very helpul for us if you can provide a brief
> explanation about that. Wouldn't a driver want to know if there are more
> entries in that Service Class ID List when it is probed?. For example a
> driver registering for two uuids and those uuids are present in the same
> Service Class ID List. Please notice that it is may happen in HDP. In
> this scenario only the first entry will appear in the profile list and
> then one uuid is passed to the driver when it is probed, well this is
> not true at all, see below for some abnormal behaviour with repeated
> uuids in the list that is provided to the driver.
>
> Let's suppose an SDP record like this:
> *Service Class ID List
>        MDPSink
>        MDPSource
> ....aditional info not relevant for this example....
>
> In that scenario, a driver is registered for next uuids:
> 00001400-0000-1000-8000-00805F9B34FB -> MDP (Health device profile)
> 00001401-0000-1000-8000-00805F9B34FB -> MDPSource
> 00001402-0000-1000-8000-00805F9B34FB -> MDPSink
>
> which is perfectly valid for a HDP driver due that no extra logic is
> required to manage both roles.
>
> In current Bluez implementation only profile MDPSink is taken in count
> due that it appear first in the service class ID list. In addition it
> will have affect to the uuids list provided when driver is probed wich
> will have repeated uuids due to an issue matching the uuid with the
> profiles list: device_match_driver function.
>
> First time that device_match_pattern is executed with uuid
> 00001400-0000-1000-8000-00805F9B34FB it will provide a list with the
> uuid 00001402-0000-1000-8000-00805F9B34FB wich is in the profile list
> (MDPSink) and that uuid will be inserted to the uuid list.
>
> Next iteration it will check next uuid provided in the driver:
> 00001401-0000-1000-8000-00805F9B34FB and device_match_pattern will
> return another time a list with 00001402-0000-1000-8000-00805F9B34FB
> uuid wich will be inserted another time in the for loop. Please, notice
> that now we have the same uuid inserted two times in the uuid list.
>
> Next it will check last uuid provided in the driver:
> 00001402-0000-1000-8000-00805F9B34FB and skip it because it is already
> inserted from before iteration.
>
> You can review the code to check it.
>
> Of course we always can get the necessary entries from the remote SDP
> record, but at least the repeated uuids can be avoided by setting a
> check before to insert anything in the uuid list that it will provided
> when the driver is probed:
>
> /* match pattern driver */
> match = device_match_pattern(device, *uuid, profiles);
> for (; match; match = match->next) {
> +       if (!g_slist_find_custom(uuids, match->data,
> +                               (GCompareFunc) strcasecmp)) {
>                uuids = g_slist_append(uuids, match->data);
> +       }
> }

Yep, this is the correct fix, but also remember that we don't use
brackets in single line if statements.

Another thing you might want to do is to only list only MDP in the
divers .uuid or only MDPSource/MDPSink if you want them to be handle
in separated drivers, I would suggest doing the former since that is
much easier to do the matching in the core and in the latter you might
run in more problems while trying to read the record from the cache
since it is not the very first service class id listen in the record.

-- 
Luiz Augusto von Dentz
Computer Engineer
