Return-Path: <cyrus@holtmann.org>
Message-ID: <541BA138.7080509@gmail.com>
Date: Fri, 19 Sep 2014 08:51:28 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
To: Alan Ott <alan@signal11.us>, linux-wpan@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
CC: Varka Bhadram <varkab@cdac.in>
Subject: Re: [PATCH bluetooth-next 2/3] ieee802154: mrf24j40: remove return
 statement
References: <1410842922-10564-1-git-send-email-varkab@cdac.in> <1410842922-10564-3-git-send-email-varkab@cdac.in> <541B62F6.7000506@signal11.us>
In-Reply-To: <541B62F6.7000506@signal11.us>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 09/19/2014 04:25 AM, Alan Ott wrote:
> Make the first line of the commit message:
>     mrf24j40: remove unnecessary return statement
>
> On 09/16/2014 12:48 AM, Varka Bhadram wrote:
>> This patch remove the return statement for void function.
>> void function return statements are not generally useful.
>>
>
> Take out "this patch" and the second line. Make the comment:
>
>     Remove the return statement in the void function.
>
>
Ok. Thanks Alan.

-- 
Regards,
Varka Bhadram.

