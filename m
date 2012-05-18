Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120518114032.GB1375@x220.P-661HNU-F1>
References: <1337331254-30749-1-git-send-email-chanyeol.park@samsung.com>
 <1337331254-30749-2-git-send-email-chanyeol.park@samsung.com> <20120518114032.GB1375@x220.P-661HNU-F1>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 18 May 2012 10:02:11 -0300
Message-ID: <CAMOw1v4bO_xYRyLReN81riFtmvUxqx_=5AC3p4D9W3yzkn2EWA@mail.gmail.com>
Subject: Re: [PATCH 2/3] Fix avrcp unregister potential crash
To: chanyeol.park@samsung.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, May 18, 2012 at 8:40 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Chanyeol,
>
> On Fri, May 18, 2012, chanyeol.park@samsung.com wrote:
>> From: Chan-yeol Park <chanyeol.park@samsung.com>
>>
>> ---
>>  audio/avrcp.c |    7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/audio/avrcp.c b/audio/avrcp.c
>> index df39d04..2e946c1 100644
>> --- a/audio/avrcp.c
>> +++ b/audio/avrcp.c
>> @@ -1272,8 +1272,11 @@ void avrcp_unregister(const bdaddr_t *src)
>>
>>       servers = g_slist_remove(servers, server);
>>
>> -     remove_record_from_server(server->ct_record_id);
>> -     remove_record_from_server(server->tg_record_id);
>> +     if (server->ct_record_id)
>> +             remove_record_from_server(server->ct_record_id);
>> +
>> +     if (server->tg_record_id)
>> +             remove_record_from_server(server->tg_record_id);
>>
>>       avctp_unregister(&server->src);
>>       g_free(server);
>
> I don't think the commit message for this patch is truthful. If you look
> at the code the remove_record_from_server will return ENOENT if you pass
> it a non-existent handle. I.e. it will not crash. Please fix the commit
> message to reflect what exactly is being fixed (i.e. an unnecessary call
> to remove_record_from_server if there is no record handle).

Then I don't see a reason: just let remove_record_from_server() fail ?

Chan, what are you fixing here?

Lucas De Marchi
