Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: Re: [PATCH BlueZ 0/6] Make commands return exit status
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <5ebabd54-eae8-a7d1-2c22-ffedca75d6f3@jp.fujitsu.com>
 <CABBYNZLxMy-fj=HESjdzDt+CV2u3MJVCd-7shop+01PwUpXjVQ@mail.gmail.com>
Message-ID: <601e83b6-023b-0ba6-920e-9dfa66548393@jp.fujitsu.com>
Date: Tue, 27 Mar 2018 14:38:01 +0900
MIME-Version: 1.0
In-Reply-To: <CABBYNZLxMy-fj=HESjdzDt+CV2u3MJVCd-7shop+01PwUpXjVQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 03/26/2018 10:26 PM, Luiz Augusto von Dentz wrote:
> Hi Eramoto,
> 
> On Mon, Mar 26, 2018 at 11:25 AM, ERAMOTO Masaya
> <eramoto.masaya@jp.fujitsu.com> wrote:
>> Commands always return 0 as exit status in non-interactive mode. This
>> patch set makes them return the exit_status variable as exit status.
>>
>> Note:
>>   This patch set does not include the following fix for meshctl, due to
>>   conflict with Inga's patch ("mesh/meshctl: Exit cleanly if start up
>>   fails")[1]. I will send a rebased fix after merging Inga's patch to
>>   BlueZ master branch.
>>
>>   [1]: https://www.spinics.net/lists/linux-bluetooth/msg75020.html
> 
> So here is the concern the exit status or the memory leaks, because
> the latter is not really a problem if the process will be terminated
> all the resources will be freed anyway so calling bt_shell_cleanup
> seems pointless in this regard. The status seems alright as I can see
> it being used with scripts that may parse the exit status.

bluetoothctl etc. always return 0 except calling exit(), since
bt_shell_run() does not return value even if a subcommand fails.
Because it is hard for scripts to handle them whose exit status is 0
if they hit any unexpected problem, they are not convenient on
non-interactive mode.

This patch set makes bt_shell_run() return EXIT_SUCCESS/EXIT_FAILURE or
error code, and bluetoothctl etc. be able to pass the status to scripts.


Regards,
Eramoto


> 
>>
>> ERAMOTO Masaya (6):
>>   shared/shell: Return exit status to caller
>>   client: Return exit status for non-interactive
>>   tools/bluetooth-player: Return exit status for non-interactive
>>   tools/obexctl: Return exit status for non-interactive
>>   tools/btmgmt: Return exit status for non-interactive
>>   shared/mainloop: Fix overwriting exit status
>>
>>  client/main.c            | 5 +++--
>>  src/shared/mainloop.c    | 4 +---
>>  src/shared/shell.c       | 7 +++++--
>>  src/shared/shell.h       | 2 +-
>>  tools/bluetooth-player.c | 5 +++--
>>  tools/btmgmt.c           | 2 +-
>>  tools/obexctl.c          | 5 +++--
>>  7 files changed, 17 insertions(+), 13 deletions(-)
>>
>>
>> ---
>>  mesh/main.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/mesh/main.c b/mesh/main.c
>> index d991c9f8c..c79c44bd8 100644
>> --- a/mesh/main.c
>> +++ b/mesh/main.c
>> @@ -1904,6 +1904,7 @@ static void client_ready(GDBusClient *client, void *user_data)
>>  int main(int argc, char *argv[])
>>  {
>>         GDBusClient *client;
>> +       int status;
>>         int len;
>>         int extra;
>>
>> @@ -1989,7 +1990,7 @@ int main(int argc, char *argv[])
>>         if (!onoff_client_init(PRIMARY_ELEMENT_IDX))
>>                 g_printerr("Failed to initialize mesh generic On/Off client\n");
>>
>> -       bt_shell_run();
>> +       status = bt_shell_run();
>>
>>         g_dbus_client_unref(client);
>>
>> @@ -2001,5 +2002,5 @@ int main(int argc, char *argv[])
>>         g_list_free(service_list);
>>         g_list_free_full(ctrl_list, proxy_leak);
>>
>> -       return 0;
>> +       return status;
>>  }
>> --
>> 2.14.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

