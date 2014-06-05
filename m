Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANBo3n89N56u8NCpd52EoEZSPxDmZjN9_GxHjSXVnT_V=5BO2A@mail.gmail.com>
References: <1401966105-31223-1-git-send-email-bharat.panda@samsung.com>
	<0DD74990-7D04-4415-810D-3D75B073742A@holtmann.org>
	<CANBo3n89N56u8NCpd52EoEZSPxDmZjN9_GxHjSXVnT_V=5BO2A@mail.gmail.com>
Date: Thu, 5 Jun 2014 15:01:28 +0300
Message-ID: <CABBYNZL5hfiUit5guGrHoDeneC5KEfvDeKMNFAJngfR_hcgwng@mail.gmail.com>
Subject: Re: [PATCH ] profiles: Fix crash due to NULL pointer access
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: bharat panda <bharat22bhusan@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Bharat Panda <bharat.panda@samsung.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 5, 2014 at 2:40 PM, bharat panda <bharat22bhusan@gmail.com> wrote:
> Hi Marcel,
>
>>> NULL pointer check is added after memory allocation
>>> to prevent core dump due to NULL pointer access.
>>>
>>> Signed-off-by: Bharat Panda <bharat.panda@samsung.com>
>>> ---
>>> profiles/audio/a2dp.c  |    8 ++++++++
>>> profiles/audio/avctp.c |    4 ++++
>>> profiles/audio/avdtp.c |   16 ++++++++++++++++
>>> profiles/health/hdp.c  |    4 +++-
>>> profiles/health/mcap.c |    2 ++
>>> 5 files changed, 33 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
>>> index c9dac9a..580cb60 100644
>>> --- a/profiles/audio/a2dp.c
>>> +++ b/profiles/audio/a2dp.c
>>> @@ -523,6 +523,8 @@ static gboolean endpoint_getcap_ind(struct avdtp *session,
>>>                                                       a2dp_sep->user_data);
>>>
>>>       codec_caps = g_malloc0(sizeof(*codec_caps) + length);
>>> +     if(!codec_caps)
>>> +             return -ENOMEM;
>>
>> the only way this can return NULL is when the size argument is 0. In all other cases it will abort the program.
>>
> In one of our a2dp connection test, we found it restarted bluetoothd,
> and failed to store the capabilities because of NULL pointer abort.
> Just to avoid same issue in other cases, I have added this check to
> ignore the abort.

If it is reproducible I would like to see the backlog of the crash,
the length comes for dbus_message_iter_get_fixed_array which perhaps
is failing and returning a bogus value which we are not checking.


-- 
Luiz Augusto von Dentz
