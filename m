Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKx4nLd+XgRWiPAbE=M5gRE35Kk6VmNZcgfRuLb-A9ynA@mail.gmail.com>
References: <1414525067-15076-1-git-send-email-marcin.kraglak@tieto.com>
	<1414525067-15076-2-git-send-email-marcin.kraglak@tieto.com>
	<CABBYNZJE1QT19dMgOU5fq+rufB9TQjL0Vbzx7JRfHNZw-y60ng@mail.gmail.com>
	<CAJLTA8j6bJCVPpEG69+s_vzgGDetGmTGfmDpvd9KkKyXNoCUQQ@mail.gmail.com>
	<CABBYNZKa20z8QcCfe2KtEZw43sFQigPrZfP2=22xBijxkyxvXw@mail.gmail.com>
	<CAHrH25SvtX8E6r-aNn_w1x9KrfYCaR+yG81M30B=Q510nHs98A@mail.gmail.com>
	<CABD6X-Ltou_HJR+Aqy_LWKObFsuvTQzXLacf+3kf-O_mKnufLQ@mail.gmail.com>
	<CABBYNZKx4nLd+XgRWiPAbE=M5gRE35Kk6VmNZcgfRuLb-A9ynA@mail.gmail.com>
Date: Fri, 31 Oct 2014 15:03:05 +0100
Message-ID: <CABD6X-K9c4XWKUqLj921G0gRy4Lef-PPPEt1MkTKdsGr8HCCUA@mail.gmail.com>
Subject: Re: [PATCHv2 2/7] unit/test-gatt: Add search all primary services
 test case
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Arman Uguray <armansito@chromium.org>,
	Michael Janssen <jamuraa@google.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 30 October 2014 16:41, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Marcin,
>
> On Thu, Oct 30, 2014 at 8:26 AM, Marcin Kraglak
> <marcin.kraglak@tieto.com> wrote:
>> Hi Luiz, Arman
>>
>> On 29 October 2014 17:11, Arman Uguray <armansito@chromium.org> wrote:
>>> Hi Luiz,
>>>
>>> On Wed, Oct 29, 2014 at 8:25 AM, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>> Hi Michael,
>>>>
>>>> On Wed, Oct 29, 2014 at 5:03 PM, Michael Janssen <jamuraa@google.com> wrote:
>>>>> On Wed, Oct 29, 2014 at 5:32 AM, Luiz Augusto von Dentz
>>>>> <luiz.dentz@gmail.com> wrote:
>>>>>> Hi Marcin,
>>>>>>
>>>>>> On Tue, Oct 28, 2014 at 9:37 PM, Marcin Kraglak
>>>>>> <marcin.kraglak@tieto.com> wrote:
>>>>>>> ---
>>>>>>>  unit/test-gatt.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++------
>>>>>>>  1 file changed, 77 insertions(+), 8 deletions(-)
>>>>>>>
>>>>>>> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
>>>>>>> index bbbf9a5..f84b0fc 100644
>>>>>>> --- a/unit/test-gatt.c
>>>>>>> +++ b/unit/test-gatt.c
>>>>>>> @@ -35,8 +35,10 @@
>>>>>>>
>>>>>>>  #include <glib.h>
>>>>>>>
>>>>>>> +#include "lib/uuid.h"
>>>>>>>  #include "src/shared/util.h"
>>>>>>>  #include "src/shared/att.h"
>>>>>>> +#include "src/shared/gatt-helpers.h"
>>>>>>>  #include "src/shared/gatt-client.h"
>>>>>>>
>>>>>>>  struct test_pdu {
>>>>>>> @@ -45,14 +47,22 @@ struct test_pdu {
>>>>>>>         size_t size;
>>>>>>>  };
>>>>>>>
>>>>>>> +enum context_type {
>>>>>>> +       ATT,
>>>>>>> +       CLIENT,
>>>>>>> +       SERVER
>>>>>>> +};
>>>>>>
>>>>>> Well the ATT part of this is a bit weird, do we really need to do this
>>>>>> distinction.
>>>>>>
>>>>>>>  struct test_data {
>>>>>>>         char *test_name;
>>>>>>>         struct test_pdu *pdu_list;
>>>>>>> +       enum context_type context_type;
>>>>>>>  };
>>>>>>>
>>>>>>>  struct context {
>>>>>>>         GMainLoop *main_loop;
>>>>>>>         struct bt_gatt_client *client;
>>>>>>> +       struct bt_att *att;
>>>>>>>         guint source;
>>>>>>>         guint process;
>>>>>>>         int fd;
>>>>>>> @@ -69,13 +79,14 @@ struct context {
>>>>>>>                 .size = sizeof(data(args)),                     \
>>>>>>>         }
>>>>>>>
>>>>>>> -#define define_test(name, function, args...)                           \
>>>>>>> +#define define_test(name, function, type, args...)                     \
>>>>>>>         do {                                                            \
>>>>>>>                 const struct test_pdu pdus[] = {                        \
>>>>>>>                         args, { }                                       \
>>>>>>>                 };                                                      \
>>>>>>>                 static struct test_data data;                           \
>>>>>>>                 data.test_name = g_strdup(name);                        \
>>>>>>> +               data.context_type = type;                               \
>>>>>>>                 data.pdu_list = g_malloc(sizeof(pdus));                 \
>>>>>>>                 memcpy(data.pdu_list, pdus, sizeof(pdus));              \
>>>>>>>                 g_test_add_data_func(name, &data, function);            \
>>>>>>> @@ -182,6 +193,7 @@ static void gatt_debug(const char *str, void *user_data)
>>>>>>>  static struct context *create_context(uint16_t mtu, gconstpointer data)
>>>>>>>  {
>>>>>>>         struct context *context = g_new0(struct context, 1);
>>>>>>> +       const struct test_data *test_data = data;
>>>>>>>         GIOChannel *channel;
>>>>>>>         int err, sv[2];
>>>>>>>         struct bt_att *att;
>>>>>>> @@ -195,12 +207,25 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
>>>>>>>         att = bt_att_new(sv[0]);
>>>>>>>         g_assert(att);
>>>>>>>
>>>>>>> -       context->client = bt_gatt_client_new(att, mtu);
>>>>>>> -       g_assert(context->client);
>>>>>>> +       switch (test_data->context_type) {
>>>>>>> +       case ATT:
>>>>>>> +               context->att = att;
>>>>>>>
>>>>>>> -       if (g_test_verbose())
>>>>>>> -               bt_gatt_client_set_debug(context->client, gatt_debug, "gatt:",
>>>>>>> -                                                                       NULL);
>>>>>>> +               bt_gatt_exchange_mtu(context->att, mtu, NULL, NULL, NULL);
>>>>>>> +               break;
>>>>>>> +       case CLIENT:
>>>>>>> +               context->client = bt_gatt_client_new(att, mtu);
>>>>>>> +               g_assert(context->client);
>>>>>>> +
>>>>>>> +               if (g_test_verbose())
>>>>>>> +                       bt_gatt_client_set_debug(context->client, gatt_debug,
>>>>>>> +                                                               "gatt:", NULL);
>>>>>>> +
>>>>>>> +               bt_att_unref(att);
>>>>>>> +               break;
>>>>>>> +       default:
>>>>>>> +               break;
>>>>>>> +       }
>>>>>>>
>>>>>>>         channel = g_io_channel_unix_new(sv[1]);
>>>>>>>
>>>>>>> @@ -214,7 +239,6 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
>>>>>>>         g_assert(context->source > 0);
>>>>>>>
>>>>>>>         g_io_channel_unref(channel);
>>>>>>> -       bt_att_unref(att);
>>>>>>>
>>>>>>>         context->fd = sv[1];
>>>>>>>         context->data = data;
>>>>>>> @@ -222,6 +246,17 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
>>>>>>>         return context;
>>>>>>>  }
>>>>>>>
>>>>>>> +static void primary_cb(bool success, uint8_t att_ecode,
>>>>>>> +                                               struct bt_gatt_result *result,
>>>>>>> +                                               void *user_data)
>>>>>>> +{
>>>>>>> +       struct context *context = user_data;
>>>>>>> +
>>>>>>> +       g_assert(success);
>>>>>>> +
>>>>>>> +       context_quit(context);
>>>>>>> +}
>>>>>>> +
>>>>>>>  static void destroy_context(struct context *context)
>>>>>>>  {
>>>>>>>         if (context->source > 0)
>>>>>>> @@ -229,6 +264,9 @@ static void destroy_context(struct context *context)
>>>>>>>
>>>>>>>         bt_gatt_client_unref(context->client);
>>>>>>>
>>>>>>> +       if (context->att)
>>>>>>> +               bt_att_unref(context->att);
>>>>>>> +
>>>>>>>         g_main_loop_unref(context->main_loop);
>>>>>>>
>>>>>>>         test_free(context->data);
>>>>>>> @@ -249,6 +287,16 @@ static void test_client(gconstpointer data)
>>>>>>>         execute_context(context);
>>>>>>>  }
>>>>>>>
>>>>>>> +static void test_search_primary(gconstpointer data)
>>>>>>> +{
>>>>>>> +       struct context *context = create_context(512, data);
>>>>>>> +
>>>>>>> +       bt_gatt_discover_all_primary_services(context->att, NULL, primary_cb,
>>>>>>> +                                                               context, NULL);
>>>>>>
>>>>>> Doesn't bt_gatt_client does the same here, I guess I missed this
>>>>>> detail in the first time but if this is just testing client side then
>>>>>> it should use bt_gatt_client and if that cannot be tested we probably
>>>>>> have a problem with our API. I guess PTS would just pass if we do more
>>>>>> than search the primary services, so things like setting the MTU etc
>>>>>> should not be a problem here.
>>>>>
>>>>> Specifically setting the MTU is allowed, but the reason to avoid using
>>>>> bt_gatt_client_new/init here is to avoid the automatic service
>>>>> discovery.  This is probably a good idea at least for testing the
>>>>> different types of discovery.  (is bt_gatt_client  Alternately maybe
>>>>> just test the type of discovery used by bt_gatt_client.  When
>>>>> implementing the read value tests, the auto-discovery of
>>>>> bt_gatt_client may make the test data longer because it needs to be
>>>>> included in every one.
>>>>
>>>> Isn't it what we want? To run exactly as it would be run against PTS
>>>> so we avoid surprises? Not only this avoid auto-discovery but the
>>>> caching done by bt_gatt_client which we would probably have to test
>>>> separately, so it is much more code that we exercise if we test
>>>> bt_gatt_client at the expense of a little bit more PDUs. Perhaps we
>>>> could have a define containing the common PDUs that auto-discovery
>>>> causes so the upcoming tests don't need to duplicate these PDUs.
>>>>
>>
>> I agree we test much more code while testing gatt-client. My idea was
>> to use bt_att in GAD group,
>> because we need to send specified packets and it is more like testing
>> protocol than profile.
>> Whole discovery using gatt-client will be tested in most of GAR and
>> GAW test cases.
>> I'm sure that it will be bigger part of unit tests.
>
> Fair enough, but please add the test description to the commits so we
> are consistent, for example:
>
> unit/test-gatt: Add <test name> test
>
> Verify that a Generic Attribute Profile client discovers Primary
> Services in a GATT server.
I've added descriptions to commit messages

BR
Marcin
