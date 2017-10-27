Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ] obexd: Fix compile error due to lack of header
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <0ff16352-9a23-f0b1-5691-d521b36dcd8c@jp.fujitsu.com>
 <CABBYNZL6v0qiMJ-73MQmB9nrQhNbq8h0e6fqyBtncRRfTB2E1g@mail.gmail.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <b148bf77-1a7d-3f38-5053-19421fc0a7bc@jp.fujitsu.com>
Date: Fri, 27 Oct 2017 16:21:25 +0900
MIME-Version: 1.0
In-Reply-To: <CABBYNZL6v0qiMJ-73MQmB9nrQhNbq8h0e6fqyBtncRRfTB2E1g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 10/26/2017 09:05 PM, Luiz Augusto von Dentz wrote:
> Hi Eramoto,
> 
> On Thu, Oct 26, 2017 at 9:05 AM, ERAMOTO Masaya
> <eramoto.masaya@jp.fujitsu.com> wrote:
>> When compiling with gcc 7.2.0, gcc outputs the following messages.
>> This patch adds the header stdlib.h to each obex-related header including
>> functions with the type ssize_t, so the same problem does not also happen
>> in case using there headers individually.
> 
> Weird this is just happening now, so what did change in 7.2? Usually
> we have stdlib.h included in the c file not in the header.


I do not know what change in gcc 7.2 triggers this issue since I have only
upgraded OS. obexd/plugins/mas.c does not always include stdlib.h, so I
guess gcc 7.2 has enhanced type checking in header file.


Regards,
Eramoto

> 
>>   In file included from obexd/plugins/mas.c:41:0:
>>   ./obexd/src/obex.h:37:1: error: unknown type name ‘ssize_t’; did you mean ‘size_t’?
>>    ssize_t obex_get_size(struct obex_session *os);
>>    ^~~~~~~
>>    size_t
>>   ./obexd/src/obex.h:45:1: error: unknown type name ‘ssize_t’; did you mean ‘size_t’?
>>    ssize_t obex_get_apparam(struct obex_session *os, const uint8_t **buffer);
>>    ^~~~~~~
>>    size_t
>>   ./obexd/src/obex.h:46:1: error: unknown type name ‘ssize_t’; did you mean ‘size_t’?
>>    ssize_t obex_get_non_header_data(struct obex_session *os,
>>    ^~~~~~~
>>    size_t
>>   In file included from obexd/plugins/mas.c:43:0:
>>   ./obexd/src/mimetype.h:36:2: error: expected specifier-qualifier-list before ‘ssize_t’
>>     ssize_t (*get_next_header)(void *object, void *buf, size_t mtu,
>>     ^~~~~~~
>>   In file included from obexd/plugins/mas.c:46:0:
>>   obexd/plugins/filesystem.h:24:1: error: unknown type name ‘ssize_t’; did you mean ‘size_t’?
>>    ssize_t string_read(void *object, void *buf, size_t count);
>>    ^~~~~~~
>>    size_t
>> ---
>>  obexd/plugins/filesystem.h | 2 ++
>>  obexd/src/mimetype.h       | 2 ++
>>  obexd/src/obex.h           | 2 ++
>>  3 files changed, 6 insertions(+)
>>
>> diff --git a/obexd/plugins/filesystem.h b/obexd/plugins/filesystem.h
>> index f95773beb..441b377a2 100644
>> --- a/obexd/plugins/filesystem.h
>> +++ b/obexd/plugins/filesystem.h
>> @@ -21,6 +21,8 @@
>>   *
>>   */
>>
>> +#include <stdlib.h>
>> +
>>  ssize_t string_read(void *object, void *buf, size_t count);
>>  gboolean is_filename(const char *name);
>>  int verify_path(const char *path);
>> diff --git a/obexd/src/mimetype.h b/obexd/src/mimetype.h
>> index 79529b890..52b544073 100644
>> --- a/obexd/src/mimetype.h
>> +++ b/obexd/src/mimetype.h
>> @@ -21,6 +21,8 @@
>>   *
>>   */
>>
>> +#include <stdlib.h>
>> +
>>  typedef gboolean (*obex_object_io_func) (void *object, int flags, int err,
>>                                                         void *user_data);
>>
>> diff --git a/obexd/src/obex.h b/obexd/src/obex.h
>> index fc1674755..769bbcd8a 100644
>> --- a/obexd/src/obex.h
>> +++ b/obexd/src/obex.h
>> @@ -22,6 +22,8 @@
>>   *
>>   */
>>
>> +#include <stdlib.h>
>> +
>>  #define OBJECT_SIZE_UNKNOWN -1
>>  #define OBJECT_SIZE_DELETE -2
>>
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

