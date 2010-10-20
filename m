Return-Path: <cyrus@holtmann.org>
Message-ID: <2309075071F3453599D87858492068CE@freqoneremote>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ devel list" <linux-bluetooth@vger.kernel.org>
Subject: Fw: AVRCP 1.4 : Future on Target Role
Date: Tue, 19 Oct 2010 20:43:34 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To all: sorry about the top-post...

<quote>
>
> Your observation that AVRCP 1.3 is not implemented is correct, and I am 
> (finally!) actively back at work on implementing AVRCP 1.3, based on the 
> control-api.txt documentation.  IMO, this would be a good foundation for 
> 1.4.
>
> For my purposes, I am not keen on 1.4, personally I find it 
> overcomplicated for what should be a relatively simple interface; however, 
> obviously others differ.
>
> Do you have an AVRCP CT (other than a headset) that you are working with?
>
> David Stockwell
>

</quote>

I forgot (still using Outlook) and will not do it again...so please, no 
flames.

> --------------------------------------------------
> From: "Shivendra Agrawal" <ag.shivendra@gmail.com>
> Sent: Tuesday, October 19, 2010 1:16 AM
> To: <linux-bluetooth@vger.kernel.org>
> Subject: AVRCP 1.4 : Future on Target Role
>
>> Hi All,
>>
>> I have been looking at AVRCP 1.4 in BlueZ and intending to
>> enhance/develop this profile for the target role. I have been
>> following the discussion initiated by Sander van Grieken earlier last
>> month, and as I understand, they are premitive and has scope for
>> further enhancements.
>>
>> In the current BlueZ implementation, control-api.txt mentions few
>> methods e.g. SendVendoeDependent, ChangePlayback..., that are not
>> referred/implemented in the code, or I may be unable to find at right
>> place.
>> Further, there are some more AVRCP 1.4 TG specific Notify and Browsing
>> commands that can be added.
>>
>> I am willing to define some preliminary interface APIs for Target
>> Media Applications to register itself with BlueZ, and would come back
>> with some idea proposal for your suggestions on improvements.
>>
>> I am keen to receive your feedback with some ideas and thoughts to put
>> my effort in right direction.
>>
>> Question:
>> Is anyone working on AVRCP 1.4 Target role profile development?
>>
>> Regards,
>> Shivendra
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
