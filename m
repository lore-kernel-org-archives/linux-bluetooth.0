Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAB0WyvnLfOkkGgLOoM=dEdyKG8CXib9DPG+36=nCMnc-6OtNZQ@mail.gmail.com>
References: <CAB0WyvmynL15E0PegWmS3Kisxi4QY5k=q5-4Pg7pT3d8yagvjA@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01D400E18D@dnce01.ent.ti.com>
	<CAB0WyvnLfOkkGgLOoM=dEdyKG8CXib9DPG+36=nCMnc-6OtNZQ@mail.gmail.com>
Date: Tue, 2 Aug 2011 22:16:20 +0800
Message-ID: <CAB0WyvnyhD89cH_TrMjYcj7eWvEzmLz_u3_j4XPZGTomkzePhQ@mail.gmail.com>
Subject: Fwd: Regarding to TI WL1283 support in the "hciattach" command
From: "Min Jun,Xi" <xi.minjun@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

FYI.


---------- Forwarded message ----------
From: Min Jun,Xi <xi.minjun@gmail.com>
Date: Tue, Aug 2, 2011 at 10:15 PM
Subject: Re: Regarding to TI WL1283 support in the "hciattach" command
To: "Ganir, Chen" <chen.ganir@ti.com>


Hi Ganir,
Our team are working on Bluetooth Low Energy. The support Engineer
from TI told us we should use "texasalt", and we generated the
firmware following the .bts files for windows.  Anyway, it works. I am
not sure whether the command you provided can enable the Low Energy
mode. :)

Thank you!

On Tue, Aug 2, 2011 at 9:11 PM, Ganir, Chen <chen.ganir@ti.com> wrote:
> Hi Xi Minjun.
>
> Is there a reason for using the texasalt ? I've always used the texas command and it worked.
>
> I've been using the wl1283 and the wl1273 with the hciattach, with the following command :
> sudo hciattach -n /dev/ttyUSB0 texas 115200 -t 10000
>
> the -t 10000 may not be needed, depending on the TI Init script you are using.
>
> In addition of course, you will need to put the TIInit_10.x.y.bts in /lib/firmware.
>
>
> Thanks,
> Chen Ganir
>
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Min Jun,Xi
>> Sent: Tuesday, August 02, 2011 11:18 AM
>> To: linux-bluetooth@vger.kernel.org
>> Subject: Regarding to TI WL1283 support in the "hciattach" command
>>
>> Hi All,
>>
>> Recently, I got one TI WL1283 devkit, which is not supported in the
>> current bluez code. When I am trying to attach it to my ubuntu desktop
>> by running the
>>     "hciattach ttyUSB0 texasalt 115200"
>> command, I failed because "wl1283" can not be recognized.
>> In order to make it work, I read through the code in
>> "tools/hciattach_tialt.c", and made several code changes in
>> "texasalt_init()" function. And here is the diff:
>>
>> index 1ba009c..2514ee0 100644
>> --- a/tools/hciattach_tialt.c
>> +++ b/tools/hciattach_tialt.c
>> @@ -211,7 +211,7 @@ int texasalt_init(int fd, int speed, struct termios
>> *ti)
>>         {
>>                 unsigned short lmp_subv = resp[13] | (resp[14] << 8);
>>                 unsigned short brf_chip = (lmp_subv & 0x7c00) >> 10;
>> -               static const char *c_brf_chip[8] = {
>> +               static const char *c_brf_chip[11] = {
>>                         "unknown",
>>                         "unknown",
>>                         "brf6100",
>> @@ -219,7 +219,10 @@ int texasalt_init(int fd, int speed, struct
>> termios *ti)
>>                         "brf6300",
>>                         "brf6350",
>>                         "unknown",
>> -                       "wl1271"
>> +                       "wl1271",
>> +                       "unknown",
>> +                       "unknown",
>> +                       "wl1283"
>>                 };
>>                 char fw[100];
>>
>> @@ -231,7 +234,7 @@ int texasalt_init(int fd, int speed, struct termios
>> *ti)
>>                                 "\tchip: %s (%d)\n",
>>                                 lmp_subv & 0x7f,
>>                                 ((lmp_subv & 0x8000) >> (15-3)) |
>> ((lmp_subv & 0x380) >> 7),
>> -                               ((brf_chip > 7) ? "unknown" :
>> c_brf_chip[brf_chip]),
>> +                               ((brf_chip > 10) ? "unknown" :
>> c_brf_chip[brf_chip]),
>>                                 brf_chip);
>>
>>                 sprintf(fw, "/etc/firmware/%s.bin",
>> c_brf_chip[brf_chip]);
>>
>> Is there anybody from TI can update the code to support WL1283? Or can
>> I commit the code to bluez? Thank you!
>>
>> --
>> best regards,
>> Xi Minjun
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-
>> bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



--
best regards,
Xi Minjun



-- 
best regards,
Xi Minjun
