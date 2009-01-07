Return-Path: <cyrus@holtmann.org>
Message-ID: <49647B4D.2020907@powercraft.nl>
Date: Wed, 07 Jan 2009 10:52:13 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: can somebody show me an example asound configuration for dmixing
 with hifi bluetooth speakers/headset
References: <494E2ACD.2080900@powercraft.nl> <4958A3E5.4030105@powercraft.nl>	 <49632D4C.6060207@powercraft.nl> <664d43d60901061352y72c39fdctdeae5d7242ce559d@mail.gmail.com>
In-Reply-To: <664d43d60901061352y72c39fdctdeae5d7242ce559d@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------060706080204020802090800"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------060706080204020802090800
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

event wrote:
> On Tue, Jan 6, 2009 at 12:07, Jelle de Jong <jelledejong@powercraft.nl> wrote:
>> Jelle de Jong wrote:
>>>> Hello everybody,
>>>>
>>>> I have been periodically trying to get multiple audio sources to play
>>>> together (dmixing) to a hifi bluetooth speaker system or hifi bluetooth
>>>> headset.
>>>>
>>>> I am using only alsa and no pulseaudio, esd, jack, mas of something else
>>>> just alsa with asoundrc configuration files and no graphical environment.
>>>>
>>>> Can somebody show me an example asoundrc config file to make it possible
>>>> to use software audio mixing with my bluetooth devices. If this is
>>>> currently not possible, please tell why and what we can do about it. I
>>>> am willing to donate some payal money to the person providing me with a
>>>> working asoundrc configuration file that allows me to play multiple
>>>> audio sources at the same time.
>>>>
>>>> Thanks in advance,
>>>>
>>>> Jelle
>>>>
>>> Bumping up this mail, I would really like to see a solution for my
>>> problem or receive information why the problem is not possible not solvable?
>>>
>>> Thanks in advance for any help,
>>>
>>> Best regards,
>>>
>>> Jelle
>> Bump for the mail, I still have this issue, and would really appreciate
>> somebody taking a look at. I don't know if there is code limitation or
>> that it is just a asoundrc configuration issue.
>>
>> Please help,
>>
>> Best regards,
>>
>> Jelle
>
> Hello Jelle,
> could you please provide more details:
> 1. what happen when you play from two sources simultaneously?
> 2. what happen if you play only one source?
> 3. please provide your asoundrc (at least the pcm.bluetooth part)
> 4. does it work fine with other output device?
>
> Vale,
> event

Thank you for responding, I had reattached the configurations and
outputs with some more info. I have already spent a bloody awful lot of
time on testing with trial and error. I am not an alsa or bluetooth
developer I cannot get it to work. If a capable person could get it
working I would be very great full.

I am also not able to get bluetooth working without adding a sound card
to my system, so i put in a usb sound dongle just to get bluetooth with
alsa working, alsa won't load its modules without it first finding a
soundcard. It is all very very confusing.

Thanks in advance for any help,

Best regards,

Jelle

--------------060706080204020802090800
Content-Type: text/plain;
 name="asoundrc"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="asoundrc"

cGNtLmhlYWRzZXQgewogICAgdHlwZSBibHVldG9vdGgKICAgICN+IGRldmljZSAwMDowRDox
ODpBMDozNTo3MAogICAgI34gZGV2aWNlIDAwOjUzOjUzOkZCOjdFOjlDICMgTm9raWEgQkgt
ODAxCiAgICAjfiBkZXZpY2UgMDA6MEM6NTU6RDE6Qzk6NzggIyBNb3Rvcm9sYSBTODA1CiAg
ICAjfiBkZXZpY2UgMDA6MEQ6RkQ6MTg6NkU6M0MgIyBNb3Rvcm9sYSBTOQogICAgI34gZGV2
aWNlIDIwOjA3OjA5OjE1OkE5OjVBICMgU2Ftc3VuZyBXRVAyMTAKICAgICN+IHB5dGhvbiAu
c2ltcGxlLWFnZW50LnB5IGhjaTAgMDA6MUE6ODA6QUI6MEE6QjEKICAgIGRldmljZSAwMDox
QTo4MDpBQjowQTpCMSAjIFNvbnkgU1JTLUJUMTAwCiAgICBwcm9maWxlIGhpZmkKICAgICNw
cm9maWxlIHZvaWNlCiAgICAjcHJvZmlsZSBhdXRvCiAgICBtb2RlIHN0ZXJlbwp9CnBjbS5z
b2Z0dm9sIHsKICAgIHR5cGUgc29mdHZvbAogICAgc2xhdmUucGNtIGhlYWRzZXQKICAgIGNv
bnRyb2wubmFtZSBIZWFkc2V0CiAgICBjb250cm9sLmNhcmQgMAp9CnBjbS4hZGVmYXVsdCB7
CiAgICAjfiB0eXBlIGh3CiAgICAjfiBjYXJkIDAKICAgIHR5cGUgcGx1ZwogICAgc2xhdmUu
cGNtIHNvZnR2b2wKfQo=
--------------060706080204020802090800
Content-Type: text/x-log;
 name="asoundrc.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asoundrc.log"

# first terminal with the first audio stream
------------------------------------------------------------------------

$ speaker-test -c2

speaker-test 1.0.16

Playback device is default
Stream parameters are 48000Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 6144 to 6144
Period size range from 512 to 2048
Using max buffer size 6144
Periods = 4
was set period_size = 2048
was set buffer_size = 6144
 0 - Front Left
 1 - Front Right
Time per period = 5.865569
 0 - Front Left
 1 - Front Right
Time per period = 5.999629
 0 - Front Left
 1 - Front Right
^C

# second terminal with the second audio stream, that fails
------------------------------------------------------------------------

$ speaker-test -c2

speaker-test 1.0.16

Playback device is default
Stream parameters are 48000Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 6144 to 6144
Period size range from 512 to 2048
Using max buffer size 6144
Periods = 4
was set period_size = 2048
was set buffer_size = 6144
ALSA lib pcm_bluetooth.c:712:(bluetooth_a2dp_hw_params) BT_SETCONFIGURATION failed : Input/output error(5)
Unable to set hw params for playback: Input/output error
Setting of hwparams failed: Input/output error


--------------060706080204020802090800
Content-Type: text/plain;
 name="asoundrcdmix"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="asoundrcdmix"

cGNtLmhlYWRzZXQgewogICAgdHlwZSBibHVldG9vdGgKICAgICN+IGRldmljZSAwMDowRDox
ODpBMDozNTo3MAogICAgI34gZGV2aWNlIDAwOjUzOjUzOkZCOjdFOjlDICMgTm9raWEgQkgt
ODAxCiAgICAjfiBkZXZpY2UgMDA6MEM6NTU6RDE6Qzk6NzggIyBNb3Rvcm9sYSBTODA1CiAg
ICAjfiBkZXZpY2UgMDA6MEQ6RkQ6MTg6NkU6M0MgIyBNb3Rvcm9sYSBTOQogICAgI34gZGV2
aWNlIDIwOjA3OjA5OjE1OkE5OjVBICMgU2Ftc3VuZyBXRVAyMTAKICAgICN+IHB5dGhvbiAu
c2ltcGxlLWFnZW50LnB5IGhjaTAgMDA6MUE6ODA6QUI6MEE6QjEKICAgIGRldmljZSAwMDox
QTo4MDpBQjowQTpCMSAjIFNvbnkgU1JTLUJUMTAwCiAgICBwcm9maWxlIGhpZmkKICAgICNw
cm9maWxlIHZvaWNlCiAgICAjcHJvZmlsZSBhdXRvCiAgICBtb2RlIHN0ZXJlbwp9CnBjbS4h
ZGVmYXVsdCB7CiAgIHR5cGUgcGx1ZwogICBzbGF2ZS5wY20gZG1peGVyCn0KcGNtLmRtaXhl
ciB7CiAgIHR5cGUgZG1peAogICBzbGF2ZS5wY20gaGVhZHNldAp9CmN0bC5kbWl4ZXIgewog
ICB0eXBlIGh3CiAgIGNhcmQgMAp9CnBjbS5kc3AgewogICAgdHlwZSBwbHVnCiAgICBzbGF2
ZS5wY20gZG1peGVyCn0KY3RsLm1peGVyIHsKICAgIHR5cGUgaHcKICAgIGNhcmQgMAp9Cgoj
IGZpcnN0IHRlcm1pbmFsIHdpdGggdGhlIGZpcnN0IGF1ZGlvIHN0cmVhbQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KCiQgc3BlYWtlci10ZXN0IC1jMgoKc3BlYWtlci10ZXN0IDEuMC4xNgoKUGxh
eWJhY2sgZGV2aWNlIGlzIGRlZmF1bHQKU3RyZWFtIHBhcmFtZXRlcnMgYXJlIDQ4MDAwSHos
IFMxNl9MRSwgMiBjaGFubmVscwpVc2luZyAxNiBvY3RhdmVzIG9mIHBpbmsgbm9pc2UKQUxT
QSBsaWIgcGNtX2RpcmVjdC5jOjE0Nzk6KF9zbmRfcGNtX2RpcmVjdF9nZXRfc2xhdmVfaXBj
X29mZnNldCkgSW52YWxpZCB0eXBlICdibHVldG9vdGgnIGZvciBzbGF2ZSBQQ00KClBsYXli
YWNrIG9wZW4gZXJyb3I6IC0yMixJbnZhbGlkIGFyZ3VtZW50CkFMU0EgbGliIHBjbV9kaXJl
Y3QuYzoxNDc5Oihfc25kX3BjbV9kaXJlY3RfZ2V0X3NsYXZlX2lwY19vZmZzZXQpIEludmFs
aWQgdHlwZSAnYmx1ZXRvb3RoJyBmb3Igc2xhdmUgUENNCgpQbGF5YmFjayBvcGVuIGVycm9y
OiAtMjIsSW52YWxpZCBhcmd1bWVudApBTFNBIGxpYiBwY21fZGlyZWN0LmM6MTQ3OTooX3Nu
ZF9wY21fZGlyZWN0X2dldF9zbGF2ZV9pcGNfb2Zmc2V0KSBJbnZhbGlkIHR5cGUgJ2JsdWV0
b290aCcgZm9yIHNsYXZlIFBDTQoKUGxheWJhY2sgb3BlbiBlcnJvcjogLTIyLEludmFsaWQg
YXJndW1lbnQKXkMK
--------------060706080204020802090800
Content-Type: text/x-log;
 name="asoundrcdmix.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asoundrcdmix.log"

# first terminal with the first audio stream
------------------------------------------------------------------------

$ speaker-test -c2

speaker-test 1.0.16

Playback device is default
Stream parameters are 48000Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
ALSA lib pcm_direct.c:1479:(_snd_pcm_direct_get_slave_ipc_offset) Invalid type 'bluetooth' for slave PCM

Playback open error: -22,Invalid argument
ALSA lib pcm_direct.c:1479:(_snd_pcm_direct_get_slave_ipc_offset) Invalid type 'bluetooth' for slave PCM

Playback open error: -22,Invalid argument
ALSA lib pcm_direct.c:1479:(_snd_pcm_direct_get_slave_ipc_offset) Invalid type 'bluetooth' for slave PCM

Playback open error: -22,Invalid argument
^C


--------------060706080204020802090800
Content-Type: text/plain;
 name="asoundrcdmix1"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="asoundrcdmix1"

cGNtLmhlYWRzZXQgewogICAgdHlwZSBibHVldG9vdGgKICAgICN+IGRldmljZSAwMDowRDox
ODpBMDozNTo3MAogICAgI34gZGV2aWNlIDAwOjUzOjUzOkZCOjdFOjlDICMgTm9raWEgQkgt
ODAxCiAgICAjfiBkZXZpY2UgMDA6MEM6NTU6RDE6Qzk6NzggIyBNb3Rvcm9sYSBTODA1CiAg
ICAjfiBkZXZpY2UgMDA6MEQ6RkQ6MTg6NkU6M0MgIyBNb3Rvcm9sYSBTOQogICAgI34gZGV2
aWNlIDIwOjA3OjA5OjE1OkE5OjVBICMgU2Ftc3VuZyBXRVAyMTAKICAgICN+IHB5dGhvbiAu
c2ltcGxlLWFnZW50LnB5IGhjaTAgMDA6MUE6ODA6QUI6MEE6QjEKICAgIGRldmljZSAwMDox
QTo4MDpBQjowQTpCMSAjIFNvbnkgU1JTLUJUMTAwCiAgICBwcm9maWxlIGhpZmkKICAgICNw
cm9maWxlIHZvaWNlCiAgICAjcHJvZmlsZSBhdXRvCiAgICBtb2RlIHN0ZXJlbwp9CgpwY20u
c29mdHZvbCB7CiAgICB0eXBlIHNvZnR2b2wKICAgIHNsYXZlLnBjbSBkbWl4OmhlYWRzZXQK
ICAgIGNvbnRyb2wubmFtZSBNYXN0ZXIKICAgIGNvbnRyb2wuY2FyZCAwCn0KCnBjbS4hZGVm
YXVsdCB7CiAgICB0eXBlIHBsdWcKICAgIHNsYXZlLnBjbSBzb2Z0dm9sCn0KCmN0bC4hZGVm
YXVsdCB7CiAgICB0eXBlIGh3CiAgICBjYXJkIDAKfQo=
--------------060706080204020802090800
Content-Type: text/x-log;
 name="asoundrcdmix1.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asoundrcdmix1.log"

# first terminal with the first audio stream
------------------------------------------------------------------------

$ speaker-test -c2

speaker-test 1.0.16

Playback device is default
Stream parameters are 48000Hz, S16_LE, 2 channels
Using 16 octaves of pink noise
ALSA lib confmisc.c:768:(parse_card) cannot find card 'headset'
ALSA lib conf.c:3513:(_snd_config_evaluate) function snd_func_card_driver returned error: No such device
ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
ALSA lib conf.c:3513:(_snd_config_evaluate) function snd_func_concat returned error: No such device
ALSA lib confmisc.c:1251:(snd_func_refer) error evaluating name
ALSA lib conf.c:3513:(_snd_config_evaluate) function snd_func_refer returned error: No such device
ALSA lib conf.c:3985:(snd_config_expand) Evaluate error: No such device
ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM dmix:headset
Playback open error: -19,No such device
^C


--------------060706080204020802090800--
