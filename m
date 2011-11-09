Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACLukzKhzKrH1htxNAAR2CtmzhxEQ6_VyMZUsssncWyXopaAJw@mail.gmail.com>
References: <1320835923-10989-1-git-send-email-sancane@gmail.com>
	<1320835923-10989-2-git-send-email-sancane@gmail.com>
	<CAJdJm_OVgJbGrBmTgTUFaRHazDBweSagPJE0UP0eXa4MVFm61A@mail.gmail.com>
	<CACLukzKhzKrH1htxNAAR2CtmzhxEQ6_VyMZUsssncWyXopaAJw@mail.gmail.com>
Date: Wed, 9 Nov 2011 11:40:50 -0400
Message-ID: <CAJdJm_NsyzABjO-dNSguvfycvL_0cYF6szok4u-BsN9XJtt5Tw@mail.gmail.com>
Subject: Re: [PATCH 1/6] Manage GATT attribute indications in handle callback.
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Wed, Nov 9, 2011 at 10:44 AM, Santiago Carot <sancane@gmail.com> wrote:
>>>  static void ind_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
>>>  {
>>> -       /* TODO: Process indication */
>>> +       struct thermometer *t = user_data;
>>> +       const struct characteristic *ch;
>>> +       uint8_t opdu[ATT_MAX_MTU];
>>> +       uint16_t handle, olen;
>>> +       GSList *l;
>>> +
>>> +       if (len < 3) {
>>> +               DBG("Bad pdu received");
>>> +               goto done;
>>> +       }
>>
>> Are you sure we should send a confirmation even if the PDU received is
>> invalid? What if it is not even an indication (you only check below)?
>
> This callback is supposed only to manage indications not notifications:
> in the code:
> ...
> g_attrib_register(t->attrib, ATT_OP_HANDLE_IND,
>                                                        ind_handler, t, NULL);
>
> Shall I expect another kind of notifications even if I have not
> indicated it when I registered the callback?

I only made this comment because you do this check on the function:

+       if (pdu[0] != ATT_OP_HANDLE_IND) {
+               DBG("Not indication received");
+               return;
+       }

I think you can simply drop this check, as you mentioned it will only
be called for indications.

About the PDU size check, I think it is important to have it (to avoid
memory corruption on invalid PDU), but then the peer device is bogus,
so I think you should not send a confirmation for it, because you did
not receive a valid indication in the first place.

>>> +
>>> +       handle = att_get_u16(&pdu[1]);
>>> +       l = g_slist_find_custom(t->chars, &handle, cmp_char_val_handle);
>>> +       if (l == NULL)
>>> +               goto done;
>>
>> Again, should we send a confirmation to the thermometer even if the
>> indication's handle does not match any characteristic value?
>>
>> (note I didn't read the thermometer profile spec carefully yet. Not
>> sure if it covers invalid PDUs.)
>>
>
> As far as I know, the thermometer spec is not focused in such kind of
> GATT details, so I guess it will depend of the implementation.  If we
> don't send a reply to that indication the remote side will close the
> connection when the timeout expired. So here is the question: what
> would we rather do, to keep the connection alive or to let the remote
> side to close it?

I believe that in general, if the peer device sends a bogus indication
(or if the communication channel was corrupted somehow), we should
*not* confirm it. I see confirmations as an "ack" that the indication
was received, processed and validated by BlueZ. If it is somehow
invalid (PDU size incorrect, invalid handle), we should not confirm
it.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
