Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000301cfc76b$496508e0$dc2f1aa0$@samsung.com>
References: <000001cfb169$e4d01bc0$ae705340$@samsung.com>
	<CABBYNZKTc7DYz5OSJOYm8uTDRzOOzfLMaOPGg-U7TTneaRiH_A@mail.gmail.com>
	<002101cfb550$afb1f400$0f15dc00$@samsung.com>
	<CABBYNZL5OBA6iNhzTkpKTmSEj+5R_oU5KLOAsFcK0ZDHvridMw@mail.gmail.com>
	<006d01cfc5e0$6b4df110$41e9d330$@samsung.com>
	<CABBYNZJnyVNyw2-odAPV621k-aiw8x83WNju7FZXW0=_5VUotw@mail.gmail.com>
	<000101cfc66e$00719660$0154c320$@samsung.com>
	<CABBYNZJK37SuBuHqxjGO8aobBDukjiOOExciOoQZkGnp-1rGeA@mail.gmail.com>
	<CABBYNZKJ6bOoYPPMEKL5LsFt+NFjOcxx6V2pV5b-WZ81dJeqOw@mail.gmail.com>
	<000301cfc76b$496508e0$dc2f1aa0$@samsung.com>
Date: Wed, 3 Sep 2014 15:04:10 +0300
Message-ID: <CABBYNZ+DWBmHu2erQOsJb_UrfdrguJTFkko8oY_GYQJ9m7nemQ@mail.gmail.com>
Subject: Re: Query regarding MAP 1.2 implementation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Sep 3, 2014 at 2:35 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Hi,
>
>> -----Original Message-----
>> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
>> Sent: Wednesday, September 03, 2014 3:57 PM
>> To: Gowtham Anandha Babu
>> Cc: linux-bluetooth@vger.kernel.org
>> Subject: Re: Query regarding MAP 1.2 implementation
>>
>> Hi,
>>
>> On Tue, Sep 2, 2014 at 11:28 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>> > Hi,
>> >
>> > On Tue, Sep 2, 2014 at 8:22 AM, Gowtham Anandha Babu
>> > <gowtham.ab@samsung.com> wrote:
>> >>
>> >> Hi Luiz,
>> >>
>> >>> -----Original Message-----
>> >>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> >>> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
>> >>> Sent: Monday, September 01, 2014 6:37 PM
>> >>> To: Gowtham Anandha Babu
>> >>> Cc: linux-bluetooth@vger.kernel.org; Bharat Panda
>> >>> Subject: Re: Query regarding MAP 1.2 implementation
>> >>>
>> >>> Hi,
>> >>>
>> >>> On Mon, Sep 1, 2014 at 3:29 PM, Gowtham Anandha Babu
>> >>> <gowtham.ab@samsung.com> wrote:
>> >>>
>> >>> > The current message-dummy.c looks like, it is creating a virtual
>> >>> > folder in the
>> >>> system (Ex. Home/PC-NAME/map-messages/).
>> >>> > So, I created the map-messages directory in home/PC-NAME/. Then I
>> >>> > tried
>> >>> SETPATH (mentioned in the previous thread).
>> >>> > The output is...
>> >>> >
>> >>> >  obexd[29146]: obexd/src/obex.c:cmd_setpath()
>> >>> > obexd[29146]: SETPATH(0x5), (null)(0xffffffff)
>> >>> > obexd[29146]: obexd/src/obex.c:parse_name() NAME:
>> >>> > obexd[29146]: obexd/plugins/mas.c:mas_setpath() SETPATH: name
>> >>> nonhdr
>> >>> > 0x20
>> >>> > obexd[29146]: SETPATH(0x5), SUCCESS(0x20)
>> >>> >
>> >>> > But When I tried to call GetFolderListing() The output is...
>> >>> >
>> >>> > obexd[29146]: obexd/src/obex.c:cmd_get() session 0x1008c40
>> >>> > obexd[29146]: GET(0x3), (null)(0xffffffff)
>> >>> > obexd[29146]: obexd/src/obex.c:parse_type() TYPE:
>> >>> > x-obex/folder-listing
>> >>> > obexd[29146]: obexd/plugins/mas.c:mas_get() GET: name (null) type
>> >>> > x-obex/folder-listing mas 0x1015c00
>> >>> > obexd[29146]: obexd/plugins/mas.c:get_params() Error when parsing
>> >>> parameters!
>> >>> > obexd[29146]: GET(0x3), BAD_REQUEST(0x40)
>> >>> >
>> >>> > But I had few folders created inside the map-messages.
>> >>>
>> >>> Bad request is normally when there is something wrong with the
>> >>> command itself, the error comes from here:
>> >>>
>> >>> mas->inparams = g_obex_apparam_decode(buffer, size);
>> >>> if (mas->inparams == NULL) {
>> >>>     DBG("Error when parsing parameters!");
>> >>>     return -EBADR;
>> >>> }
>> >>>
>> >>> I suspect the problem is that there is no application parameters set
>> >>> which is fine since all the parameters of GetFolderListing are
>> >>> optional, please try with the attached patch I will send it shortly as a
>> proper patch to the mailing list.
>> >>>
>> >>>
>> >>> --
>> >>> Luiz Augusto von Dentz
>> >>
>> >>
>> >> I applied the patch which was attached in the previous reply. Still I am
>> getting the same error.
>> >> I tried printing the "size" inside the get_params function. Its value is '0' for
>> GetFolderListing request.
>> >> If size=0, then g_obex_apparam_decode()  function always return NULL,
>> which leads to "Error when parsing parameters!".
>> >
>> > My bad, the check should be size <= 0 otherwise it will still cause
>> > this problem.
>>
>> Let me know if you can test the patch, I would like to push it asap if it works.
>>
>>
>> --
>> Luiz Augusto von Dentz
>
>
> Now I am not getting the BAD_REQUEST error. But when I call the folder-listing, it abruptly ends or terminate.
>
> The below one -- mas-connect
>
> obexd[14651]: obexd/plugins/bluetooth.c:profile_new_connection() device /org/bluez/hci0/dev_00_1B_DC_07_33_4E
> obexd[14651]: obexd/src/obex.c:obex_session_start()
> obexd[14651]: obexd/src/obex.c:cmd_connect()
> obexd[14651]: CONNECT(0x0), (null)(0xffffffff)
> obexd[14651]: obexd/src/obex.c:cmd_connect() Selected driver: Message Access server
> obexd[14651]: obexd/plugins/mas.c:mas_connect()
> obexd[14651]: CONNECT(0x0), (null)(0x0)
>
> The below one -- mas-setpath
>
> obexd[14651]: obexd/src/obex.c:cmd_setpath()
> obexd[14651]: SETPATH(0x5), (null)(0xffffffff)
> obexd[14651]: obexd/src/obex.c:parse_name() NAME:
> obexd[14651]: obexd/plugins/mas.c:mas_setpath() SETPATH: name  nonhdr 0x20
> obexd[14651]: SETPATH(0x5), SUCCESS(0x20)
>
> The below one -- mas-getFolderListing
>
> obexd[14651]: obexd/src/obex.c:cmd_get() session 0x1ecbd80
> obexd[14651]: GET(0x3), (null)(0xffffffff)
> obexd[14651]: obexd/src/obex.c:parse_type() TYPE: x-obex/folder-listing
> obexd[14651]: obexd/plugins/mas.c:mas_get() GET: name (null) type x-obex/folder-listing mas 0x1ecbc00
> obexd[14651]: obexd/plugins/mas.c:folder_listing_open() name = (null)
> obexd[14651]: obexd/src/obex.c:driver_get_headers() name=(null) type=x-obex/folder-listing object=0x1ecbc00
> obexd[14651]: obexd/plugins/mas.c:any_get_next_header()
> obexd[14651]: get_next_header(): Resource temporarily unavailable (11)
> obexd[14651]: obexd/src/obex.c:driver_get_headers() name=(null) type=x-obex/folder-listing object=0x1ecbc00
> obexd[14651]: obexd/plugins/mas.c:any_get_next_header()
> gowtham.ab@gowtham-ab:~/latest_bluez/bluez$

I think I know what is the problem, outparams can also be NULL if no
application parameter has to be added to the response causing
g_obex_apparam_encode to crash, check with attached patch. Btw next
time please send the backtrace either using gdb or valgrind is highly
recommended.

-- 
Luiz Augusto von Dentz
