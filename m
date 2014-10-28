Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <508E57A5-CE70-43BE-9FC3-6F883E6397CB@holtmann.org>
References: <CAE7yNv_mZU-yyLszs5BmhUc7MLSwK=TZZ4ArJfeS9Cnn4VgkeQ@mail.gmail.com>
 <508E57A5-CE70-43BE-9FC3-6F883E6397CB@holtmann.org>
From: Sujay Sarkhel <ssarkhe@ncsu.edu>
Date: Tue, 28 Oct 2014 11:09:37 -0700
Message-ID: <CAE7yNv-oW3_6jX1WQSvrjdw5-Z+HBOMCZ_CdphfRiCUEULPAMw@mail.gmail.com>
Subject: Re: BlueZ 5: SDP Record & D-Bus APIs
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel,

Thank you so much for your reply! Keenly following the D-Bus GATT API
related discussions.

For the HDP aspect, what I was interested is information stored in the
MDEP list (the optional MDEP description for each item in the list.
Although optional, certain medical devices stores the device specific
name in this field). It is part of the HDP spec, explained in page 29
of the HDP_SPEC_V11.pdf. I understand why it wasn't important enough
to make it part of the HDP D-Bus APIs, but I had a way to get that
information. Now I don't :( Is there a way to support it or consider
supporting it as part of some property, perhaps?
Regards,
Sujay Sarkhel
___________________________________________
Graduate Student (Computer Science), North Carolina State University
Contact: +1.408.838.7238


On Tue, Oct 28, 2014 at 10:31 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Sujay,
>
>> I'm still getting used to BlueZ 5 D-Bus APIs and I was wondering if
>> someone can help me with a few queries that I've:
>>
>> 1. BlueZ 4 D-Bus Device API provided a method called
>> DiscoverServices(string pattern) that could be used to retrieve
>> service information from the remote device in XML format. I used to
>> use this XML information to retrieve several meta-data relevant to my
>> use-case.
>>
>> For example: for Device ID profile, I would want to retrieve vendor
>> information (id/vendoridsource, etc), for HDP, the optional text
>> associated with an MDEP, etc.
>
> the Device ID information are represented in form of the Modalias property.
>
> For anything HDP related that should be part of the Health API actually. If it is missing there, then that sounds to me like a bug in that API that should be fixed.
>
>> From what I understand, this method does not exist anymore in the
>> exposed APIs. I was wondering whether there's a workaround? How can I
>> still look at the meta-data?
>>
>> 2. I was investigating how to work with the BlueZ D-Bus GATT APIs when
>> it comes to talking to GATT services on remote devices. Is that
>> possible? If yes, then how do I retrieve the list of object path
>> corresponding to the available remote services?
>
> We are developing a new D-Bus based generic GATT API. It is brand new and you can follow the progress on the mailing list.
>
> Regards
>
> Marcel
>
