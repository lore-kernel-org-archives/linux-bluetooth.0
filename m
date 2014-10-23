Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25R-SFMYOB+E2VzFogr0NRSB52XHfiQ+JQj0W+oAYdXRLw@mail.gmail.com>
References: <1413838861-29956-1-git-send-email-armansito@chromium.org>
	<1413838861-29956-2-git-send-email-armansito@chromium.org>
	<CABBYNZJ6cR80Y0pmPyW_kgVCdssz-JHcLAij8X3+xx4DQb2+6w@mail.gmail.com>
	<CAHrH25R-SFMYOB+E2VzFogr0NRSB52XHfiQ+JQj0W+oAYdXRLw@mail.gmail.com>
Date: Thu, 23 Oct 2014 11:55:50 -0700
Message-ID: <CAHrH25RJBzoK-_zTh7Mh1xriiMy=3L=T_xiKijaY69q+F+m=MQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/8] shared/att: bt_att_cancel should not cancel
 pending requests/indications.
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Arman Uguray <armansito@chromium.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Oct 22, 2014 at 8:40 AM, Arman Uguray <armansito@google.com> wrote:
> Hi Luiz,
>
>
> On Wed, Oct 22, 2014 at 7:39 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Arman,
>>
>> On Tue, Oct 21, 2014 at 12:00 AM, Arman Uguray <armansito@chromium.org> wrote:
>>> bt_att_cancel and bt_att_cancel_all no longer destroy any pending
>>> request or indication, since this would cause a later bt_att_send to
>>> erroneously send out a request or indication before a
>>> response/confirmation for a pending one is received. Instead, they now
>>> keep the pending operations but clear their response and destroy
>>> callbacks since the upper layer is no longer interested in them.
>>> ---
>>>  src/shared/att.c | 24 ++++++++++++++----------
>>>  1 file changed, 14 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/src/shared/att.c b/src/shared/att.c
>>> index 503e06c..c70d396 100644
>>> --- a/src/shared/att.c
>>> +++ b/src/shared/att.c
>>> @@ -1029,15 +1029,17 @@ bool bt_att_cancel(struct bt_att *att, unsigned int id)
>>>                 return false;
>>>
>>>         if (att->pending_req && att->pending_req->id == id) {
>>> -               op = att->pending_req;
>>> -               att->pending_req = NULL;
>>> -               goto done;
>>> +               /* Don't cancel the pending request; remove it's handlers */
>>> +               att->pending_req->callback = NULL;
>>> +               att->pending_req->destroy = NULL;
>>> +               return true;
>>>         }
>>>
>>>         if (att->pending_ind && att->pending_ind->id == id) {
>>> -               op = att->pending_ind;
>>> -               att->pending_ind = NULL;
>>> -               goto done;
>>> +               /* Don't cancel the pending indication; remove it's handlers */
>>> +               att->pending_ind->callback = NULL;
>>> +               att->pending_ind->destroy = NULL;
>>> +               return true;
>>>         }
>>>
>>>         op = queue_remove_if(att->req_queue, match_op_id, UINT_TO_PTR(id));
>>> @@ -1073,13 +1075,15 @@ bool bt_att_cancel_all(struct bt_att *att)
>>>         queue_remove_all(att->write_queue, NULL, NULL, destroy_att_send_op);
>>>
>>>         if (att->pending_req) {
>>> -               destroy_att_send_op(att->pending_req);
>>> -               att->pending_req = NULL;
>>> +               /* Don't cancel the pending request; remove it's handlers */
>>> +               att->pending_req->callback = NULL;
>>> +               att->pending_req->destroy = NULL;
>>>         }
>>>
>>>         if (att->pending_ind) {
>>> -               destroy_att_send_op(att->pending_ind);
>>> -               att->pending_ind = NULL;
>>> +               /* Don't cancel the pending indication; remove it's handlers */
>>> +               att->pending_ind->callback = NULL;
>>> +               att->pending_ind->destroy = NULL;
>>>         }
>>>
>>>         return true;
>>> --
>>> 2.1.0.rc2.206.gedb03e5
>>
>> I would like to first finish with Marcin's patches, are you okay with
>> v5? Btw, please make sure you follow the HACKING document when
>> submitting patches so we can be consistent from now on.
>>
>>
>> --
>> Luiz Augusto von Dentz
>
> I'm fine with Marcin's v5, though we may have to wait for v6 since I
> saw some comments fly by from Szymon.
>
> Yeah I'm following HACKING from now on. So far I used the code around
> me (shared/mgmt, etc) as the style guide and might have repeated
> mistakes that already existed in the code, so it might makes sense to
> do a general style fix pass within src/shared at some point.
>
> -Arman

Looks like Marcin's patches have been merged so should we go ahead
with my patch set? Also, I'm adding TODO items for adding packed
structs for ATT PDUs and adding complete GATT unit test coverage in
unit/test-gatt in the next patch set. We should probably wait until we
have enough unit tests before we convert the code to use packed
structs to make sure that we don't break anything.

-Arman
