Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <00f901d04c20$c6f34300$54d9c900$@samsung.com>
References: <1424271820-19566-1-git-send-email-bharat.panda@samsung.com>
	<CABBYNZLvQsgvjChZT7-X4_hGP3bfHWPaqgnHzxezVyA0ktMo-A@mail.gmail.com>
	<00f901d04c20$c6f34300$54d9c900$@samsung.com>
Date: Thu, 19 Feb 2015 12:57:11 +0200
Message-ID: <CABBYNZKcK3-WBe-5mmVmyDcPe7==71tnXsm5-T=F7pyUmqyVvg@mail.gmail.com>
Subject: Re: [PATCH ] tools/gatt-client: Define ATT application err code
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Bhusan Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Thu, Feb 19, 2015 at 10:47 AM, Bharat Bhusan Panda
<bharat.panda@samsung.com> wrote:
> Hi Luiz,
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
>> Sent: Thursday, February 19, 2015 2:00 PM
>> To: Bharat Panda
>> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
>> Subject: Re: [PATCH ] tools/gatt-client: Define ATT application err code
>>
>> Hi Bharat,
>>
>> On Wed, Feb 18, 2015 at 5:03 PM, Bharat Panda
>> <bharat.panda@samsung.com> wrote:
>> > Adds application error codes for ATT response PDUs.
>> > Prints error messages for respective application error codes.
>> > 1. IO Error
>> > 2. Operation Timedout
>> > 3. Operation Aborted
>> >
>> > e.g.
>> >
>> > [GATT client]# read-value 0x0015
>> > [GATT client]#
>> > Read request failed: IO Error (0x80)
>> > ---
>> >  src/shared/att-types.h | 5 +++++
>> >  tools/btgatt-client.c  | 6 ++++++
>> >  2 files changed, 11 insertions(+)
>> >
>> > diff --git a/src/shared/att-types.h b/src/shared/att-types.h index
>> > aa7f0da..5f95dab 100644
>> > --- a/src/shared/att-types.h
>> > +++ b/src/shared/att-types.h
>> > @@ -91,6 +91,11 @@ struct bt_att_pdu_error_rsp {
>> >  #define BT_ATT_ERROR_UNSUPPORTED_GROUP_TYPE            0x10
>> >  #define BT_ATT_ERROR_INSUFFICIENT_RESOURCES            0x11
>> >
>> > +/* Application error codes for Error response PDU*/
>> > +#define BT_ATT_ERROR_IO                                0x80
>> > +#define BT_ATT_ERROR_TIMEOUT                           0x81
>> > +#define BT_ATT_ERROR_ABORTED                           0x82
>>
>> Where these errors come from? It doesn't look like we are using this range
>> perhaps this was introduced in 4.2?
> These are all application error code for ATT, defined in core 4.2 ATT error code values.
> Application Error       0x80-0x9F       Application error code defined by a higher layer specification.
> PTS test case,
> TC_GAR_CL_BI_35_C/ TC_GAR_CL_BI_34_C - 0x80 as IO Error- Invalid Transprot
> TC_GAT_CL_BV_01_C/ TC_GAT_CL_BV_02_C - as timeout error code 0x81

Then perhaps we should document what are these errors, I was hoping
this is documented in the CCS, perhaps they are to be treated as
application specific but then adding them into the TS is not really
helping because depending on the application these opcodes can be used
for different errors, IMO we should file an errata, these test should
never cause specific application errors otherwise it needs to be in
adopted in the spec, if the point was just to test application
specific errors then any errors in the range 0x80-0x9F should be
allowed.

Now this being said we should probably handle this internally by
printing any error in the whole range as "Application error:" followed
by error code.

>>
>> >  /*
>> >   * ATT attribute permission bitfield values. Permissions are grouped as
>> >   * "Access", "Encryption", "Authentication", and "Authorization". A
>> > bitmask of diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
>> > index e59d5db..7777211 100644
>> > --- a/tools/btgatt-client.c
>> > +++ b/tools/btgatt-client.c
>> > @@ -111,6 +111,12 @@ static const char *ecode_to_string(uint8_t ecode)
>> >                 return "Group type Not Supported";
>> >         case BT_ATT_ERROR_INSUFFICIENT_RESOURCES:
>> >                 return "Insufficient Resources";
>> > +       case BT_ATT_ERROR_IO:
>> > +               return "IO Error";
>> > +       case BT_ATT_ERROR_TIMEOUT:
>> > +               return "Operation Timed out";
>> > +       case BT_ATT_ERROR_ABORTED:
>> > +               return "Operation Aborted";
>> >         default:
>> >                 return "Unknown error type";
>> >         }
>> > --
>> > 1.9.1
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe
>> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
>> --
>
>
> Best Regards,
>
> Bharat
>



-- 
Luiz Augusto von Dentz
