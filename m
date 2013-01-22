Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130122185650.GA1119@samus>
References: <1358878703-8100-1-git-send-email-jprvita@openbossa.org>
 <1358878703-8100-3-git-send-email-jprvita@openbossa.org> <20130122185650.GA1119@samus>
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Date: Tue, 22 Jan 2013 16:09:05 -0300
Message-ID: <CAAngNMb1JQJu3DoJ5VXyAtfkZzmVO-CrOb2h56dEHTsqhGDWmA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] avctp: Receive and silent ignore Vol Up/Down operations
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jan 22, 2013 at 3:56 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Joao,
>
> On 15:18 Tue 22 Jan, João Paulo Rechi Vita wrote:
>> The AVRCP spec mandates to support 'volume up' and 'volume down'
>> operations when claiming support for Category 2 TG.
>> ---
>>  profiles/audio/avctp.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
>> index f7e607e..4ab6d6d 100644
>> --- a/profiles/audio/avctp.c
>> +++ b/profiles/audio/avctp.c
>> @@ -214,6 +214,8 @@ static struct {
>>       uint8_t avc;
>>       uint16_t uinput;
>>  } key_map[] = {
>> +     { "VOLUME UP",          AVC_VOLUME_UP,          KEY_VOLUMEUP},
>> +     { "VOLUME DOWN",        AVC_VOLUME_DOWN,        KEY_VOLUMEDOWN},
>>       { "PLAY",               AVC_PLAY,               KEY_PLAYCD },
>>       { "STOP",               AVC_STOP,               KEY_STOPCD },
>>       { "PAUSE",              AVC_PAUSE,              KEY_PAUSECD },
>> @@ -968,6 +970,9 @@ static void init_uinput(struct avctp *session)
>>
>>       dev = manager_get_audio_device(session->device, FALSE);
>>
>> +     session->key_quirks[AVC_VOLUME_UP] |= QUIRK_IGNORE;
>> +     session->key_quirks[AVC_VOLUME_DOWN] |= QUIRK_IGNORE;
>> +
>
> Having a quirk that applies to every device, doesn't seem to map to the
> meaning of 'quirk', i.e. if everybody has the same quirk, it is the norm ;-)
>

It is not a _device quirk_ but it is still a _key quirk_, that is, a
special behavior to handle that key. I could also have checked
specifically for the key id, but I find clearer to do it this way.

--
João Paulo Rechi Vita
Openbossa Labs - INdT
