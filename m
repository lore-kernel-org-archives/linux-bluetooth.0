Return-Path: <cyrus@holtmann.org>
From: "Cukier, Johnas" <Johnas_Cukier@bose.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Spotted minor bug in btgatt-client.c
Date: Mon, 27 Jul 2015 14:07:29 +0000
Message-ID: <SN1PR0801MB1582B88CF24A85E82721DAA4E38E0@SN1PR0801MB1582.namprd08.prod.outlook.com>
References: <SN1PR0801MB1582A043B013B75D8A3D3149E3840@SN1PR0801MB1582.namprd08.prod.outlook.com>
	<871tfx629w.fsf@intel.com>,<CABBYNZJ3mwB-tYhEXK5ZdkgUdLMVkBpujPg+OC8g-LWVasyf7Q@mail.gmail.com>
In-Reply-To: <CABBYNZJ3mwB-tYhEXK5ZdkgUdLMVkBpujPg+OC8g-LWVasyf7Q@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

That is one option. However, I noticed that my "quick fix" seems to be consistent with what is done in other areas of the code. I sent a patch file to Vinicius with my fix. Whatever you guys decide to do is fine with me. I'm just trying to help. 

By the way, I'm also trying to characterize the code in the "src/shared" directory which seems to be the non-DBus, direct function call code. I'm using a tool called "PlantUML" to help in the characterization of this part of the code. I'm creating a class diagram that gives a big picture of the code base. Even though the code is written in C, it is very C++-like in style. So, I'm treating it more like a C++ code base. Right now, it's preliminary, but it's giving me a much better understanding of what is going on. I hope to move to the DBus part of the code later.

Let me know if you guys want a copy. 

Johnas Cukier

Bose Corporation

(508)766-9097

Johnas_Cukier@bose.com

________________________________________
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sent: Monday, July 27, 2015 4:32 AM
To: Vinicius Costa Gomes
Cc: Cukier, Johnas; linux-bluetooth@vger.kernel.org
Subject: Re: Spotted minor bug in btgatt-client.c

HI Johnas,

On Fri, Jul 24, 2015 at 5:47 PM, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
> Hi Johnas,
>
> "Cukier, Johnas" <Johnas_Cukier@bose.com> writes:
>
>> I have the BlueZ v. 5.32 release distribution. I was trying to use the BTLE GATT client in the tools subdirectory. All worked fine until I tried to send bytes to the GATT server. Using the "write-value" command, I'm able to send data to a particular handle. However, the data bytes are restricted to two-digit decimals. So, if I try to send 100 (ASCII 'd'), I get an error message. I spotted the problem in lines 728 - 742 (listed below):
>>
>> 728: for (i = 1; i < argc; i++) {
>> 729: if (strlen(argv[i]) != 2) {
>> 730: printf("Invalid value byte: %s\n",
>> 731: argv[i]);
>> 732: goto done;
>> 733: }
>> 734:
>> 735: value[i-1] = strtol(argv[i], &endptr, 0);
>> 736: if (endptr == argv[i] || *endptr != '\0'
>> 737: || errno == ERANGE) {
>> 738: printf("Invalid value byte: %s\n",
>> 739: argv[i]);
>> 740: goto done;
>> 741: }
>> 742: }
>>
>> In line 729, the data byte is restricted to a string length of two. In line 735, the byte is converted to a decimal number. Since, the string is restricted to length 2, the byte cannot be prefixed by "0x". So, the strtol() function always converts the byte to decimal. My quick solution was to modify line 735 to read as follows:
>>
>> 735: value[i-1] = strtol(argv[i], &endptr, 16);
>>
>> This makes the assumption that all data bytes are in hexadecimal (without the "0x" prefix). This may be confusing to the user since the handle needs the "0x" prefix for it to be interpreted as a hex number. As I said, this is a quick fix that I implemented in my version.
>>
>
> Thanks for spotting this bug.
>
> Looking at how the "read-value" displays the value (hexadecimal without
> the 0x prefix), your quick solution seems at least consistent.
>
> Could you send a patch for this?

Well we using base 0 so it could auto detect the base, but then
limiting the input to only 2 digits makes it impossible to use 0x to
trigger hexadecimals conversions. Maybe we could allow any arbitrary
number of digits.


--
Luiz Augusto von Dentz