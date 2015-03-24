Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v1 2/8] core/adapter: Refactor of scan type
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD0=r8z6Wqdb5iXLmHaQqLRQHcF0uFxgO_Vut0G_VdcWPR5caA@mail.gmail.com>
Date: Mon, 23 Mar 2015 20:40:35 -0700
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <F6DDE3F3-448B-4740-8A64-6315810F7BCE@holtmann.org>
References: <1426976135-2783-1-git-send-email-jpawlowski@google.com> <1426976135-2783-2-git-send-email-jpawlowski@google.com> <CAHrH25Si72YGyV3Dy+AkQ0T4WgWDwK-uR98DSjf67+AN_c3wQw@mail.gmail.com> <CAD0=r8z6Wqdb5iXLmHaQqLRQHcF0uFxgO_Vut0G_VdcWPR5caA@mail.gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

>>> On Sat, Mar 21, 2015 at 3:15 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>>> This patch replaces scan type with defined constants, and creates
>>> new method that might be used to get currently avaliable scan type.
>>> ---
>>> src/adapter.c | 29 +++++++++++++++++++++--------
>>> 1 file changed, 21 insertions(+), 8 deletions(-)
>>> 
>>> diff --git a/src/adapter.c b/src/adapter.c
>>> index 6eeb2f9..99f9786 100644
>>> --- a/src/adapter.c
>>> +++ b/src/adapter.c
>>> @@ -88,6 +88,10 @@
>>> #define TEMP_DEV_TIMEOUT (3 * 60)
>>> #define BONDING_TIMEOUT (2 * 60)
>>> 
>>> +#define SCAN_TYPE_BREDR (1 << BDADDR_BREDR)
>>> +#define SCAN_TYPE_LE ((1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM))
>>> +#define SCAN_TYPE_DUAL (SCAN_TYPE_BREDR | SCAN_TYPE_LE)
>> 
>> SCAN_TYPE_DUAL isn't being used anywhere in this patch, is it needed
>> here? Maybe only include this in the patch that actually uses it?
>> 
> I'll fix that.
>>> +
>>> static DBusConnection *dbus_conn = NULL;
>>> 
>>> static bool kernel_conn_control = false;
>>> @@ -1185,7 +1189,7 @@ static gboolean passive_scanning_timeout(gpointer user_data)
>>> 
>>>        adapter->passive_scan_timeout = 0;
>>> 
>>> -       cp.type = (1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM);
>>> +       cp.type = SCAN_TYPE_LE;
>>> 
>>>        mgmt_send(adapter->mgmt, MGMT_OP_START_DISCOVERY,
>>>                                adapter->dev_id, sizeof(cp), &cp,
>>> @@ -1327,6 +1331,21 @@ static void cancel_passive_scanning(struct btd_adapter *adapter)
>>>        }
>>> }
>>> 
>>> +static uint8_t get_current_type(struct btd_adapter *adapter)
>>> +{
>>> +       uint8_t type;
>>> +
>>> +       if (adapter->current_settings & MGMT_SETTING_BREDR)
>>> +               type = SCAN_TYPE_BREDR;
>>> +       else
>>> +               type = 0;
>> 
>> I'd just initialize type = 0 and then bitwise or SCAN_TYPE_BREDR if
>> the BREDR setting is set, which I think makes for more readable code.
>> 
> 
> So when I was writing some kernel code, Marcel told me that they
> prefer to delay initialization of variables as long as possible, and
> that's in that manner. I also didn't write this code, I just moved it
> from other place, so this should be good, or was some convention
> changed ?

this rule is still in affect and we want it. Mainly so that the compiler will warn us when we accidentally have a new code path. I want people to think about their code and if the compiler just complains, that is normally a good indication that something needs some extra look at it.

Regards

Marcel

