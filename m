Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJrqE=wrCXWZtNuk7bAviJX=rxRDd5Ne1JRb9kvkKBvWw@mail.gmail.com>
References: <55080DF0.8020103@ubnt.com>
	<CABBYNZ+EysOFUSZ12RGw-4gUOF+Yj6XyoXpQ=CX=uShn6Wur=Q@mail.gmail.com>
	<55085091.5030202@ubnt.com>
	<CABBYNZJrqE=wrCXWZtNuk7bAviJX=rxRDd5Ne1JRb9kvkKBvWw@mail.gmail.com>
Date: Tue, 17 Mar 2015 11:15:12 -0700
Message-ID: <CAHrH25S+=VR-fRzT35Je_0oD47ZQKLUvtY0ydmdVF4LSg5vEzw@mail.gmail.com>
Subject: Re: core/gatt-db: Long writes into external GATT characteristics issue
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Andrejs Hanins <andrejs.hanins@ubnt.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz & Andrejs,

On Tue, Mar 17, 2015 at 9:49 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Andrejs,
>
> On Tue, Mar 17, 2015 at 6:04 PM, Andrejs Hanins <andrejs.hanins@ubnt.com> wrote:
>> Hi Luiz,
>>
>> On 2015.03.17. 17:15, Luiz Augusto von Dentz wrote:
>>> Hi Andrejs,
>>>
>>> On Tue, Mar 17, 2015 at 1:20 PM, Andrejs Hanins
>>> <andrejs.hanins@ubnt.com> wrote:
>>>> Hi,
>>>>
>>>> To begin with, there is an issue with long reading/writing of
>>>> external GATT characteristics registered via GattManager1. Related
>>>> ATT ops are ReadBlob, PrepareWrite, ExecuteWrite etc. Reading issue
>>>> is easily fixed in a patch I sent yesterday. But the write case is
>>>> more tricky. Currently, long write into external chrc (D-Bus method
>>>> "WriteValue") is executed in a "chunked" fashion. Thats is, each
>>>> ATT PrepareWrite op eventually causes an invocation of "WriteValue"
>>>> with appropriate buffer (see exec_next_prep_write()). I see no easy
>>>> way for external D-Bus GATT service to distinguish between full and
>>>> partial writes, so no way to tell when the chrc is fully written.
>>>>
>>>> I see two solutions for the issue:
>>>>
>>>> 1. Add a new method to GattCharacteristic1 called
>>>> "WriteValuePartial" with a single buffer argument, so that
>>>> len(buffer)==0 denotes that all chunks have been written and
>>>> service can assemble the whole buffer for further processing. Or
>>>> the existing "WriteValue" method can be extended with a parameter
>>>> like op_type = ["Single", "Partial", "End"]. I'm not a BlueZ
>>>> design expert, but IMO this approach stinks a bit... D-Bus level
>>>> API should be simple. I doubt that external service should have an
>>>>  burden related to ATT MTU fragmentation.
>>>>
>>>> 2. Add some logic to BlueZ daemon so that "WriteValue" is always
>>>> executed with fully assembled data from multiple PrepareWrite ops.
>>>> Such approach will not require any D-Bus API changes, which is
>>>> good. The problem is that I personally don't see a clean and easy
>>>> way how to implement it in the code. Attributes are written using
>>>> gatt_db_attribute_write() which has ATT opcode and write offset,
>>>> but this info is not enough to understand when the last chunk of
>>>> an attribute value is being written to complete the operation in a
>>>>  single step. In case of external chrc, the
>>>> gatt_db_attribute::write_func equals to chrc_write_cb() which
>>>> immediately sends D-Bus calls to "WriteValue", thats it doing the
>>>> "chunking". If there would be a possibility to tell when the call
>>>> to gatt_db_attribute::write_func is for the last chunk of data,
>>>> then chrc_write_cb() could do the assembly and invoke "WriteValue"
>>>> only once. The task can be accomplished by adding an additional
>>>> argument to gatt_db_write_t functor definit ion telling that write
>>>> is chunked and if the chunk is last or not. Not sure, does it look
>>>> like a "brutal hack" or not for BlueZ gurus :)
>>>
>>> I guess what we should do is to queue the prepare writes and wait
>>> execute to actually do the write in gatt_db,
>>
>> This is exactly what is happening now. ExecuteWrite triggers all queued chunks to be written one by one into gatt_db, but not each PrepareWrite. PrepareWrite does only queuing.
>>
>>> I would probably leave this to bt_gatt_server since it should be
>>> doing permission checking, etc, it could handle the prepare queue.
>>
>> It looks wrong to me, because the API to write into gatt_db (gatt_db_attribute_write()) is supposed to carry the knowledge about partial writes based on the 'offset' argument. There will be no reason to have 'offset' argument if bt_gatt_server would always squash all 'prepare write' chunks into one.
>
> Not really, the offset is still useful to tell where it start, but if
> prepare writes are in sequence, like it should be for long write, than
> there is no need to write multiple sets instead we should just use
> realloc and reuse the same buffer, this is actually cheaper since we
> don't have to allocate more elements in the queue and cause overall
> less calls. Now if you have different areas to write to we still going
> to do multiple writes, but I guess this less likely to happen in
> practice.
>
>>> Anyway, anything that write on prepare is probably wrong since with
>>> prepare there is the possibility to cancel the queue so we should
>>> never call WriteValue in the first place.
>>
>> As said, it is already like this.
>>
>>>
>>>> Maybe someone with better BlueZ design knowledge can suggest how
>>>> the 2-nd solution can be implemented or maybe propose something
>>>> completely different.
>>>>

bt_gatt_server already correctly handles long writes (and multiple
writes) according to the spec; it maintains a prepare queue and
executes them only when it receives an ExecuteWrite. The problem here
is that a remote client may actually want to only partially modify a
characteristic value; this is why the offset parameter exists in the
first place. So this is a problem at the D-Bus API layer, not at the
shared/gatt layer.

IMO, extending the WriteValue with an offset parameter is very much
reasonable and it's something that every platform API already allows.
I think this is useful for both client and server cases, for an
application to be able to specify an offset and even things like
Signed Write, WriteWithoutResponse, and so on. Adding a parameter
dictionary would be clean way to achieve this without breaking
existing apps (which shouldn't technically matter since the API is
still in experimental). This way, we also wouldn't have to do all the
magic guesswork in the client code as to which type of write procedure
should be used.

Thanks,
Arman
