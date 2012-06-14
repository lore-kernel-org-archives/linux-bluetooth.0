Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120614134733.GB3846@joana>
References: <1339681270-24425-1-git-send-email-luiz.dentz@gmail.com>
	<1339681270-24425-4-git-send-email-luiz.dentz@gmail.com>
	<20120614134733.GB3846@joana>
Date: Thu, 14 Jun 2012 16:48:52 +0300
Message-ID: <CABBYNZL3VG0dQC-B-ufG=DVh=ZNuVNoF4fShb1zXE8m6bz28JQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/5] audio: Remove local A2DP endpoints options
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 14, 2012 at 4:47 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
> Hi Luiz,
>
> * Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2012-06-14 16:41:09 +0300]:
>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> The local endpoints are no use without the internal IPC.
>> ---
>>  audio/a2dp.c     |   72 +-----------------------------------------------------
>>  audio/audio.conf |    5 ----
>>  2 files changed, 1 insertion(+), 76 deletions(-)
>>
>> diff --git a/audio/a2dp.c b/audio/a2dp.c
>> index 96137e4..094476e 100644
>> --- a/audio/a2dp.c
>> +++ b/audio/a2dp.c
>> @@ -1436,13 +1436,10 @@ static struct a2dp_server *find_server(GSList *list, const bdaddr_t *src)
>>
>>  int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
>>  {
>> -     int sbc_srcs = 0, sbc_sinks = 0;
>> -     int mpeg12_srcs = 0, mpeg12_sinks = 0;
>> -     gboolean source = TRUE, sink = FALSE, socket = FALSE;
>> +     gboolean source = TRUE, sink = FALSE;
>
> You need to remove 'Socket' from
>
> #Disable=Gateway,Source,Socket
>
> On audio.conf too.

It is removed on 5/5


-- 
Luiz Augusto von Dentz
