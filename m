Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1352458100.16204.11.camel@aeonflux>
References: <1352455094-17992-1-git-send-email-luiz.dentz@gmail.com>
	<1352458100.16204.11.camel@aeonflux>
Date: Mon, 12 Nov 2012 11:08:12 +0200
Message-ID: <CABBYNZJXYGaROMPTh02Pc3bu00pB0ZFkrj-9BXx8SF+BQ8MzpA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] audio: Move to profiles directory
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Nov 9, 2012 at 12:48 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> ---
>> v2: Rebase after changes to remove gstreamer and SBC code
>>
>>  Makefile.am                                  | 64 +++++++++++++++-------------
>>  {audio => profiles/audio}/a2dp-codecs.h      |  0
>
> this one is used from avinfo.c as well. We might move that one better
> into lib/ or some place else.
>
>>  {audio => profiles/audio}/a2dp.c             |  0
>>  {audio => profiles/audio}/a2dp.h             |  0
>>  {audio => profiles/audio}/audio.conf         |  0
>>  {audio => profiles/audio}/avctp.c            |  0
>>  {audio => profiles/audio}/avctp.h            |  0
>>  {audio => profiles/audio}/avdtp.c            |  0
>>  {audio => profiles/audio}/avdtp.h            |  0
>>  {audio => profiles/audio}/avrcp.c            |  0
>>  {audio => profiles/audio}/avrcp.h            |  0
>>  {audio => profiles/audio}/control.c          |  0
>>  {audio => profiles/audio}/control.h          |  0
>>  {audio => profiles/audio}/device.c           |  0
>>  {audio => profiles/audio}/device.h           |  0
>>  {audio => profiles/audio}/gateway.c          |  0
>>  {audio => profiles/audio}/gateway.h          |  0
>>  {audio => profiles/audio}/headset.c          |  0
>>  {audio => profiles/audio}/headset.h          |  0
>>  {audio => profiles/audio}/main.c             |  0
>>  {audio => profiles/audio}/manager.c          |  0
>>  {audio => profiles/audio}/manager.h          |  0
>>  {audio => profiles/audio}/media.c            |  0
>>  {audio => profiles/audio}/media.h            |  0
>>  {audio => profiles/audio}/player.c           |  0
>>  {audio => profiles/audio}/player.h           |  0
>>  {audio => profiles/audio}/rtp.h              |  0
>>  {audio => profiles/audio}/sink.c             |  0
>>  {audio => profiles/audio}/sink.h             |  0
>>  {audio => profiles/audio}/source.c           |  0
>>  {audio => profiles/audio}/source.h           |  0
>>  {audio => profiles/audio}/telephony-dummy.c  |  0
>>  {audio => profiles/audio}/telephony-maemo5.c |  0
>>  {audio => profiles/audio}/telephony-maemo6.c |  0
>>  {audio => profiles/audio}/telephony-ofono.c  |  0
>>  {audio => profiles/audio}/telephony.h        |  0
>>  {audio => profiles/audio}/transport.c        |  0
>>  {audio => profiles/audio}/transport.h        |  0
>>  38 files changed, 35 insertions(+), 29 deletions(-)
>>  rename {audio => profiles/audio}/a2dp-codecs.h (100%)
>>  rename {audio => profiles/audio}/a2dp.c (100%)
>>  rename {audio => profiles/audio}/a2dp.h (100%)
>>  rename {audio => profiles/audio}/audio.conf (100%)
>>  rename {audio => profiles/audio}/avctp.c (100%)
>>  rename {audio => profiles/audio}/avctp.h (100%)
>>  rename {audio => profiles/audio}/avdtp.c (100%)
>>  rename {audio => profiles/audio}/avdtp.h (100%)
>>  rename {audio => profiles/audio}/avrcp.c (100%)
>>  rename {audio => profiles/audio}/avrcp.h (100%)
>>  rename {audio => profiles/audio}/control.c (100%)
>>  rename {audio => profiles/audio}/control.h (100%)
>>  rename {audio => profiles/audio}/device.c (100%)
>>  rename {audio => profiles/audio}/device.h (100%)
>>  rename {audio => profiles/audio}/gateway.c (100%)
>>  rename {audio => profiles/audio}/gateway.h (100%)
>>  rename {audio => profiles/audio}/headset.c (100%)
>>  rename {audio => profiles/audio}/headset.h (100%)
>>  rename {audio => profiles/audio}/main.c (100%)
>>  rename {audio => profiles/audio}/manager.c (100%)
>>  rename {audio => profiles/audio}/manager.h (100%)
>>  rename {audio => profiles/audio}/media.c (100%)
>>  rename {audio => profiles/audio}/media.h (100%)
>>  rename {audio => profiles/audio}/player.c (100%)
>>  rename {audio => profiles/audio}/player.h (100%)
>>  rename {audio => profiles/audio}/rtp.h (100%)
>>  rename {audio => profiles/audio}/sink.c (100%)
>>  rename {audio => profiles/audio}/sink.h (100%)
>>  rename {audio => profiles/audio}/source.c (100%)
>>  rename {audio => profiles/audio}/source.h (100%)
>>  rename {audio => profiles/audio}/telephony-dummy.c (100%)
>>  rename {audio => profiles/audio}/telephony-maemo5.c (100%)
>>  rename {audio => profiles/audio}/telephony-maemo6.c (100%)
>>  rename {audio => profiles/audio}/telephony-ofono.c (100%)
>>  rename {audio => profiles/audio}/telephony.h (100%)
>>  rename {audio => profiles/audio}/transport.c (100%)
>>  rename {audio => profiles/audio}/transport.h (100%)
>
> Before we do this, lets take the telephony stuff out first. We do not
> want to keep it anyway.

That probably means audio/headset.c and audio/gateway.c should be
removed as well and no btd_profiles should be registered for those
profiles. This will leave us without any HFP profiles support for now,
but I guess this is okay as they will be external profiles.

-- 
Luiz Augusto von Dentz
