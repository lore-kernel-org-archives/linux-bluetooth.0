Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To: "Lucas De Marchi" <lucas.demarchi@profusion.mobi>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"ovasik@redhat.com" <ovasik@redhat.com>
Subject: Re: [PATCH 7/8] Possible static overrun removed
References: <op.v0awcau9h52hc0@dhcp-25-209.brq.redhat.com>
 <CAMOw1v6SMq3b-H_0uvg4NUUquWDt3iokZx=ToLx4u-y087jyjw@mail.gmail.com>
Date: Wed, 17 Aug 2011 09:32:36 +0200
MIME-Version: 1.0
From: "Pavel Raiskup" <praiskup@redhat.com>
Message-ID: <op.v0ckkmf6h52hc0@dhcp-25-209.brq.redhat.com>
In-Reply-To: <CAMOw1v6SMq3b-H_0uvg4NUUquWDt3iokZx=ToLx4u-y087jyjw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

> Hi Pavel,
>
> On Tue, Aug 16, 2011 at 6:51 AM, Pavel Raiskup <praiskup@redhat.com>  
> wrote:
>> There will be static overrun on c_brf_chip array when brf_chip
>> is greater than 7.
>> ---
>>  tools/hciattach_tialt.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/tools/hciattach_tialt.c b/tools/hciattach_tialt.c
>> index 1ba009c..fc3ed20 100644
>> --- a/tools/hciattach_tialt.c
>> +++ b/tools/hciattach_tialt.c
>> @@ -234,7 +234,8 @@ int texasalt_init(int fd, int speed, struct termios  
>> *ti)
>>                                ((brf_chip > 7) ? "unknown" :
>> c_brf_chip[brf_chip]),
>
> Did you forget the line above? There's the same problem you fixed
> below. Maybe it's better to set
> brf_chip to 0 if it's greater than 7 here.

there is check for brf_chip > 7, I think this is correct. Anyway setting
brf_chip to 0 is not kosher cause IMO this variable is got from HW and when
plotting it out (on line 235) we want to have unchanged value. When HW  
gives
us weird value we want to know it.

>>                                brf_chip);
>>
>> -               sprintf(fw, "/etc/firmware/%s.bin",  
>> c_brf_chip[brf_chip]);
>> +               sprintf(fw, "/etc/firmware/%s.bin",
>> +                       brf_chip > 7 ? "unknown" :  
>> c_brf_chip[brf_chip]);
>>                texas_load_firmware(fd, fw);
>>
>>                texas_change_speed(fd, speed);
>> --

Pavel
