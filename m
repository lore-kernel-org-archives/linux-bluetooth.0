Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ] monitor: Fix buffer overflow with unix socket
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <509e62cd-ce83-505c-1038-04a625a8f903@jp.fujitsu.com>
 <CABBYNZK2VQ4FGBSOsDqqJs+ZpY77yG3xJaSiX7xsUSunspy6wg@mail.gmail.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <b4a8ef50-c03a-2948-f6cd-334941b59fcd@jp.fujitsu.com>
Date: Tue, 3 Oct 2017 16:51:34 +0900
MIME-Version: 1.0
In-Reply-To: <CABBYNZK2VQ4FGBSOsDqqJs+ZpY77yG3xJaSiX7xsUSunspy6wg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 10/02/2017 05:03 PM, Luiz Augusto von Dentz wrote:
> Hi Eramoto,
> 
> On Fri, Sep 29, 2017 at 7:40 AM, ERAMOTO Masaya
> <eramoto.masaya@jp.fujitsu.com> wrote:
>> If btmon and btproyx use a unix socket, which has a long pathname,
>> then the buffer overflows occur as below:
>>
>>  *** strcpy_chk: buffer overflow detected ***: program terminated
>>     at 0x4C3085C: ??? (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>>     by 0x4C34E46: __strcpy_chk (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>>     by 0x4084FE: strcpy (string3.h:110)
>>     by 0x4084FE: control_server (control.c:1148)
>>     by 0x4029E9: main (main.c:144)
>>
>>  *** strcpy_chk: buffer overflow detected ***: program terminated
>>     at 0x4C3085C: ??? (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>>     by 0x4C34E46: __strcpy_chk (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>>     by 0x401B74: strcpy (string3.h:110)
>>     by 0x401B74: open_unix (btproxy.c:625)
>>     by 0x401B74: main (btproxy.c:901)
> 
> Lets have the fixes separately, one for btmon and another for btproxy.
> 
>> This patch also gives an error and stops running when parsing command-line
>> arguments, if the unix socket pathname is too long.
>> ---
>>  monitor/control.c |  7 ++++++-
>>  monitor/main.c    |  7 +++++++
>>  tools/btproxy.c   | 17 ++++++++++++++---
>>  3 files changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/monitor/control.c b/monitor/control.c
>> index 9bbdc37..5a1b5e2 100644
>> --- a/monitor/control.c
>> +++ b/monitor/control.c
>> @@ -1130,6 +1130,7 @@ static int server_fd = -1;
>>  void control_server(const char *path)
>>  {
>>         struct sockaddr_un addr;
>> +       size_t len;
>>         int fd;
>>
>>         if (server_fd >= 0)
>> @@ -1143,9 +1144,13 @@ void control_server(const char *path)
>>                 return;
>>         }
>>
>> +       len = strlen(path);
>> +       if (len > sizeof(addr.sun_path) - 1)
>> +               len = sizeof(addr.sun_path) - 1;
>> +
> 
> Should we actually fail here or you are truncating the path on btproxy?

We should fail in advance of unlink() since above control_server removes the
user-specified file and creates the truncated file, which is not user-specified,
thus will confuse users.

> 
>>         memset(&addr, 0, sizeof(addr));
>>         addr.sun_family = AF_UNIX;
>> -       strcpy(addr.sun_path, path);
>> +       strncpy(addr.sun_path, path, len);
>>
>>         if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
>>                 perror("Failed to bind server socket");
>> diff --git a/monitor/main.c b/monitor/main.c
>> index b4e9a6a..68ae821 100644
>> --- a/monitor/main.c
>> +++ b/monitor/main.c
>> @@ -31,6 +31,7 @@
>>  #include <stdlib.h>
>>  #include <string.h>
>>  #include <getopt.h>
>> +#include <sys/un.h>
>>
>>  #include "src/shared/mainloop.h"
>>  #include "src/shared/tty.h"
>> @@ -114,6 +115,7 @@ int main(int argc, char *argv[])
>>
>>         for (;;) {
>>                 int opt;
>> +               struct sockaddr_un addr;
>>
>>                 opt = getopt_long(argc, argv, "d:r:w:a:s:p:i:tTSAE:vh",
>>                                                 main_options, NULL);
>> @@ -141,6 +143,11 @@ int main(int argc, char *argv[])
>>                         analyze_path = optarg;
>>                         break;
>>                 case 's':
>> +                       if (strlen(optarg) >
>> +                                       sizeof(addr.sun_path) - 1) {
>> +                               fprintf(stderr, "Socket too long\n");
>> +                               return EXIT_FAILURE;
> 
> If this would fail here Im no sure what is the point of the check on
> control_server? Btw, the message should probably be "Socket name too
> long".

I want to add these redundant checks
 - to prevent the regression if reusing control_server()/open_unix()
   in the future
and
 - to immediately stop running when parsing command-line arguments.

If we should add the check when reusing control_server()/open_unix(),
I remove it and send patches.


Regards,
Eramoto

> 
>> +                       }
>>                         control_server(optarg);
>>                         break;
>>                 case 'p':
>> diff --git a/tools/btproxy.c b/tools/btproxy.c
>> index f06661d..abe9ef8 100644
>> --- a/tools/btproxy.c
>> +++ b/tools/btproxy.c
>> @@ -610,6 +610,7 @@ static void server_callback(int fd, uint32_t events, void *user_data)
>>  static int open_unix(const char *path)
>>  {
>>         struct sockaddr_un addr;
>> +       size_t len;
>>         int fd;
>>
>>         unlink(path);
>> @@ -620,9 +621,13 @@ static int open_unix(const char *path)
>>                 return -1;
>>         }
>>
>> +       len = strlen(path);
>> +       if (len > sizeof(addr.sun_path) - 1)
>> +               len = sizeof(addr.sun_path) - 1;
>> +
>>         memset(&addr, 0, sizeof(addr));
>>         addr.sun_family = AF_UNIX;
>> -       strcpy(addr.sun_path, path);
>> +       strncpy(addr.sun_path, path, len);
>>
>>         if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
>>                 perror("Failed to bind Unix server socket");
>> @@ -797,9 +802,15 @@ int main(int argc, char *argv[])
>>                                 server_address = "0.0.0.0";
>>                         break;
>>                 case 'u':
>> -                       if (optarg)
>> +                       if (optarg) {
>> +                               struct sockaddr_un addr;
>>                                 unix_path = optarg;
>> -                       else
>> +                               if (strlen(unix_path) >
>> +                                               sizeof(addr.sun_path) - 1) {
>> +                                       fprintf(stderr, "Path too long\n");
>> +                                       return EXIT_FAILURE;
>> +                               }
>> +                       } else
>>                                 unix_path = "/tmp/bt-server-bredr";
>>                         break;
>>                 case 'p':
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

