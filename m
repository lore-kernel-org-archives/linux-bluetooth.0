Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <002f01cc78fa$f27c95f0$2947dd0a@ALEXM>
References: <E1R47Z5-0000QH-00.alexvm12e-mail-ru@f167.mail.ru>
	<CABBYNZJzJPf1KYVpDJvr_UO722DTYzRV0vG6X7OnUHZVK8aq_A@mail.gmail.com>
	<1E0C6F4C3D9940BA8E8D3BA2FC16B573@alexm>
	<CABBYNZ+hXiRQv7KesdgX790wWPabYXvUecq0D=2PjgmVEWTL2A@mail.gmail.com>
	<002f01cc78fa$f27c95f0$2947dd0a@ALEXM>
Date: Thu, 22 Sep 2011 11:07:25 +0300
Message-ID: <CABBYNZKXoKZPL5EESrfbs7ZuU=b0509m7V7_Zs08s42a_6q0RQ@mail.gmail.com>
Subject: Re: obexd: obex_handle_input: poll event HUP ERR
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: alexvm12e@mail.ru
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Sep 22, 2011 at 10:40 AM,  <alexvm12e@mail.ru> wrote:
>
> Hi Luiz,
>
>
>> Can you try the following:
>
>> diff --git a/src/obex.c b/src/obex.c
>> index d8f4648..7b68814 100644
>> --- a/src/obex.c
>> +++ b/src/obex.c
>> @@ -985,6 +985,7 @@ static gboolean check_put(obex_t *obex, obex_object_t
>> *obj)
>>       unsigned int hlen;
>>       uint8_t hi;
>>       int ret;
>> +       GError *err = NULL;
>>
>>       os = OBEX_GetUserData(obex);
>>
>> @@ -1010,7 +1011,12 @@ static gboolean check_put(obex_t *obex,
>> obex_object_t *obj)
>>                               continue;
>>
>>                       os->name = g_convert((const char *) hd.bs, hlen,
>> -                                       "UTF8", "UTF16BE", NULL, NULL,
>> NULL);
>> +                                       "UTF8", "UTF16BE", NULL, NULL,
>> &err);
>> +                       if (err) {
>> +                               error("%s", err->message);
>> +                               g_error_free(err);
>> +                       }
>> +
>>                       DBG("OBEX_HDR_NAME: %s", os->name);
>>                       break;
>
> obexd[844]: Conversion from character set 'UTF16BE' to 'UTF8' is not
> supported
>
> As I understood this is a glib problem not obexd. Thanks for your help.

Yep, probably some dependency missing so that it makes glib unable to
do the conversion. Anyway I think I gonna go ahead and add these so
that it is easier to detect such problem in the future.

-- 
Luiz Augusto von Dentz
