Return-Path: <cyrus@holtmann.org>
Message-ID: <52B01C98.2050905@linux.intel.com>
Date: Tue, 17 Dec 2013 11:42:48 +0200
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH_v2 3/6] bnep: Add bnep_new and bnep_free api's
References: <1387231516-4127-1-git-send-email-ravikumar.veeramally@linux.intel.com>	<1387231516-4127-3-git-send-email-ravikumar.veeramally@linux.intel.com> <CABBYNZKMECuAd2WBQ8-FE5OO9Qtp0g=iKTBA3zV8JOa6cxAN9w@mail.gmail.com>
In-Reply-To: <CABBYNZKMECuAd2WBQ8-FE5OO9Qtp0g=iKTBA3zV8JOa6cxAN9w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 17.12.2013 11:19, Luiz Augusto von Dentz wrote:
> Hi Ravi,
>
> On Tue, Dec 17, 2013 at 12:05 AM, Ravi kumar Veeramally
> <ravikumar.veeramally@linux.intel.com> wrote:
>> Refacoring connect and disconnect mechanisms. It would be more
>> convinient for caller to maintain just bnep connection reference
>> and delete whenever it is not required.
>> ---
>>   profiles/network/bnep.c | 37 +++++++++++++++++++++++++++++++++++++
>>   profiles/network/bnep.h |  5 +++++
>>   2 files changed, 42 insertions(+)
>>
>> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
>> index 08037e6..d7d8832 100644
>> --- a/profiles/network/bnep.c
>> +++ b/profiles/network/bnep.c
>> @@ -71,6 +71,7 @@ struct bnep_conn {
>>          GIOChannel      *io;
>>          uint16_t        src;
>>          uint16_t        dst;
>> +       bdaddr_t        dst_addr;
>>          guint   attempts;
>>          guint   setup_to;
>>          void    *data;
>> @@ -246,6 +247,42 @@ int bnep_if_down(const char *devname)
>>          return 0;
>>   }
>>
>> +struct bnep_conn *bnep_new(uint16_t src, uint16_t dst,
>> +                                               const bdaddr_t *dst_addr)
> I would change the order of the parameters, also do not use bdaddr_t
> otherwise you wont be able to do unit tests with it, something like
> bnep_new(int fd, uint16_t local_role, uint16_t remote_role) looks
> better, but perhaps you gonna need the MTU as well.
   bdaddr_t is required incase if it unable to up the interface, connection
  needs to be deleted and it is difficult to track on which error we have to
  delete the connection. And one more thing I am moving many of these
  apis to local to the bnep.c.
  Regarding MTU at least now it is not required by connection.c or 
android/pan.c.
>> +{
>> +       struct bnep_conn *bc;
>> +
>> +       DBG("");
>> +
>> +       if (!dst_addr)
>> +               return NULL;
>> +
>> +       bc = g_new0(struct bnep_conn, 1);
>> +       if (!bc)
>> +               return NULL;
> No need to check the return of g_new0, if it fails it will exit so
> this code will never be triggered.
Ok.

Thanks,
Ravi.
