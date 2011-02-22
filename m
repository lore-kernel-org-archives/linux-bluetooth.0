Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5BC4F68C-A168-4C70-8FB2-A4D2BFBB347D@gsoft.com.au>
References: <AANLkTinC4JqX627rv7PUWrhOZwmerCEQJ_jeZ0w29LW9@mail.gmail.com>
	<5BC4F68C-A168-4C70-8FB2-A4D2BFBB347D@gsoft.com.au>
Date: Tue, 22 Feb 2011 17:33:58 +0800
Message-ID: <AANLkTinRZ2xCxcBQhWGzRvpNLe8hU5kk+0YJ8OP_hCp5@mail.gmail.com>
Subject: Re: How to config bluetooth headset ?
From: Bob Liu <lliubbo@gmail.com>
To: "Daniel O'Connor" <doconnor@gsoft.com.au>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 22, 2011 at 5:21 PM, Daniel O'Connor <doconnor@gsoft.com.au> wrote:
>
> On 22/02/2011, at 18:09, Bob Liu wrote:
>> Cureently I can scan the device:
>> # hcitool scan
>> Scanning ...
>>        00:1A:45:4A:EA:39       Jabra BT125
>> #
>>
>> How to make aplay can use that device?
>
> Does bluetooth-wizard help you?
>

Thanks,
But I am using beagleboard, I need to cross compile all those tools.
Is there any doc about it in detail ?

> I don't know if there is a command line equivalent though, or what happens afterward - eg if bluetoothd stores the connection info for later use or something else must be run..
>

-- 
Regards,
--Bob
