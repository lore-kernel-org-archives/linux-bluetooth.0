Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25TVuR3skQ2YrGCbm-rc9bHdfT7kazTbB-=P6WJ66TTKdg@mail.gmail.com>
References: <1415935430-23790-1-git-send-email-armansito@chromium.org>
	<CAHrH25TVuR3skQ2YrGCbm-rc9bHdfT7kazTbB-=P6WJ66TTKdg@mail.gmail.com>
Date: Mon, 17 Nov 2014 11:49:05 +0200
Message-ID: <CABBYNZKY=fCsM_qK0NLwE2VB5Qw64kZkVZMbaMSxyR0kLExgQg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/gatt-client: Fix memory bug in service_changed_complete
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Fri, Nov 14, 2014 at 10:22 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi,
>
>> On Thu, Nov 13, 2014 at 7:23 PM, Arman Uguray <armansito@chromium.org> wrote:
>> This patch fixes a bug that got accidentally introduced in a previous
>> memory leak fix, where the temporary discovery_op structure held on to
>> the newly discovered service pointers after passing their ownership to
>> the client and incorrectly free'd their memory. This was correctly fixed
>> in init_complete but missed in service_changed_complete.
>> ---
>>  src/shared/gatt-client.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
>> index b932e2d..389401a 100644
>> --- a/src/shared/gatt-client.c
>> +++ b/src/shared/gatt-client.c
>> @@ -993,6 +993,10 @@ static void service_changed_complete(struct discovery_op *op, bool success,
>>         service_list_insert_services(&client->svc_head, &client->svc_tail,
>>                                         op->result_head, op->result_tail);
>>
>> +       /* Relinquish ownership of services, as the client now owns them */
>> +       op->result_head = NULL;
>> +       op->result_tail = NULL;
>> +
>>  next:
>>         /* Notify the upper layer of changed services */
>>         if (client->svc_chngd_callback)
>> @@ -1155,7 +1159,7 @@ static void init_complete(struct discovery_op *op, bool success,
>>         client->svc_head = op->result_head;
>>         client->svc_tail = op->result_tail;
>>
>> -       /* Change owner of service list */
>> +       /* Relinquish ownership of services, as the client now owns them */
>>         op->result_head = NULL;
>>         op->result_tail = NULL;
>>
>> --
>> 2.1.0.rc2.206.gedb03e5
>>
>
> ping.
> --

Applied, thanks.


-- 
Luiz Augusto von Dentz
