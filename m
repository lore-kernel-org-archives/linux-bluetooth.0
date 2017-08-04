Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH Bluez] profiles: Fix memory leak of avrcp player
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <57331670-a1aa-3fa5-1280-86aa997dd2a1@jp.fujitsu.com>
 <CABBYNZKSADLQgVy19VBptrw8jxicVpTSgOp56CDP=q0YeE+kdg@mail.gmail.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <725bac69-52a7-e8d4-7227-352cb39df2b8@jp.fujitsu.com>
Date: Fri, 4 Aug 2017 10:20:41 +0900
MIME-Version: 1.0
In-Reply-To: <CABBYNZKSADLQgVy19VBptrw8jxicVpTSgOp56CDP=q0YeE+kdg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 08/03/2017 06:30 PM, Luiz Augusto von Dentz wrote:
> Hi Aram,
> 
> On Thu, Aug 3, 2017 at 7:10 AM, ERAMOTO Masaya
> <eramoto.masaya@jp.fujitsu.com> wrote:
>> Fix the following problem that occurs in the case of D-Bus fails to
>> register media player path with org.bluez.MediaPlayer1.
> 
> Has this actually happened? Im asking because if that does happen it
> probably because the already exists and we might want to return it
> instead, though the fix seems good and I might apply it anyway.

I do not know what actually happened. I got this message of valgrind and
forgot to get log messages of bluetoothd when the memory leak happened. 
This commit message describe one of cause that I guess from implement of
create_ct_player().

Is it better to remove this guessed cause from this patch to prevent
misunderstanding?


Regards,
Eramoto

>>  120 (104 direct, 16 indirect) bytes in 1 blocks are definitely lost in loss record 197 of 235
>>     at 0x4C2FB55: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>>     by 0x50D2770: g_malloc0 (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
>>     by 0x43817A: create_ct_player (avrcp.c:3331)
>>     by 0x439928: avrcp_addressed_player_changed (avrcp.c:3639)
>>     by 0x439928: avrcp_handle_event (avrcp.c:3716)
>>     by 0x42F738: control_response (avctp.c:840)
>>     by 0x42F738: session_cb (avctp.c:1005)
>>     by 0x50CD049: g_main_context_dispatch (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
>>     by 0x50CD3EF: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
>>     by 0x50CD711: g_main_loop_run (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
>>     by 0x40CD10: main (main.c:778)
>> ---
>>  profiles/audio/avrcp.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
>> index 2c1434d..eaba210 100644
>> --- a/profiles/audio/avrcp.c
>> +++ b/profiles/audio/avrcp.c
>> @@ -3335,8 +3335,11 @@ static struct avrcp_player *create_ct_player(struct avrcp *session,
>>         path = device_get_path(session->dev);
>>
>>         mp = media_player_controller_create(path, id);
>> -       if (mp == NULL)
>> +       if (mp == NULL) {
>> +               g_slist_free(player->sessions);
>> +               g_free(player);
>>                 return NULL;
>> +       }
>>
>>         media_player_set_callbacks(mp, &ct_cbs, player);
>>         player->user_data = mp;
>> --
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

