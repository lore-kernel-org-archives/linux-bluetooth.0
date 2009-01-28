Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1233121193.18259.6.camel@violet>
References: <c2a31c480901272116y2bd70ed3yf1c02009c1ec0fd0@mail.gmail.com>
	 <1233121193.18259.6.camel@violet>
Date: Wed, 28 Jan 2009 15:07:08 +0530
Message-ID: <c2a31c480901280137y33faa44fm975c63f5ae2ab514@mail.gmail.com>
Subject: Re: Disconnect eSCO link from Command line
From: sreevani medhahal <sreevani.medhahal@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

hi Marcel,
On Wed, Jan 28, 2009 at 11:09 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Sreevani,
>
>>   After the headset has created the eSCO link. The Profile Tuning
>> Suite asks for Closing the Audio Connection from AG. Is there any
>> command line utiility to disable the eSCO link & not the service level
>> connection(ACL).[The eSCO link is visible on giving hcitool con ]
>
> not that I know of except hcitool cmd ;)
>
I tried modifying hcitool.c function cmd_dc by changing type of link
to ESCO_LINK(instead of ACL_LINK). i got the error as disconnect
failed operation not permitted.
> You should also not be sheeting with sending a HCI command when it comes
> to PTS tests. You program has to be able to disconnect eSCO by itself.
>
BlueZ is getting sco_connect result as Connection timed out. but where
as when i list the connections using hcitool con, i see that there is
a eSCO link.
Regards,
Sreevani M
