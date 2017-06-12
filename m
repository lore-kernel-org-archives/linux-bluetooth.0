Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLxG65O9i8QZzZJij-548E9U9Csy2=cjvOTC-gNv2FCLg@mail.gmail.com>
References: <1496985808-17492-1-git-send-email-nsathish41@gmail.com>
 <1496985808-17492-2-git-send-email-nsathish41@gmail.com> <CABBYNZLxG65O9i8QZzZJij-548E9U9Csy2=cjvOTC-gNv2FCLg@mail.gmail.com>
From: Sathish Narasimman <nsathish41@gmail.com>
Date: Mon, 12 Jun 2017 12:50:28 +0530
Message-ID: <CAOVXEJLZ9yRpJ_ivQM0v0rMNa_sjq7wiRS6CyEDm=h2JUaiw1w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] obexd/map: msg dummy implement message listing
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Yes, All the details will be stored in mlisitng.xml file. For messages
listing this patch is not taking the xml content from the hidden
file.we fetch the details from some other phone and saving the xml
content as mlisting.xml. As all the details of date, subject, address
and etc will be stored in each folder(inbox, sent, drafts)
mlisting.xml.


https://pastebin.com/1izt4YUY
The above link provides the btmon traces for message listing.


Thanks & Regards,
Sathish N
Thanks & Regards,
Sathish N


On Fri, Jun 9, 2017 at 6:25 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Satish,
>
> On Fri, Jun 9, 2017 at 8:23 AM,  <nsathish41@gmail.com> wrote:
>> From: Sathish Narasimman <sathish.narasimman@intel.com>
>>
>> For messages dummy, message listing functionality in implemented in
>> this patch.
>
> Could you a bit more description how this works, it seems all the
> details shall be stored in mlisting.xml, btw this could be a hidden
> file like .msgs.xml. It would also be great to see the HCI trace is
> correct with request and response exercising this code.
>
>> ---
>>  obexd/plugins/messages-dummy.c | 193 ++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 192 insertions(+), 1 deletion(-)
>>
>> diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
>> index 33056e2..d6ba0b1 100644
>> --- a/obexd/plugins/messages-dummy.c
>> +++ b/obexd/plugins/messages-dummy.c
>> @@ -27,6 +27,7 @@
>>
>>  #include <sys/types.h>
>>  #include <dirent.h>
>> +#include <stdio.h>
>>  #include <errno.h>
>>  #include <stdlib.h>
>>  #include <string.h>
>> @@ -35,6 +36,8 @@
>>
>>  #include "messages.h"
>>
>> +#define MSG_LIST_XML "mlisting.xml"
>> +
>>  static char *root_folder = NULL;
>>
>>  struct session {
>> @@ -52,6 +55,20 @@ struct folder_listing_data {
>>         void *user_data;
>>  };
>>
>> +struct message_listing_data {
>> +       struct session *session;
>> +       const char *name;
>> +       uint16_t max;
>> +       uint16_t offset;
>> +       uint8_t subject_len;
>> +       uint16_t size;
>> +       char *path;
>> +       FILE *fp;
>> +       const struct messages_filter *filter;
>> +       messages_get_messages_listing_cb callback;
>> +       void *user_data;
>> +};
>> +
>>  /* NOTE: Neither IrOBEX nor MAP specs says that folder listing needs to
>>   * be sorted (in IrOBEX examples it is not). However existing implementations
>>   * seem to follow the fig. 3-2 from MAP specification v1.0, and I've seen a
>> @@ -319,6 +336,146 @@ int messages_get_folder_listing(void *s, const char *name, uint16_t max,
>>         return 0;
>>  }
>>
>> +static void max_msg_element(GMarkupParseContext *ctxt, const char *element,
>> +                               const char **names, const char **values,
>> +                               gpointer user_data, GError **gerr)
>> +{
>> +       struct message_listing_data *mld = user_data;
>> +       const char *key;
>> +       int i;
>> +
>> +       for (i = 0, key = names[i]; key; key = names[++i]) {
>> +               if (g_strcmp0(names[i], "handle") == 0) {
>> +                       mld->size++;
>> +                       break;
>> +               }
>> +       }
>> +}
>> +
>> +static void msg_element(GMarkupParseContext *ctxt, const char *element,
>> +                               const char **names, const char **values,
>> +                               gpointer user_data, GError **gerr)
>> +{
>> +       struct message_listing_data *mld = user_data;
>> +       struct messages_message *entry = NULL;
>> +       int i;
>> +
>> +       entry = g_new0(struct messages_message, 1);
>> +       if (mld->filter->parameter_mask == 0) {
>> +               entry->mask = (entry->mask | PMASK_SUBJECT \
>> +                       | PMASK_DATETIME | PMASK_RECIPIENT_ADDRESSING \
>> +                       | PMASK_SENDER_ADDRESSING \
>> +                       | PMASK_ATTACHMENT_SIZE | PMASK_TYPE \
>> +                       | PMASK_RECEPTION_STATUS);
>> +       } else
>> +               entry->mask = mld->filter->parameter_mask;
>> +
>> +       for (i = 0 ; names[i]; ++i) {
>> +               if (g_strcmp0(names[i], "handle") == 0) {
>> +                       entry->handle = g_strdup(values[i]);
>> +                       mld->size++;
>> +                       continue;
>> +               }
>> +               if (g_strcmp0(names[i], "attachment_size") == 0) {
>> +                       entry->attachment_size = g_strdup(values[i]);
>> +                       continue;
>> +               }
>> +               if (g_strcmp0(names[i], "datetime") == 0) {
>> +                       entry->datetime = g_strdup(values[i]);
>> +                       continue;
>> +               }
>> +               if (g_strcmp0(names[i], "subject") == 0) {
>> +                       entry->subject = g_strdup(values[i]);
>> +                       continue;
>> +               }
>> +               if (g_strcmp0(names[i], "recipient_addressing") == 0) {
>> +                       entry->recipient_addressing = g_strdup(values[i]);
>> +                       continue;
>> +               }
>> +               if (g_strcmp0(names[i], "sender_addressing") == 0) {
>> +                       entry->sender_addressing = g_strdup(values[i]);
>> +                       continue;
>> +               }
>> +               if (g_strcmp0(names[i], "type") == 0) {
>> +                       entry->type = g_strdup(values[i]);
>> +                       continue;
>> +               }
>> +               if (g_strcmp0(names[i], "reception_status") == 0)
>> +                       entry->reception_status = g_strdup(values[i]);
>> +       }
>> +
>> +       if (mld->size > mld->offset)
>> +               mld->callback(mld->session, -EAGAIN, mld->size, 0, entry, mld->user_data);
>> +
>> +       if (entry->reception_status)
>> +               g_free(entry->reception_status);
>
> It is safe to call g_free on NULL pointer so we don't need these extra checks.
>
>> +       if (entry->type)
>> +               g_free(entry->type);
>> +       if (entry->sender_addressing)
>> +               g_free(entry->sender_addressing);
>> +       if (entry->subject)
>> +               g_free(entry->subject);
>> +       if (entry->datetime)
>> +               g_free(entry->datetime);
>> +       if (entry->attachment_size)
>> +               g_free(entry->attachment_size);
>> +       if (entry->handle)
>> +               g_free(entry->handle);
>> +       g_free(entry);
>> +}
>> +
>> +static const GMarkupParser msg_parser = {
>> +        msg_element,
>> +        NULL,
>> +        NULL,
>> +        NULL,
>> +        NULL
>> +};
>> +
>> +static const GMarkupParser max_msg_parser = {
>> +        max_msg_element,
>> +        NULL,
>> +        NULL,
>> +        NULL,
>> +        NULL
>> +};
>> +
>> +static gboolean get_messages_listing(void *d)
>> +{
>> +
>> +       struct message_listing_data *mld = d;
>> +       /* 1024 is the maximum size of the line which is calculated to be more
>> +        * sufficient*/
>> +       char buffer[1024];
>> +       GMarkupParseContext *ctxt;
>> +       size_t len;
>> +
>> +       while (fgets(buffer, 1024, mld->fp)) {
>> +               len = strlen(buffer);
>> +
>> +               if (mld->max == 0) {
>> +                       ctxt = g_markup_parse_context_new(&max_msg_parser, 0, mld, NULL);
>> +                       g_markup_parse_context_parse(ctxt, buffer, len, NULL);
>> +                       g_markup_parse_context_free(ctxt);
>> +               } else {
>> +                       ctxt = g_markup_parse_context_new(&msg_parser, 0, mld, NULL);
>> +                       g_markup_parse_context_parse(ctxt, buffer, len, NULL);
>> +                       g_markup_parse_context_free(ctxt);
>> +               }
>> +       }
>> +
>> +       if (mld->max == 0) {
>> +               mld->callback(mld->session, 0, mld->size, 0, NULL, mld->user_data);
>> +               goto done;
>> +       }
>> +
>> +       mld->callback(mld->session, 0, mld->size, 0, NULL, mld->user_data);
>> +
>> +done:
>> +       fclose(mld->fp);
>> +       return FALSE;
>> +}
>> +
>>  int messages_get_messages_listing(void *session, const char *name,
>>                                 uint16_t max, uint16_t offset,
>>                                 uint8_t subject_len,
>> @@ -326,7 +483,41 @@ int messages_get_messages_listing(void *session, const char *name,
>>                                 messages_get_messages_listing_cb callback,
>>                                 void *user_data)
>>  {
>> -       return -ENOSYS;
>> +       struct message_listing_data *mld;
>> +       struct session *s =  session;
>> +       char *path;
>> +
>> +       mld = g_new0(struct message_listing_data, 1);
>> +       mld->session = s;
>> +       mld->name = name;
>> +       mld->max = max;
>> +       mld->offset = offset;
>> +       mld->subject_len = subject_len;
>> +       mld->callback = callback;
>> +       mld->filter = filter;
>> +       mld->user_data = user_data;
>> +
>> +       path = g_build_filename(s->cwd_absolute, MSG_LIST_XML, NULL);
>> +       mld->fp = fopen(path, "r");
>> +       if (mld->fp == NULL) {
>> +               g_free(path);
>> +               messages_set_folder(s, mld->name, 0);
>> +               path = g_build_filename(s->cwd_absolute, MSG_LIST_XML, NULL);
>> +               mld->fp = fopen(path, "r");
>> +               if (mld->fp == NULL) {
>> +                       int err = -errno;
>> +                       DBG("fopen(): %d, %s", -err, strerror(-err));
>> +                       g_free(path);
>> +                       return -EBADR;
>> +               }
>> +       }
>> +
>> +
>> +       g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, get_messages_listing,
>> +                                                               mld, g_free);
>> +       g_free(path);
>> +
>> +       return 0;
>>  }
>>
>>  int messages_get_message(void *session, const char *handle,
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
> --
> Luiz Augusto von Dentz
