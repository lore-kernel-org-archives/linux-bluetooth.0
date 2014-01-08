Return-Path: <cyrus@holtmann.org>
Message-ID: <52CD1BA5.1060801@linux.intel.com>
Date: Wed, 08 Jan 2014 11:34:29 +0200
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH_v3 2/4] android/pan: Listen for incoming connections and
 accept in NAP role
References: <1389097880-14783-1-git-send-email-ravikumar.veeramally@linux.intel.com>	<1389097880-14783-3-git-send-email-ravikumar.veeramally@linux.intel.com> <CABBYNZJHnUd9z6SRt84=OCXueBru9f5ae_m2SR06ujJzjQidBQ@mail.gmail.com>
In-Reply-To: <CABBYNZJHnUd9z6SRt84=OCXueBru9f5ae_m2SR06ujJzjQidBQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 01/08/2014 11:07 AM, Luiz Augusto von Dentz wrote:
> Hi Ravi,
>
> On Tue, Jan 7, 2014 at 2:31 PM, Ravi kumar Veeramally
> <ravikumar.veeramally@linux.intel.com> wrote:
>> Listen for incoming connections and accept it. Create bnep interface
>> add it to bridge and notify control and connection state information
>> through HAL. Remove the device on disconnect request. If android
>> settings UI does not have bluetooth tethering enabled it immediately
>> sends disconnect signal.
>> ---
>>   android/pan.c | 192 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 190 insertions(+), 2 deletions(-)
>>
>> diff --git a/android/pan.c b/android/pan.c
>> index 93078ba..0eef284 100644
>> --- a/android/pan.c
>> +++ b/android/pan.c
>> @@ -63,12 +63,17 @@ struct pan_device {
>>          uint8_t         role;
>>          GIOChannel      *io;
>>          struct bnep     *session;
>> +       guint           watch;
>>   };
>>
>>   static struct {
>>          uint32_t        record_id;
>> +       guint           watch;
>> +       GIOChannel      *io;
>>   } nap_dev = {
>>          .record_id = 0,
>> +       .watch = 0,
>> +       .io = NULL,
>>   };
>>
>>   static int device_cmp(gconstpointer s, gconstpointer user_data)
>> @@ -81,13 +86,21 @@ static int device_cmp(gconstpointer s, gconstpointer user_data)
>>
>>   static void pan_device_free(struct pan_device *dev)
>>   {
>> +       if (dev->watch > 0) {
>> +               bnep_server_delete(BNEP_BRIDGE, dev->iface, &dev->dst);
>> +               g_source_remove(dev->watch);
>> +               dev->watch = 0;
> Usually it is not necessary to assign anything to struct members when
> you are freeing the whole struct since its memory gonna be freed
> anyway.

   Yes you are right. Profiles/network/connection.c keeps device data 
after disconnecting,
   it will remove only on device remove call. Assigning zero or NULL 
make sense there.
   But in bluez-android device struct t is removed from list on 
disconnected state.
   Here it won't make much sense. I will remove it in my next version.

  Thanks,
  Ravi.
