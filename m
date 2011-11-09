Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OVgJbGrBmTgTUFaRHazDBweSagPJE0UP0eXa4MVFm61A@mail.gmail.com>
References: <1320835923-10989-1-git-send-email-sancane@gmail.com>
	<1320835923-10989-2-git-send-email-sancane@gmail.com>
	<CAJdJm_OVgJbGrBmTgTUFaRHazDBweSagPJE0UP0eXa4MVFm61A@mail.gmail.com>
Date: Wed, 9 Nov 2011 15:44:09 +0100
Message-ID: <CACLukzKhzKrH1htxNAAR2CtmzhxEQ6_VyMZUsssncWyXopaAJw@mail.gmail.com>
Subject: Re: [PATCH 1/6] Manage GATT attribute indications in handle callback.
From: Santiago Carot <sancane@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

Please, see coments below,

2011/11/9 Anderson Lizardo <anderson.lizardo@openbossa.org>:
> Hi Santiago,
>
> On Wed, Nov 9, 2011 at 6:51 AM, Santiago Carot-Nemesio
> <sancane@gmail.com> wrote:
>> +static gint cmp_char_val_handle(gconstpointer a, gconstpointer b)
>> +{
>> +       const struct characteristic *ch = a;
>> +       const uint16_t *handle = b;
>> +
>> +       if (ch->attr.value_handle == *handle)
>> +               return 0;
>> +
>> +       return -1;
>> +}
>
> Usually we implement the function above as:
>
> return ch->attr.value_handle - *handle;
>
> It will work exactly as your code.
>

ok, that's only a nitpick.


>>  static void ind_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
>>  {
>> -       /* TODO: Process indication */
>> +       struct thermometer *t = user_data;
>> +       const struct characteristic *ch;
>> +       uint8_t opdu[ATT_MAX_MTU];
>> +       uint16_t handle, olen;
>> +       GSList *l;
>> +
>> +       if (len < 3) {
>> +               DBG("Bad pdu received");
>> +               goto done;
>> +       }
>
> Are you sure we should send a confirmation even if the PDU received is
> invalid? What if it is not even an indication (you only check below)?

This callback is supposed only to manage indications not notifications:
in the code:
...
g_attrib_register(t->attrib, ATT_OP_HANDLE_IND,
							ind_handler, t, NULL);

Shall I expect another kind of notifications even if I have not
indicated it when I registered the callback?

>
>> +
>> +       if (pdu[0] != ATT_OP_HANDLE_IND) {
>> +               DBG("Not indication received");
>> +               return;
>> +       }
>
> I suggest a more descriptive debug message here, something like:
>
> DBG("Unexpected ATT opcode: 0x%02x", pdu[0]);
>

OK, no problem.

>> +
>> +       handle = att_get_u16(&pdu[1]);
>> +       l = g_slist_find_custom(t->chars, &handle, cmp_char_val_handle);
>> +       if (l == NULL)
>> +               goto done;
>
> Again, should we send a confirmation to the thermometer even if the
> indication's handle does not match any characteristic value?
>
> (note I didn't read the thermometer profile spec carefully yet. Not
> sure if it covers invalid PDUs.)
>

As far as I know, the thermometer spec is not focused in such kind of
GATT details, so I guess it will depend of the implementation.  If we
don't send a reply to that indication the remote side will close the
connection when the timeout expired. So here is the question: what
would we rather do, to keep the connection alive or to let the remote
side to close it?

Waiting comments.

Regards
Santiago
