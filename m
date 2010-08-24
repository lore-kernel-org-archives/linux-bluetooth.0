Return-Path: <cyrus@holtmann.org>
Message-ID: <f5a72626c821919cb059a7efc6e7fb9f.squirrel@www.codeaurora.org>
In-Reply-To: <1282688488.6841.34.camel@localhost.localdomain>
References: <1282688060-10727-1-git-send-email-angelab@codeaurora.org>
    <1282688488.6841.34.camel@localhost.localdomain>
Date: Tue, 24 Aug 2010 15:55:47 -0700 (PDT)
Subject: Re: [PATCH 0/4] Fix error reporting for SDP Requests
From: angelab@codeaurora.org
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Section 4.4 of the Bluetooth Corev2.1 spec, states that the error code
shall be 0x04 when an invalid PDU size is received. BlueZ is returning
error code 0x03 for the following:
TP/SERVER/SS/BI-01-C  [PATCH 1/4]
TP/SERVER/SA/BI-03-C  [PATCH 2/4]
TP/SERVER/SSA/BI-02-C [PATCH 3/4]

For this test case I sent a bad search attribute request where the max
amount Of Attribute Data to return is 0, but blueZ fails to respond with
an error code. The "max amount of attribute data" field has to be set to a
minimum size of 0x0007 for the request to be valid.
TP/SERVER/SA/BI-02-C [PATCH 4/4]

Sincerely,
Angela Bartholomaus
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.




> Hi Angela,
>
>> Fixed the following issues revealed while performing bluez
>> qualification:
>> - Incorrect error code was being reported for requests with invalid PDU
>> size;
>> - No error was being reported if a request less than 0x07 was received.
>
> I never needed any of these fixes when doing qualification. So why do
> you? Please mention the test case numbers.
>
> Regards
>
> Marcel
>
>
>
