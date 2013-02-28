Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CD0EF9D5-67A4-4D64-9F81-9E494E879B7B@holtmann.org>
References: <CAHZ1yC=FkUt=ESbZ+OnfSXKrN0+XHVgcMxqOjQq-EaJU+TPf-w@mail.gmail.com>
	<CACumGOK+rmNt8xb6Ee-vkWRMoCDR0q-LQ-rPNsRwteKOpadJTQ@mail.gmail.com>
	<CAHZ1yCnWf0mamOLk9n9q4CfbXqhGhxG7H2tXmxLus3-keFM51g@mail.gmail.com>
	<CD0EF9D5-67A4-4D64-9F81-9E494E879B7B@holtmann.org>
Date: Thu, 28 Feb 2013 23:14:03 +0200
Message-ID: <CACumGOKG-bzZ-KM6a9Ay+HivvtS3bQN=gFM_P9wNtrrr=inv1w@mail.gmail.com>
Subject: Re: Bluez 5.2 A2DP: "Unable to select SEP"
From: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Scott James Remnant <keybuk@google.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Scott,

On Thu, Feb 28, 2013 at 10:49 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Scott,
>
>
>>> On Thu, Feb 28, 2013 at 9:51 PM, Scott James Remnant <keybuk@google.com> wrote:
>>>> I'm having some difficulties connecting up A2DP in BlueZ 5.2, and I'm
>>>> sure I'm just missing something obvious so would appreciate a second
>>>> set of eyes.
>>>>
>>>> I had thought that to send to an A2DP Sink on a device, I needed an
>>>> A2DP Source endpoint at my end, but when I try and register that
>>>> endpoint I just get org.bluez.Error.NotSupported
>>>
>>> Check your /etc/bluetooth/audio.conf, you must have disabled it for some reason.
>>>
>>
>> There isn't an audio.conf shipped with BlueZ 5.2; checking
>> profiles/audio/manager.c it has:
>>
>> static struct enabled_interfaces enabled = {
>>        .sink           = TRUE,
>>        .source         = FALSE,
>>        .control        = TRUE,
>> };
>>
>> This seems bizarre that registering audio sinks (which I read as
>> sending A2DP from the device to the host) is enabled by default, but
>> not the more usual registering of an audio source (to send to an A2DP
>> sink on the device).

Yep, it was the result of changing the roles, I guess we should enable
them both by default and if the distro don't want one of them just
disable in the config file.

> we want to move to a state where BlueZ works out-of-the-box with no extra config files needed. So I think we should just fix this and always have at least one sink and one source present.
>
> Or if that causes issues, then at least have this depend on PA (or some other audio manager) making that call for us. The default behaviour needs to just work.

By default I would enable them both as nowadays both should work, well
I guess this is valid for every profile that is not market as
experimental it should be enabled by default, so how about the
following patch:

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 934227e..163fcba 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -72,7 +72,7 @@ static GSList *devices = NULL;

 static struct enabled_interfaces enabled = {
        .sink           = TRUE,
-       .source         = FALSE,
+       .source         = TRUE,
        .control        = TRUE,
 };

Or maybe I just remove the whole enabled thing and have the core to handle this.
